import 'package:equatable/equatable.dart';

import '../../domain/entities/account_entity.dart';
import '../../domain/entities/transaction_entity.dart';

enum HomeQuickAction { deposit, withdraw, transfer, shopping, interest }

extension HomeQuickActionX on HomeQuickAction {
  String get label {
    switch (this) {
      case HomeQuickAction.deposit:
        return 'واریز';
      case HomeQuickAction.withdraw:
        return 'دریافت';
      case HomeQuickAction.transfer:
        return 'انتقال';
      case HomeQuickAction.shopping:
        return 'خرید';
      case HomeQuickAction.interest:
        return 'سود بانکی';
    }
  }

  TransactionIconType get iconFilter {
    switch (this) {
      case HomeQuickAction.deposit:
        return TransactionIconType.deposit;
      case HomeQuickAction.withdraw:
        return TransactionIconType.deposit;
      case HomeQuickAction.transfer:
        return TransactionIconType.transfer;
      case HomeQuickAction.shopping:
        return TransactionIconType.shopping;
      case HomeQuickAction.interest:
        return TransactionIconType.interest;
    }
  }
}

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<AccountEntity> accounts;
  final List<TransactionEntity> allTransactions;
  final HomeQuickAction? activeAction;

  const HomeLoaded({required this.accounts, required this.allTransactions, this.activeAction});

  List<TransactionEntity> get transactions {
    if (activeAction == null) return allTransactions;

    return allTransactions
        .where((transaction) => transaction.icon == activeAction!.iconFilter)
        .toList();
  }

  HomeLoaded copyWith({
    List<AccountEntity>? accounts,
    List<TransactionEntity>? allTransactions,
    HomeQuickAction? activeAction,
    bool clearFilter = false,
  }) {
    return HomeLoaded(
      accounts: accounts ?? this.accounts,
      allTransactions: allTransactions ?? this.allTransactions,
      activeAction: clearFilter ? null : activeAction ?? this.activeAction,
    );
  }

  @override
  List<Object?> get props => [accounts, allTransactions, activeAction];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
