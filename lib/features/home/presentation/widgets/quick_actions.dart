import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  static const List<Map<String, dynamic>> _actions = [
    {'icon': FontAwesomeIcons.arrowUp, 'label': 'واریز', 'action': HomeQuickAction.deposit},
    {
      'icon': FontAwesomeIcons.arrowRightArrowLeft,
      'label': 'انتقال',
      'action': HomeQuickAction.transfer,
    },
    {'icon': FontAwesomeIcons.arrowDown, 'label': 'دریافت', 'action': HomeQuickAction.withdraw},
    {'icon': FontAwesomeIcons.percent, 'label': 'سود بانکی', 'action': HomeQuickAction.interest},
    {'icon': FontAwesomeIcons.cartShopping, 'label': 'خرید', 'action': HomeQuickAction.shopping},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        HomeQuickAction? activeAction;

        if (state is HomeLoaded) {
          activeAction = state.activeAction;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'دسترسی سریع',
              style: TextStyle(color: textColor, fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16.h),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 1.2,
              ),
              itemCount: _actions.length,
              itemBuilder: (context, index) {
                final action = _actions[index]['action'] as HomeQuickAction;

                return _ActionItem(
                  icon: _actions[index]['icon'] as FaIconData,
                  label: _actions[index]['label'] as String,
                  isSelected: activeAction == action,
                  onTap: () {
                    context.read<HomeCubit>().filterByAction(action);
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _ActionItem extends StatelessWidget {
  final FaIconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ActionItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = theme.colorScheme.onSurface;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: isSelected
              ? const Color(0xFF3B3BDB)
              : isDark
              ? Colors.white.withValues(alpha: 0.05)
              : const Color(0xFF3B3BDB).withValues(alpha: 0.06),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF3B3BDB)
                : isDark
                ? Colors.white.withValues(alpha: 0.1)
                : const Color(0xFF3B3BDB).withValues(alpha: 0.12),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(icon, color: isSelected ? Colors.white : textColor, size: 20.r),
            SizedBox(height: 8.h),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : textColor.withValues(alpha: 0.8),
                fontSize: 11.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
