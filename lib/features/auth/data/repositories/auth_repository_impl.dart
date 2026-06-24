import '../../domain/repositories/autho_repository.dart';
import '../datasources/auth_remote_datasourece.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> signIn({required String email, required String password}) =>
      remoteDataSource.signIn(email: email, password: password);

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  }) => remoteDataSource.signUp(email: email, password: password, fullName: fullName);

  @override
  Future<void> signOut() => remoteDataSource.signOut();
}
