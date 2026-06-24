import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/widgets/navbar/nav_item.dart';

class LiquidGlassNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;
  final List<NavItem> items;

  const LiquidGlassNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bottomPad = MediaQuery.paddingOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, bottomPad + 15.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.r),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        Colors.white.withValues(alpha: 0.14),
                        Colors.white.withValues(alpha: 0.04),
                        Colors.transparent,
                      ]
                    : [
                        const Color(0xFF3b3bdb).withValues(alpha: 0.14),
                        const Color(0xFF3b3bdb).withValues(alpha: 0.05),
                        Colors.transparent,
                      ],
                stops: const [0, 0.4, 1],
              ),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.18)
                    : const Color(0xFF3b3bdb).withValues(alpha: 0.2),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.12),
                  blurRadius: 32,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int i = 0; i < items.length; i++)
                  _NavButton(
                    item: items[i],
                    isActive: selectedIndex == i,
                    onTap: () => onItemTapped(i),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final NavItem item;
  final bool isActive;
  final VoidCallback onTap;

  const _NavButton({required this.item, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final activeColor = isDark ? Colors.white : const Color(0xFF14143a);
    final inactiveColor = isDark
        ? Colors.white.withValues(alpha: 0.45)
        : const Color(0xFF14143a).withValues(alpha: 0.4);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
        scale: isActive ? 1.12 : 1.0,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 1.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: isActive
                ? (isDark
                      ? Colors.white.withValues(alpha: 0.15)
                      : const Color(0xFF3b3bdb).withValues(alpha: 0.12))
                : Colors.transparent,
            border: isActive
                ? Border.all(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.22)
                        : const Color(0xFF3b3bdb).withValues(alpha: 0.25),
                  )
                : null,
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: const Color.fromARGB(100, 31, 21, 218).withValues(alpha: 0.25),
                      blurRadius: 18,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(item.icon, size: 18.r, color: isActive ? activeColor : inactiveColor),
              SizedBox(height: 3.h),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                style: TextStyle(
                  fontSize: 7.sp,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  color: isActive ? activeColor : inactiveColor,
                  letterSpacing: 0.3,
                ),
                child: Text(item.label),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: EdgeInsets.only(top: 4.h),
                width: isActive ? 4.r : 0,
                height: isActive ? 4.r : 0,
                decoration: BoxDecoration(
                  color: activeColor.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
