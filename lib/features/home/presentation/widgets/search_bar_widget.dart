import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = theme.colorScheme.onSurface;
    final tint = isDark ? Colors.white : const Color(0xFF3b3bdb);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      height: 48.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: tint.withValues(alpha: _isExpanded ? 0.1 : 0.05),
        border: Border.all(color: tint.withValues(alpha: _isExpanded ? 0.2 : 0.08)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: FaIcon(
                FontAwesomeIcons.magnifyingGlass,
                size: 16.r,
                color: textColor.withValues(alpha: 0.6),
              ),
            ),
          ),
          if (_isExpanded)
            Expanded(
              child: TextField(
                autofocus: true,
                style: TextStyle(color: textColor, fontSize: 13.sp),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'جستجو...',
                  hintStyle: TextStyle(color: textColor.withValues(alpha: 0.3), fontSize: 13.sp),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
