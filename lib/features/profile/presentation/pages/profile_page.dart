import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/cubit/theme_cubit.dart';
import '../../../../core/widgets/app_bar/neo_app_bar.dart';
import '.././../../home/presentation/cubit/home_cubit.dart';
import '../../../home/presentation/cubit/home_state.dart';
import '../../widgets/profile_header.dart';
import '../../widgets/profile_menu_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isDark = themeMode == ThemeMode.dark;
        final localTheme = isDark ? AppTheme.darkTheme : AppTheme.lightTheme;

        return Theme(
          data: localTheme,
          child: Builder(
            builder: (context) {
              final theme = Theme.of(context);

              return Scaffold(
                key: ValueKey('profile-$themeMode'),
                backgroundColor: theme.scaffoldBackgroundColor,
                body: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    final name = state is HomeLoaded && state.accounts.isNotEmpty
                        ? state.accounts.first.ownerName
                        : 'کاربر';

                    final cardNumber = state is HomeLoaded && state.accounts.isNotEmpty
                        ? state.accounts.first.cardNumber
                        : '----';

                    return CustomScrollView(
                      slivers: [
                        const NeoAppBar(),

                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 120.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ProfileHeader(name: name, cardNumber: cardNumber),

                                SizedBox(height: 28.h),

                                const _SectionTitle(title: 'تنظیمات'),
                                SizedBox(height: 8.h),

                                _MenuCard(
                                  children: [
                                    ProfileMenuItem(
                                      icon: FontAwesomeIcons.bell,
                                      title: 'اعلان‌ها',
                                      subtitle: 'مدیریت اعلان‌های بانکی',
                                      onTap: () {},
                                    ),
                                    ProfileMenuItem(
                                      icon: FontAwesomeIcons.shieldHalved,
                                      title: 'امنیت',
                                      subtitle: 'رمز عبور و احراز هویت',
                                      onTap: () {},
                                    ),
                                    ProfileMenuItem(
                                      icon: FontAwesomeIcons.language,
                                      title: 'زبان و منطقه',
                                      subtitle: 'فارسی',
                                      onTap: () {},
                                      showDivider: false,
                                    ),
                                  ],
                                ),

                                SizedBox(height: 20.h),

                                const _SectionTitle(title: 'پشتیبانی'),
                                SizedBox(height: 8.h),

                                _MenuCard(
                                  children: [
                                    ProfileMenuItem(
                                      icon: FontAwesomeIcons.paperPlane,
                                      title: 'ارسال پیشنهاد',
                                      subtitle: 'ایده‌هات رو با ما در میان بذار',
                                      onTap: () {},
                                    ),
                                    ProfileMenuItem(
                                      icon: FontAwesomeIcons.circleInfo,
                                      title: 'درباره ما',
                                      subtitle: 'نسخه ۱.۰.۰',
                                      onTap: () {},
                                    ),
                                    ProfileMenuItem(
                                      icon: FontAwesomeIcons.newspaper,
                                      title: 'تغییرات همراه بانک',
                                      subtitle: 'آخرین به‌روزرسانی‌ها',
                                      onTap: () {},
                                      showDivider: false,
                                    ),
                                  ],
                                ),

                                SizedBox(height: 20.h),

                                _MenuCard(
                                  children: [
                                    ProfileMenuItem(
                                      icon: FontAwesomeIcons.rightFromBracket,
                                      title: 'خروج از حساب کاربری',
                                      titleColor: Colors.redAccent,
                                      iconColor: Colors.redAccent,
                                      onTap: () => _showLogoutDialog(context),
                                      showDivider: false,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final theme = Theme.of(context);

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black.withValues(alpha: 0.6),
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, animation, _, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      pageBuilder: (context, _, _) {
        return Theme(
          data: theme,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: EdgeInsets.all(24.r),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: theme.colorScheme.onSurface.withValues(alpha: 0.1)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 56.r,
                        height: 56.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red.withValues(alpha: 0.1),
                        ),
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.rightFromBracket,
                            color: Colors.redAccent,
                            size: 22.r,
                          ),
                        ),
                      ),

                      SizedBox(height: 16.h),

                      Text(
                        'خروج از حساب',
                        style: TextStyle(
                          color: theme.colorScheme.onSurface,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      SizedBox(height: 8.h),

                      Text(
                        'آیا مطمئنی میخوای از حسابت خارج بشی؟',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                          fontSize: 12.sp,
                        ),
                      ),

                      SizedBox(height: 24.h),

                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                height: 44.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
                                ),
                                child: Center(
                                  child: Text(
                                    'انصراف',
                                    style: TextStyle(
                                      color: theme.colorScheme.onSurface,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 12.w),

                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                Navigator.pop(context);
                                await Supabase.instance.client.auth.signOut();

                                if (context.mounted) {
                                  context.go('/login');
                                }
                              },
                              child: Container(
                                height: 44.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: Colors.red.withValues(alpha: 0.15),
                                  border: Border.all(
                                    color: Colors.redAccent.withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'خروج',
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      title,
      style: TextStyle(
        color: theme.colorScheme.onSurface.withValues(alpha: 0.45),
        fontSize: 11.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final List<Widget> children;

  const _MenuCard({required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final tint = isDark ? Colors.white : theme.colorScheme.primary;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: tint.withValues(alpha: isDark ? 0.05 : 0.06),
        border: Border.all(color: tint.withValues(alpha: isDark ? 0.08 : 0.12)),
      ),
      child: Column(children: children),
    );
  }
}
