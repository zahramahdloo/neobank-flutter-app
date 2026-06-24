import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/app_bar/neo_app_bar.dart';
import '../widgets/quick_service_grid.dart';
import '../widgets/nearby_branch_button.dart';
import '../widgets/saved_lists_card.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          const NeoAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 120.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const QuickServiceGrid(),
                  SizedBox(height: 28.h),
                  const NearbyBranchButton(),
                  SizedBox(height: 32.h),
                  Text(
                    'مدیریت لیست‌های ذخیره شده',
                    style: TextStyle(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.35),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  const SavedListsCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
