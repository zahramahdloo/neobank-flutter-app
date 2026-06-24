import '../error/failures.dart';

sealed class Result<T> {
  const Result();

  R fold<R>({
    required R Function(Failure failure) onFailure,
    required R Function(T data) onSuccess,
  }) {
    final current = this;

    if (current is Success<T>) {
      return onSuccess(current.data);
    }

    if (current is Failed<T>) {
      return onFailure(current.failure);
    }

    throw StateError('Invalid Result state');
  }
}

class Success<T> extends Result<T> {
  final T data;

  const Success(this.data);
}

class Failed<T> extends Result<T> {
  final Failure failure;

  const Failed(this.failure);
}
