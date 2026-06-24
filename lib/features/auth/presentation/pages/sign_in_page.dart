import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/dependency_injection/injection.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => sl<AuthCubit>(), child: const _LoginView());
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // پشت صحنه نام کاربری رو به ایمیل تبدیل می‌کنیم
      final email = '${_usernameController.text.trim().toLowerCase()}@neobank.ir';
      context.read<AuthCubit>().signIn(email: email, password: _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070357),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.go('/home');
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.redAccent),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 24.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'نئو',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 4,
                      ),
                    ),
                    SizedBox(height: 32.h),

                    Text(
                      'خوش اومدی 👋',
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12.sp),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'ورود به حساب بانکی',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'نام کاربری و رمز عبور خود را وارد کنید.',
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 13.sp),
                    ),

                    SizedBox(height: 40.h),

                    Center(
                      child: Container(
                        width: 96.r,
                        height: 96.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.08),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                        ),
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.lock,
                            size: 32.r,
                            color: Colors.white.withValues(alpha: 0.85),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 40.h),

                    _buildField(
                      controller: _usernameController,
                      hint: 'نام کاربری (مثلاً: sara)',
                      icon: FontAwesomeIcons.user,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'نام کاربری را وارد کنید';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 14.h),
                    _buildField(
                      controller: _passwordController,
                      hint: 'رمز عبور',
                      icon: FontAwesomeIcons.lock,
                      obscureText: _obscurePassword,
                      suffix: IconButton(
                        icon: FaIcon(
                          _obscurePassword ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
                          size: 16.r,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'رمز عبور باید حداقل ۶ کاراکتر باشد';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 28.h),

                    SizedBox(
                      width: double.infinity,
                      height: 52.h,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          disabledBackgroundColor: Colors.white.withValues(alpha: 0.6),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                        ),
                        child: isLoading
                            ? SizedBox(
                                width: 22.r,
                                height: 22.r,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2.4,
                                  color: Color(0xFF070357),
                                ),
                              )
                            : Text(
                                'ورود',
                                style: TextStyle(
                                  color: const Color(0xFF070357),
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ),

                    SizedBox(height: 18.h),

                    Center(
                      child: TextButton(
                        onPressed: () => context.push('/signup'),
                        child: Text.rich(
                          TextSpan(
                            text: 'حساب کاربری ندارید؟ ',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 13.sp,
                            ),
                            children: [
                              TextSpan(
                                text: 'ثبت‌نام کنید',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required FaIconData icon,
    bool obscureText = false,
    Widget? suffix,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        style: TextStyle(color: Colors.white, fontSize: 14.sp),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 13.sp),
          prefixIcon: Padding(
            padding: EdgeInsets.all(14.r),
            child: FaIcon(icon, size: 16.r, color: Colors.white.withValues(alpha: 0.5)),
          ),
          suffixIcon: suffix,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 4.w),
          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 11.sp),
        ),
      ),
    );
  }
}
