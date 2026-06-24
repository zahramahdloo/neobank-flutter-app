import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

import '../../domain/usecase/sign_in_usecase.dart';
import '../../domain/usecase/sign_up_usecase.dart';
import './auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;

  AuthCubit({required this.signInUseCase, required this.signUpUseCase}) : super(AuthInitial());

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthLoading());

    try {
      await signInUseCase(email: email, password: password);

      emit(AuthSuccess());
    } catch (e, stackTrace) {
      if (kDebugMode) {
        debugPrint('SIGN IN ERROR: $e');
        debugPrint('SIGN IN STACK: $stackTrace');
      }

      emit(AuthError(_mapError(e)));
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    emit(AuthLoading());

    try {
      await signUpUseCase(email: email, password: password, fullName: fullName);

      emit(AuthSuccess());
    } catch (e, stackTrace) {
      if (kDebugMode) {
        debugPrint('SIGN UP ERROR: $e');
        debugPrint('SIGN UP STACK: $stackTrace');
      }

      emit(AuthError(_mapError(e)));
    }
  }

  String _mapError(Object error) {
    if (error is AuthException) {
      final msg = error.message.toLowerCase();

      if (msg.contains('invalid login credentials') ||
          msg.contains('invalid login') ||
          msg.contains('invalid credentials') ||
          msg.contains('invalid email or password')) {
        return 'ایمیل یا رمز عبور اشتباه است.';
      }

      if (msg.contains('rate limit') || msg.contains('security purposes')) {
        return 'لطفاً چند ثانیه صبر کنید و دوباره تلاش کنید.';
      }

      if (msg.contains('already registered') ||
          msg.contains('already been registered') ||
          msg.contains('user already registered') ||
          msg.contains('email already')) {
        return 'این ایمیل قبلاً ثبت‌نام شده است.';
      }

      if (msg.contains('email not confirmed')) {
        return 'ایمیل شما هنوز تأیید نشده است.';
      }

      if (msg.contains('password should be at least') ||
          msg.contains('weak password') ||
          msg.contains('password')) {
        return 'رمز عبور معتبر نیست.';
      }

      if (msg.contains('invalid email') || msg.contains('unable to validate email address')) {
        return 'ایمیل وارد شده معتبر نیست.';
      }

      return 'خطایی در احراز هویت رخ داد. لطفاً دوباره تلاش کنید.';
    }

    if (error is PostgrestException) {
      return 'خطا در ذخیره اطلاعات کاربر. لطفاً دوباره تلاش کنید.';
    }

    return 'خطایی رخ داد. لطفاً دوباره تلاش کنید.';
  }
}
