import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String cardNumber;

  const ProfileHeader({super.key, required this.name, required this.cardNumber});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = theme.colorScheme.onSurface;
    final tint = isDark ? Colors.white : const Color(0xFF3b3bdb);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: tint.withValues(alpha: isDark ? 0.06 : 0.07),
        border: Border.all(color: tint.withValues(alpha: isDark ? 0.10 : 0.12)),
      ),
      child: Row(
        children: [
          Container(
            width: 58.r,
            height: 58.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: tint.withValues(alpha: isDark ? 0.10 : 0.12),
              border: Border.all(color: tint.withValues(alpha: isDark ? 0.12 : 0.16)),
            ),
            child: Center(
              child: FaIcon(FontAwesomeIcons.user, color: textColor, size: 22.r),
            ),
          ),

          SizedBox(width: 14.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: textColor, fontSize: 16.sp, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 6.h),
                Text(
                  cardNumber,
                  style: TextStyle(
                    color: textColor.withValues(alpha: 0.55),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
