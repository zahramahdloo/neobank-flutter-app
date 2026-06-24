import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ServicesAppBar extends StatelessWidget {
  const ServicesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color(0xFF070357),
      pinned: true,
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32.r,
            height: 32.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(colors: [Color(0xFF3b3bdb), Color(0xFF1a1a8c)]),
            ),
            child: Center(
              child: FaIcon(FontAwesomeIcons.buildingColumns, size: 14.r, color: Colors.white),
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            'نئو بانک',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'IRANYekan',
            ),
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(color: Colors.white.withValues(alpha: 0.06), height: 1),
      ),
    );
  }
}
