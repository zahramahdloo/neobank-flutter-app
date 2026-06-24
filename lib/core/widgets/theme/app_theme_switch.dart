import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../theme/cubit/theme_cubit.dart';
import '../../theme/app_colors.dart';

class AppThemeSwitch extends StatelessWidget {
  const AppThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, mode) {
        final isDark = mode == ThemeMode.dark; // ✅ از mode میاد

        return Semantics(
          button: true,
          label: isDark ? 'تغییر به حالت روشن' : 'تغییر به حالت تیره',
          child: InkWell(
            borderRadius: BorderRadius.circular(12.r),
            onTap: () => context.read<ThemeCubit>().toggleTheme(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: isDark ? AppColors.glassWhite(0.08) : Colors.black.withValues(alpha: 0.04),
                border: Border.all(
                  color: isDark ? AppColors.glassWhite(0.12) : Colors.black.withValues(alpha: 0.08),
                ),
              ),
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) => RotationTransition(
                    turns: animation,
                    child: ScaleTransition(scale: animation, child: child),
                  ),
                  child: FaIcon(
                    isDark ? FontAwesomeIcons.moon : FontAwesomeIcons.sun,
                    key: ValueKey(isDark),
                    size: 16.r,
                    color: isDark ? Colors.white.withValues(alpha: 0.85) : const Color(0xFFf5a623),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
