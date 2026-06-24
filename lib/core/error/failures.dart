import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'خطا در ارتباط با سرور']);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = 'لطفاً دوباره وارد حساب کاربری شوید']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'خطا در خواندن اطلاعات ذخیره‌شده']);
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'خطای نامشخص رخ داد']);
}
