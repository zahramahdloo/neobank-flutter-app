import '../../../../core/utils/result.dart';
import '../entities/account_entity.dart';
import '../repositories/bank_repository.dart';

class GetAccountsUseCase {
  final BankRepository repository;

  GetAccountsUseCase(this.repository);

  Future<Result<List<AccountEntity>>> call() {
    return repository.getAccounts();
  }
}
