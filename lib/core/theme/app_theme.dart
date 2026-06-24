import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.darkBackground,
    fontFamily: 'IRANYekan',
    colorScheme: const ColorScheme.dark(
      surface: AppColors.darkSurface,
      onSurface: Colors.white,
      primary: AppColors.primaryBlue,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
      displayMedium: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
      bodyLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
      bodySmall: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
      labelSmall: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
    ),
  );

  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.lightBackground,
    fontFamily: 'IRANYekan',
    colorScheme: const ColorScheme.light(
      surface: AppColors.lightSurface,
      onSurface: Color(0xFF14143a),
      primary: AppColors.primaryBlue,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
      displayMedium: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
      bodyLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
      bodySmall: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
      labelSmall: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
    ),
  );
}
