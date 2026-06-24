import 'package:flutter/material.dart';

class FrontCard extends StatelessWidget {
  const FrontCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = theme.colorScheme.onSurface;

    return Container(
      width: 300,
      height: 180,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF111111) : theme.colorScheme.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.10)
              : theme.colorScheme.primary.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_balance,
            color: isDark ? Colors.white : theme.colorScheme.primary,
            size: 40,
          ),
          const SizedBox(height: 12),
          Text(
            "نئو بانک",
            style: TextStyle(color: textColor, fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class BackCard extends StatelessWidget {
  const BackCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : theme.colorScheme.onSurface;

    return Container(
      width: 300,
      height: 180,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? const [Color(0xFF14213D), Color(0xFF1D3557)]
              : [
                  theme.colorScheme.primary.withValues(alpha: 0.16),
                  theme.colorScheme.primary.withValues(alpha: 0.07),
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.10)
              : theme.colorScheme.primary.withValues(alpha: 0.14),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.auto_awesome,
                color: isDark ? Colors.white : theme.colorScheme.primary,
                size: 32,
              ),
              const SizedBox(height: 12),
              Text(
                "راهی هوشمند برای مدیریت مالی شما",
                textAlign: TextAlign.center,
                style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
