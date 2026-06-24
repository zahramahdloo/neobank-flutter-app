import '../repositories/autho_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<void> call({required String email, required String password, required String fullName}) =>
      repository.signUp(email: email, password: password, fullName: fullName);
}
