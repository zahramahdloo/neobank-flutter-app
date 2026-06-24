import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimatedNeoLogo extends StatefulWidget {
  final double size;
  final VoidCallback? onComplete;

  const AnimatedNeoLogo({super.key, this.size = 160, this.onComplete});

  @override
  State<AnimatedNeoLogo> createState() => _AnimatedNeoLogoState();
}

class _AnimatedNeoLogoState extends State<AnimatedNeoLogo> with TickerProviderStateMixin {
  late final AnimationController _layer1Controller;
  late final AnimationController _layer2Controller;
  late final AnimationController _layer3Controller;

  late final Animation<double> _layer1Opacity;
  late final Animation<double> _layer1Slide;
  late final Animation<double> _layer2Opacity;
  late final Animation<double> _layer2Slide;
  late final Animation<double> _layer3Opacity;
  late final Animation<double> _layer3Slide;

  @override
  void initState() {
    super.initState();

    _layer1Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _layer2Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _layer3Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _layer1Opacity = CurvedAnimation(parent: _layer1Controller, curve: Curves.easeOut);
    _layer1Slide = Tween<double>(
      begin: -16,
      end: 0,
    ).animate(CurvedAnimation(parent: _layer1Controller, curve: Curves.easeOutCubic));

    _layer2Opacity = CurvedAnimation(parent: _layer2Controller, curve: Curves.easeOut);
    _layer2Slide = Tween<double>(
      begin: -16,
      end: 0,
    ).animate(CurvedAnimation(parent: _layer2Controller, curve: Curves.easeOutCubic));

    _layer3Opacity = CurvedAnimation(parent: _layer3Controller, curve: Curves.easeOut);
    _layer3Slide = Tween<double>(
      begin: -16,
      end: 0,
    ).animate(CurvedAnimation(parent: _layer3Controller, curve: Curves.easeOutCubic));

    _playSequence();
  }

  Future<void> _playSequence() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;
    await _layer1Controller.forward();

    await Future.delayed(const Duration(milliseconds: 150));
    if (!mounted) return;
    await _layer2Controller.forward();

    await Future.delayed(const Duration(milliseconds: 150));
    if (!mounted) return;
    await _layer3Controller.forward();

    await Future.delayed(const Duration(milliseconds: 300));
    widget.onComplete?.call();
  }

  @override
  void dispose() {
    _layer1Controller.dispose();
    _layer2Controller.dispose();
    _layer3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _layer1Controller,
            builder: (context, child) => Opacity(
              opacity: _layer1Opacity.value,
              child: Transform.translate(offset: Offset(0, _layer1Slide.value), child: child),
            ),
            child: SvgPicture.asset('assets/logo/layer_1_back.svg', width: widget.size),
          ),
          AnimatedBuilder(
            animation: _layer2Controller,
            builder: (context, child) => Opacity(
              opacity: _layer2Opacity.value,
              child: Transform.translate(offset: Offset(0, _layer2Slide.value), child: child),
            ),
            child: SvgPicture.asset('assets/logo/layer_2_middle.svg', width: widget.size),
          ),
          AnimatedBuilder(
            animation: _layer3Controller,
            builder: (context, child) => Opacity(
              opacity: _layer3Opacity.value,
              child: Transform.translate(offset: Offset(0, _layer3Slide.value), child: child),
            ),
            child: SvgPicture.asset('assets/logo/layer_3_front.svg', width: widget.size),
          ),
        ],
      ),
    );
  }
}
