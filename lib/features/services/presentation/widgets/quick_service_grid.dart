import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QuickServiceGrid extends StatelessWidget {
  const QuickServiceGrid({super.key});

  static const List<Map<String, dynamic>> _services = [
    {'icon': FontAwesomeIcons.key, 'label': 'رمز پویا'},
    {'icon': FontAwesomeIcons.clockRotateLeft, 'label': 'سوابق پرداخت'},
    {'icon': FontAwesomeIcons.moneyCheckDollar, 'label': 'چک'},
    {'icon': FontAwesomeIcons.handHoldingDollar, 'label': 'تسهیلات'},
    {'icon': FontAwesomeIcons.rightLeft, 'label': 'تبدیل‌ها'},
    {'icon': FontAwesomeIcons.chartPie, 'label': 'گزارش‌ها'},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1.0,
      ),
      itemCount: _services.length,
      itemBuilder: (context, index) => _ServiceItem(
        icon: _services[index]['icon'] as FaIconData,
        label: _services[index]['label'] as String,
        index: index,
      ),
    );
  }
}

class _ServiceItem extends StatefulWidget {
  final FaIconData icon;
  final String label;
  final int index;

  const _ServiceItem({required this.icon, required this.label, required this.index});

  @override
  State<_ServiceItem> createState() => _ServiceItemState();
}

class _ServiceItemState extends State<_ServiceItem> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400 + widget.index * 80),
    );
    _scale = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    Future.delayed(Duration(milliseconds: widget.index * 60), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = theme.colorScheme.onSurface;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Opacity(
        opacity: _opacity.value,
        child: Transform.scale(scale: _scale.value, child: child),
      ),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            color: isDark
                ? Colors.white.withValues(alpha: 0.06)
                : const Color(0xFF3b3bdb).withValues(alpha: 0.06),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.1)
                  : const Color(0xFF3b3bdb).withValues(alpha: 0.12),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 44.r,
                height: 44.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : const Color(0xFF3b3bdb).withValues(alpha: 0.1),
                ),
                child: Center(
                  child: FaIcon(widget.icon, size: 18.r, color: textColor.withValues(alpha: 0.85)),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                widget.label,
                style: TextStyle(
                  color: textColor.withValues(alpha: 0.8),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
