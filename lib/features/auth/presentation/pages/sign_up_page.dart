import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/dependency_injection/injection.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => sl<AuthCubit>(), child: const _SignupView());
  }
}

class _SignupView extends StatefulWidget {
  const _SignupView();

  @override
  State<_SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<_SignupView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // پشت صحنه نام کاربری رو به ایمیل تبدیل می‌کنیم
      final email = '${_usernameController.text.trim().toLowerCase()}@neobank.ir';
      context.read<AuthCubit>().signUp(
        email: email,
        password: _passwordController.text,
        fullName: _nameController.text.trim(),
      );
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
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        width: 40.r,
                        height: 40.r,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: Colors.white.withValues(alpha: 0.08),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                        ),
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.arrowRight,
                            size: 16.r,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    Text(
                      'نئو',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 4,
                      ),
                    ),
                    SizedBox(height: 28.h),

                    Text(
                      'ساخت حساب کاربری',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'برای استفاده از خدمات بانکی نئو اطلاعات زیر را تکمیل کنید.',
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 13.sp),
                    ),

                    SizedBox(height: 32.h),

                    _buildField(
                      controller: _nameController,
                      hint: 'نام و نام خانوادگی',
                      icon: FontAwesomeIcons.idCard,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'نام خود را وارد کنید';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 14.h),
                    _buildField(
                      controller: _usernameController,
                      hint: 'نام کاربری (مثلاً: sara)',
                      icon: FontAwesomeIcons.user,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'نام کاربری را وارد کنید';
                        }
                        if (value.contains(' ')) {
                          return 'نام کاربری نباید فاصله داشته باشد';
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
                    SizedBox(height: 14.h),
                    _buildField(
                      controller: _confirmController,
                      hint: 'تکرار رمز عبور',
                      icon: FontAwesomeIcons.lock,
                      obscureText: _obscureConfirm,
                      suffix: IconButton(
                        icon: FaIcon(
                          _obscureConfirm ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
                          size: 16.r,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                        onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                      ),
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'رمز عبور با تکرار آن مطابقت ندارد';
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
                                'ثبت‌نام',
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
                        onPressed: () => context.pop(),
                        child: Text.rich(
                          TextSpan(
                            text: 'قبلاً ثبت‌نام کرده‌اید؟ ',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 13.sp,
                            ),
                            children: [
                              TextSpan(
                                text: 'وارد شوید',
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
