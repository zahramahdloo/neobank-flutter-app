import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../domain/entities/account_entity.dart';

class BalanceCard extends StatelessWidget {
  final AccountEntity account;

  const BalanceCard({super.key, required this.account});

  String _formatBalance(int balance) {
    final text = balance.toString();

    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      final position = text.length - i;

      buffer.write(text[i]);

      if (position > 1 && position % 3 == 1) {
        buffer.write(',');
      }
    }

    return '${buffer.toString()} تومان';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        gradient: isDark
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1a1a6e), Color(0xFF0d0d4a)],
              )
            : const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF3b3bdb), Color(0xFF2424a0)],
              ),
        border: Border.all(color: Colors.white.withValues(alpha: isDark ? 0.1 : 0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.15),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                account.bankName,
                style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12.sp),
              ),
              const FaIcon(FontAwesomeIcons.creditCard, color: Colors.white, size: 20),
            ],
          ),
          SizedBox(height: 24.h),
          Text(
            _formatBalance(account.balance),
            style: TextStyle(color: Colors.white, fontSize: 26.sp, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 4.h),
          Text(
            'موجودی حساب',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 11.sp),
          ),
          SizedBox(height: 24.h),
          Text(
            account.cardNumber,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 14.sp,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            account.ownerName,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}
