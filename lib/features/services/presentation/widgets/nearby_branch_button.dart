import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NearbyBranchButton extends StatefulWidget {
  const NearbyBranchButton({super.key});

  @override
  State<NearbyBranchButton> createState() => _NearbyBranchButtonState();
}

class _NearbyBranchButtonState extends State<NearbyBranchButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);
    _pulse = Tween<double>(
      begin: 1.0,
      end: 1.03,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, child) => Transform.scale(scale: _pulse.value, child: child),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: double.infinity,
          height: 90.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            gradient: isDark
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF2b2bbb), Color(0xFF1a1a7a)],
                  )
                : const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF3b3bdb), Color(0xFF2424a0)],
                  ),
            border: Border.all(color: Colors.white.withValues(alpha: isDark ? 0.15 : 0.2)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF3b3bdb).withValues(alpha: isDark ? 0.4 : 0.25),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 48.r,
                  height: 48.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.12),
                  ),
                  child: Center(
                    child: FaIcon(FontAwesomeIcons.locationDot, size: 22.r, color: Colors.white),
                  ),
                ),
                SizedBox(width: 16.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'شعب اطراف من',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'یافتن نزدیک‌ترین شعبه و خودپرداز',
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 11.sp),
                    ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: FaIcon(
                    FontAwesomeIcons.chevronLeft,
                    size: 14.r,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
