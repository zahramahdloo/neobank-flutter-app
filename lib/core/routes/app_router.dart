import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/auth/presentation/pages/sign_in_page.dart';
import '../../features/auth/presentation/pages/sign_up_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final currentUser = Supabase.instance.client.auth.currentUser;
    final isLoggedIn = currentUser != null;

    final location = state.matchedLocation;

    final isSplash = location == '/';
    final isLogin = location == '/login';
    final isSignup = location == '/signup';
    final isHome = location == '/home';

    // Splash خودش تصمیم می‌گیرد برود Login
    if (isSplash) {
      return null;
    }

    // اگر کاربر Login نکرده باشد، حق ندارد وارد Home شود
    if (!isLoggedIn && isHome) {
      return '/login';
    }

    // اگر Login کرده باشد و دوباره Login/Signup را باز کند، بفرست Home
    if (isLoggedIn && (isLogin || isSignup)) {
      return '/home';
    }

    return null;
  },
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashPage()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/signup', builder: (context, state) => const SignupPage()),
    GoRoute(path: '/home', builder: (context, state) => const DashboardPage()),
  ],
);
