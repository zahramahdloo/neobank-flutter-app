import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neo_bank/core/widgets/app_bar/neo_app_bar.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/dependency_injection/injection.dart';
import '../../../../core/widgets/theme/app_theme_switch.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/balance_card.dart';
import '../widgets/help_bottom_sheet.dart';
import '../widgets/quick_actions.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/transaction_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => sl<HomeCubit>()..loadData(), child: const _HomeView());
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = theme.colorScheme.onSurface;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading || state is HomeInitial) {
            return Center(
              child: CircularProgressIndicator(
                color: isDark ? AppColors.white : AppColors.primaryBlue,
              ),
            );
          }

          if (state is HomeError) {
            return _HomeErrorView(message: state.message);
          }

          if (state is HomeLoaded) {
            if (state.accounts.isEmpty) {
              return Center(
                child: Text(
                  'هیچ حسابی یافت نشد',
                  style: TextStyle(color: textColor, fontSize: 14.sp, fontWeight: FontWeight.w500),
                ),
              );
            }

            final account = state.accounts.first;
            final transactions = state.transactions;

            return SafeArea(
              child: RefreshIndicator(
                color: AppColors.primaryBlue,
                backgroundColor: theme.colorScheme.surface,
                onRefresh: () => context.read<HomeCubit>().loadData(),
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    const NeoAppBar(),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _Header(ownerName: account.ownerName),
                            SizedBox(height: 20.h),
                            const SearchBarWidget(),
                            SizedBox(height: 24.h),
                            BalanceCard(account: account),
                            SizedBox(height: 24.h),
                            const QuickActions(),
                            SizedBox(height: 24.h),
                            _TransactionsHeader(state: state),
                            SizedBox(height: 16.h),
                          ],
                        ),
                      ),
                    ),
                    if (transactions.isEmpty)
                      SliverToBoxAdapter(child: _EmptyTransactionsView(isDark: isDark))
                    else
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 120.h),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate((context, index) {
                            return TransactionItem(transaction: transactions[index]);
                          }, childCount: transactions.length),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String ownerName;

  const _Header({required this.ownerName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = theme.colorScheme.onSurface;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'خوش اومدی 👋',
                style: TextStyle(
                  color: textColor.withValues(alpha: isDark ? 0.6 : 0.55),
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                ownerName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: textColor, fontSize: 18.sp, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppThemeSwitch(),
            SizedBox(width: 10.w),
            Semantics(
              button: true,
              label: 'راهنما',
              child: InkWell(
                borderRadius: BorderRadius.circular(12.r),
                onTap: () => showHelpBottomSheet(context),
                child: Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: isDark
                        ? AppColors.glassWhite(0.08)
                        : Colors.black.withValues(alpha: 0.04),
                    border: Border.all(
                      color: isDark
                          ? AppColors.glassWhite(0.12)
                          : Colors.black.withValues(alpha: 0.08),
                    ),
                  ),
                  child: Center(
                    child: FaIcon(
                      FontAwesomeIcons.circleQuestion,
                      size: 18.r,
                      color: textColor.withValues(alpha: 0.75),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TransactionsHeader extends StatelessWidget {
  final HomeLoaded state;

  const _TransactionsHeader({required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = theme.colorScheme.onSurface;
    final activeAction = state.activeAction;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          activeAction != null ? 'تراکنش‌های ${activeAction.label}' : 'آخرین تراکنش‌ها',
          style: TextStyle(color: textColor, fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        if (activeAction != null)
          InkWell(
            borderRadius: BorderRadius.circular(8.r),
            onTap: () => context.read<HomeCubit>().clearFilter(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              child: Text(
                'حذف فیلتر',
                style: TextStyle(
                  color: textColor.withValues(alpha: isDark ? 0.5 : 0.55),
                  fontSize: 12.sp,
                ),
              ),
            ),
          )
        else
          Text(
            'مشاهده همه',
            style: TextStyle(
              color: textColor.withValues(alpha: isDark ? 0.4 : 0.5),
              fontSize: 12.sp,
            ),
          ),
      ],
    );
  }
}

class _EmptyTransactionsView extends StatelessWidget {
  final bool isDark;

  const _EmptyTransactionsView({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: Text(
        'تراکنشی برای نمایش وجود ندارد',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor.withValues(alpha: isDark ? 0.6 : 0.55),
          fontSize: 13.sp,
        ),
      ),
    );
  }
}

class _HomeErrorView extends StatelessWidget {
  final String message;

  const _HomeErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = theme.colorScheme.onSurface;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FaIcon(FontAwesomeIcons.circleExclamation, color: AppColors.error, size: 48),
            SizedBox(height: 16.h),
            Text(
              'خطا در بارگذاری',
              style: TextStyle(color: textColor, fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor.withValues(alpha: isDark ? 0.6 : 0.55),
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 16.h),
            TextButton(
              onPressed: () => context.read<HomeCubit>().loadData(),
              child: const Text('تلاش مجدد'),
            ),
          ],
        ),
      ),
    );
  }
}
