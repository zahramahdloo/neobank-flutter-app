import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/widgets/logo/animated_neo_logo.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  void _navigate(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;
    if (session != null) {
      context.go('/home');
    } else {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070357),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedNeoLogo(size: 140.r, onComplete: () => _navigate(context)),
            SizedBox(height: 24.h),
            Text(
              'نئو بانک',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'بانکداری به سادگی یک لمس',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
