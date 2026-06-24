import 'package:equatable/equatable.dart';

class AccountEntity extends Equatable {
  final String id;
  final String ownerName;
  final String cardNumber;
  final int balance;
  final String bankName;

  const AccountEntity({
    required this.id,
    required this.ownerName,
    required this.cardNumber,
    required this.balance,
    required this.bankName,
  });

  @override
  List<Object> get props => [id, ownerName, cardNumber, balance, bankName];
}
