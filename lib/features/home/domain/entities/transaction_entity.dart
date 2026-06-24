import 'package:equatable/equatable.dart';

enum TransactionType { credit, debit }

enum TransactionIconType { shopping, transfer, deposit, bill, interest, unknown }

class TransactionEntity extends Equatable {
  final String id;
  final String title;
  final int amount;
  final TransactionType type;
  final DateTime date;
  final TransactionIconType icon;

  const TransactionEntity({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
    required this.icon,
  });

  bool get isCredit => type == TransactionType.credit;

  @override
  List<Object> get props => [id, title, amount, type, date, icon];
}
