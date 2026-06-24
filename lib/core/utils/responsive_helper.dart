import 'package:flutter/material.dart';

/// Breakpoints
class Breakpoints {
  Breakpoints._();
  static const double mobileS = 320; // iPhone SE
  static const double mobileM = 375; // iPhone 14
  static const double mobileL = 414; // iPhone Plus
  static const double tablet = 768; // iPad
  static const double desktop = 1024;
}

/// Helper
class Responsive {
  Responsive._();

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < Breakpoints.tablet;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= Breakpoints.tablet &&
      MediaQuery.sizeOf(context).width < Breakpoints.desktop;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= Breakpoints.desktop;

  static bool isSmallPhone(BuildContext context) =>
      MediaQuery.sizeOf(context).width <= Breakpoints.mobileS;

  static bool isLandscape(BuildContext context) =>
      MediaQuery.orientationOf(context) == Orientation.landscape;

  /// مقدار مختلف بر اساس دستگاه برگردون
  /// مثال: Responsive.value(context, mobile: 16, tablet: 24, desktop: 32)
  static T value<T>(BuildContext context, {required T mobile, T? tablet, T? desktop}) {
    if (isDesktop(context)) return desktop ?? tablet ?? mobile;
    if (isTablet(context)) return tablet ?? mobile;
    return mobile;
  }

  /// تعداد ستون برای Grid
  static int gridColumns(BuildContext context) {
    if (isDesktop(context)) return 4;
    if (isTablet(context)) return 3;
    if (isLandscape(context)) return 3;
    return 2;
  }
}

/// Widget که layout رو بر اساس دستگاه عوض میکنه
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({super.key, required this.mobile, this.tablet, this.desktop});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) return desktop ?? tablet ?? mobile;
    if (Responsive.isTablet(context)) return tablet ?? mobile;
    return mobile;
  }
}
