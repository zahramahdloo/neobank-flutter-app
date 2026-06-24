import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SavedListsCard extends StatelessWidget {
  const SavedListsCard({super.key});

  static const List<Map<String, dynamic>> _items = [
    {'icon': FontAwesomeIcons.creditCard, 'label': 'کارت‌ها'},
    {'icon': FontAwesomeIcons.buildingColumns, 'label': 'حساب‌ها'},
    {'icon': FontAwesomeIcons.moneyBillTransfer, 'label': 'شبا‌ها'},
    {'icon': FontAwesomeIcons.fileInvoiceDollar, 'label': 'قبض‌ها'},
    {'icon': FontAwesomeIcons.car, 'label': 'پلاک‌ها'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : const Color(0xFF3b3bdb).withValues(alpha: 0.05),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : const Color(0xFF3b3bdb).withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: List.generate(
          _items.length,
          (index) => _SavedListItem(
            icon: _items[index]['icon'] as FaIconData,
            label: _items[index]['label'] as String,
            showDivider: index < _items.length - 1,
          ),
        ),
      ),
    );
  }
}

class _SavedListItem extends StatelessWidget {
  final FaIconData icon;
  final String label;
  final bool showDivider;

  const _SavedListItem({required this.icon, required this.label, required this.showDivider});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = theme.colorScheme.onSurface;

    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            child: Row(
              children: [
                Container(
                  width: 38.r,
                  height: 38.r,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : const Color(0xFF3b3bdb).withValues(alpha: 0.08),
                  ),
                  child: Center(
                    child: FaIcon(icon, size: 15.r, color: textColor.withValues(alpha: 0.7)),
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                FaIcon(
                  FontAwesomeIcons.chevronLeft,
                  size: 12.r,
                  color: textColor.withValues(alpha: 0.3),
                ),
              ],
            ),
          ),
        ),
        if (showDivider) Divider(color: textColor.withValues(alpha: 0.06), height: 1),
      ],
    );
  }
}
