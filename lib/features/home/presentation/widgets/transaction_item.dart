import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/transaction_entity.dart';

class TransactionItem extends StatelessWidget {
  final TransactionEntity transaction;

  const TransactionItem({super.key, required this.transaction});

  FaIconData _getIcon(TransactionIconType icon) {
    switch (icon) {
      case TransactionIconType.shopping:
        return FontAwesomeIcons.cartShopping;
      case TransactionIconType.transfer:
        return FontAwesomeIcons.arrowRightArrowLeft;
      case TransactionIconType.deposit:
        return FontAwesomeIcons.arrowDown;
      case TransactionIconType.bill:
        return FontAwesomeIcons.fileInvoice;
      case TransactionIconType.interest:
        return FontAwesomeIcons.percent;
      case TransactionIconType.unknown:
        return FontAwesomeIcons.moneyBill;
    }
  }

  String _formatAmount(int amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)} میلیون';
    }
    return '$amount تومان';
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy/MM/dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = theme.colorScheme.onSurface;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : const Color(0xFF3b3bdb).withValues(alpha: 0.05),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : const Color(0xFF3b3bdb).withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: transaction.isCredit
                  ? Colors.green.withValues(alpha: 0.15)
                  : Colors.red.withValues(alpha: 0.15),
            ),
            child: Center(
              child: FaIcon(
                _getIcon(transaction.icon),
                size: 18.r,
                color: transaction.isCredit ? Colors.green : Colors.redAccent,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: TextStyle(color: textColor, fontSize: 13.sp, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 4.h),
                Text(
                  _formatDate(transaction.date),
                  style: TextStyle(color: textColor.withValues(alpha: 0.4), fontSize: 11.sp),
                ),
              ],
            ),
          ),
          Text(
            '${transaction.isCredit ? '+' : '-'} ${_formatAmount(transaction.amount)}',
            style: TextStyle(
              color: transaction.isCredit ? Colors.green : Colors.redAccent,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
