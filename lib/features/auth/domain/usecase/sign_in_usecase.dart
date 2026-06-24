import '../repositories/autho_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<void> call({required String email, required String password}) =>
      repository.signIn(email: email, password: password);
}
