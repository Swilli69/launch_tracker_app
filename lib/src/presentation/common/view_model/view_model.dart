import 'package:dartz/dartz.dart';
import 'package:launch_tracker_app/src/domain/entities/base_error.dart';

enum LoadingState {
  none,
  loading,
  success,
  error,
}

abstract class ViewModel {
  LoadingState loadingState = LoadingState.none;

  Future<Either<BaseError, T>> loadOperation<T>(
    Future<Either<BaseError, T>> operation,
  ) {
    loadingState = LoadingState.loading;
    return operation.then<Either<BaseError, T>>((value) {
      if (value.isLeft()) {
        loadingState = LoadingState.error;
      } else {
        loadingState = LoadingState.success;
      }
      return value;
    });
  }
}
