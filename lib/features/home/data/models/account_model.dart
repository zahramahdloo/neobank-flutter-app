import '../../domain/entities/account_entity.dart';

class AccountModel {
  final String id;
  final String ownerName;
  final String cardNumber;
  final int balance;
  final String bankName;

  const AccountModel({
    required this.id,
    required this.ownerName,
    required this.cardNumber,
    required this.balance,
    required this.bankName,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['id'].toString(),
      ownerName: json['owner_name']?.toString() ?? '',
      cardNumber: json['card_number']?.toString() ?? '',
      balance: _readMoney(json['balance']),
      bankName: json['bank_name']?.toString() ?? '',
    );
  }

  AccountEntity toEntity() {
    return AccountEntity(
      id: id,
      ownerName: ownerName,
      cardNumber: cardNumber,
      balance: balance,
      bankName: bankName,
    );
  }

  static int _readMoney(dynamic value) {
    if (value == null) return 0;

    if (value is int) return value;
    if (value is double) return value.round();
    if (value is num) return value.round();

    return int.tryParse(value.toString()) ?? 0;
  }
}
