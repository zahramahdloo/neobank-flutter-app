import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/account_entity.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/bank_repository.dart';
import '../datasources/bank_remote_datasource.dart';

class BankRepositoryImpl implements BankRepository {
  final BankRemoteDataSource remoteDataSource;

  BankRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result<List<AccountEntity>>> getAccounts() async {
    try {
      final models = await remoteDataSource.getAccounts();
      final entities = models.map((model) => model.toEntity()).toList();

      return Success(entities);
    } on AuthException {
      return const Failed(AuthFailure());
    } on ServerException {
      return const Failed(ServerFailure());
    } on CacheException {
      return const Failed(CacheFailure());
    } catch (_) {
      return const Failed(UnknownFailure());
    }
  }

  @override
  Future<Result<List<TransactionEntity>>> getTransactions() async {
    try {
      final models = await remoteDataSource.getTransactions();
      final entities = models.map((model) => model.toEntity()).toList();

      return Success(entities);
    } on AuthException {
      return const Failed(AuthFailure());
    } on ServerException {
      return const Failed(ServerFailure());
    } on CacheException {
      return const Failed(CacheFailure());
    } catch (_) {
      return const Failed(UnknownFailure());
    }
  }
}
