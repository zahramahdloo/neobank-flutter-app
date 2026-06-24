import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/dependency_injection/injection.dart';
import '../../../../core/theme/cubit/theme_cubit.dart';
import '../widgets/liquid_glass_navbar.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../services/presentation/pages/services_page.dart';
import '../../config/dashboard_nav_items.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  late final HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();
    _homeCubit = sl<HomeCubit>()..loadData();
  }

  @override
  void dispose() {
    _homeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _homeCubit,
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            extendBody: true,
            body: [
              const HomePage(),
              const ServicesPage(),
              const ProfilePage(),
              const SizedBox(),
            ][_selectedIndex],
            bottomNavigationBar: LiquidGlassNavBar(
              selectedIndex: _selectedIndex,
              onItemTapped: (index) => setState(() => _selectedIndex = index),
              items: dashboardNavItems,
            ),
          );
        },
      ),
    );
  }
}
