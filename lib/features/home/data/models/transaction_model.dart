import '../../domain/entities/transaction_entity.dart';

class TransactionModel {
  final String id;
  final String title;
  final int amount;
  final String type;
  final DateTime date;
  final String icon;

  const TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
    required this.icon,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'].toString(),
      title: json['title']?.toString() ?? '',
      amount: _readMoney(json['amount']),
      type: json['type']?.toString() ?? 'debit',
      date: _readDate(json['date']),
      icon: json['icon']?.toString() ?? 'unknown',
    );
  }

  TransactionEntity toEntity() {
    return TransactionEntity(
      id: id,
      title: title,
      amount: amount,
      type: _mapType(type),
      date: date,
      icon: _mapIcon(icon),
    );
  }

  static int _readMoney(dynamic value) {
    if (value == null) return 0;

    if (value is int) return value;
    if (value is double) return value.round();
    if (value is num) return value.round();

    return int.tryParse(value.toString()) ?? 0;
  }

  static DateTime _readDate(dynamic value) {
    if (value == null) return DateTime.fromMillisecondsSinceEpoch(0);

    return DateTime.tryParse(value.toString()) ?? DateTime.fromMillisecondsSinceEpoch(0);
  }

  static TransactionType _mapType(String value) {
    switch (value.toLowerCase()) {
      case 'credit':
        return TransactionType.credit;
      case 'debit':
        return TransactionType.debit;
      default:
        return TransactionType.debit;
    }
  }

  static TransactionIconType _mapIcon(String value) {
    switch (value.toLowerCase()) {
      case 'shopping':
        return TransactionIconType.shopping;
      case 'transfer':
        return TransactionIconType.transfer;
      case 'deposit':
        return TransactionIconType.deposit;
      case 'bill':
        return TransactionIconType.bill;
      case 'interest':
        return TransactionIconType.interest;
      default:
        return TransactionIconType.unknown;
    }
  }
}
