import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void showHelpBottomSheet(BuildContext context) {
  final theme = Theme.of(context);
  showModalBottomSheet(
    context: context,
    backgroundColor: theme.colorScheme.surface,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24.r))),
    builder: (_) => const _HelpSheet(),
  );
}

class _HelpSheet extends StatelessWidget {
  const _HelpSheet();

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'icon': FontAwesomeIcons.circleQuestion,
        'title': 'سوالات متداول',
        'subtitle': 'پاسخ سوالات رایج را اینجا بیابید',
      },
      {
        'icon': FontAwesomeIcons.comments,
        'title': 'گفتگو با پشتیبانی',
        'subtitle': 'ارتباط مستقیم با تیم پشتیبانی',
      },
      {
        'icon': FontAwesomeIcons.video,
        'title': 'آموزش تصویری',
        'subtitle': 'راهنمای استفاده از امکانات',
      },
    ];

    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: textColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'چطور میتونیم کمک کنیم؟',
              style: TextStyle(color: textColor, fontSize: 16.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 20.h),
            ...items.map(
              (item) => _HelpItem(
                icon: item['icon'] as FaIconData,
                title: item['title'] as String,
                subtitle: item['subtitle'] as String,
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}

class _HelpItem extends StatelessWidget {
  final FaIconData icon;
  final String title;
  final String subtitle;

  const _HelpItem({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = theme.colorScheme.onSurface;

    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : const Color(0xFF3b3bdb).withValues(alpha: 0.05),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.1)
                : const Color(0xFF3b3bdb).withValues(alpha: 0.1),
          ),
        ),
        child: Row(
          children: [
            FaIcon(icon, color: textColor, size: 20.r),
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: textColor, fontSize: 13.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(color: textColor.withValues(alpha: 0.5), fontSize: 11.sp),
                ),
              ],
            ),
            const Spacer(),
            FaIcon(
              FontAwesomeIcons.chevronLeft,
              color: textColor.withValues(alpha: 0.3),
              size: 14.r,
            ),
          ],
        ),
      ),
    );
  }
}
