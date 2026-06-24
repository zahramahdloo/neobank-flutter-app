import '../../../../core/utils/result.dart';
import '../entities/account_entity.dart';
import '../entities/transaction_entity.dart';

abstract class BankRepository {
  Future<Result<List<AccountEntity>>> getAccounts();

  Future<Result<List<TransactionEntity>>> getTransactions();
}
