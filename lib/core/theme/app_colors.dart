import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Dark Theme ──────────────────────────────
  static const Color darkBackground = Color(0xFF070357);
  static const Color darkSurface = Color(0xFF0d0d5a);
  static const Color darkCard = Color(0xFF1a1a8c);

  // ── Light Theme ─────────────────────────────
  static const Color lightBackground = Color(0xFFF4F4FB);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFE8E8F8);

  // ── Shared ──────────────────────────────────
  static const Color primaryBlue = Color(0xFF3b3bdb);
  static const Color primaryBluePale = Color(0xFF1a1a8c);
  static const Color error = Colors.redAccent;
  static const Color success = Colors.greenAccent;
  static const Color white = Colors.white;

  static Color glassWhite(double opacity) => Colors.white.withValues(alpha: opacity);
  static Color glassBlack(double opacity) => Colors.black.withValues(alpha: opacity);
}
