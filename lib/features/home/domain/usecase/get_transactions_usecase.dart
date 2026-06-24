import '../../../../core/utils/result.dart';
import '../entities/transaction_entity.dart';
import '../repositories/bank_repository.dart';

class GetTransactionsUseCase {
  final BankRepository repository;

  GetTransactionsUseCase(this.repository);

  Future<Result<List<TransactionEntity>>> call() {
    return repository.getTransactions();
  }
}
