import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failures.dart' show Failure;
import '../../../../core/utils/result.dart';
import '../../domain/entities/account_entity.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/usecase/get_account_usecase.dart';
import '../../domain/usecase/get_transactions_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetAccountsUseCase getAccountsUseCase;
  final GetTransactionsUseCase getTransactionsUseCase;

  HomeCubit({required this.getAccountsUseCase, required this.getTransactionsUseCase})
    : super(const HomeInitial());

  Future<void> loadData() async {
    if (isClosed) return;
    emit(HomeLoading());

    final accountsResult = await getAccountsUseCase();
    final transactionsResult = await getTransactionsUseCase();
    if (isClosed) return;

    if (accountsResult is Failure || transactionsResult is Failure) {
      final message = accountsResult is Failure
          ? (accountsResult as Failure).message
          : (transactionsResult as Failure).message;
      emit(HomeError(message));
      return;
    }

    final accounts = (accountsResult as Success<List<AccountEntity>>).data;
    final transactions = (transactionsResult as Success<List<TransactionEntity>>).data;

    emit(HomeLoaded(accounts: accounts, allTransactions: transactions));
  }

  void filterByAction(HomeQuickAction action) {
    if (isClosed) return;
    final current = state;
    if (current is! HomeLoaded) return;

    if (current.activeAction == action) {
      emit(current.copyWith(clearFilter: true));
    } else {
      emit(current.copyWith(activeAction: action));
    }
  }

  void clearFilter() {
    if (isClosed) return;
    final current = state;
    if (current is HomeLoaded) {
      emit(current.copyWith(clearFilter: true));
    }
  }
}
