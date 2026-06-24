import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NeoAppBar extends StatelessWidget {
  const NeoAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverAppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      pinned: true,
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset('assets/logo/logo_combined_transparent.svg', width: 28.r, height: 28.r),
          SizedBox(width: 8.w),
          Text(
            'نئو بانک',
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'IRANYekan',
            ),
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(color: theme.colorScheme.onSurface.withValues(alpha: 0.06), height: 1),
      ),
    );
  }
}
