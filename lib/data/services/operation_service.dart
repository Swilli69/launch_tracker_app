import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:launch_tracker_app/data/services/error_handler.dart';
import 'package:launch_tracker_app/domain/entities/base_error.dart';

@lazySingleton
class OperationService {
  OperationService(this._errorHandler);

  final ErrorHandler _errorHandler;

  Future<Either<BaseError, T>> safeAsyncOp<T>(
    Future<T> Function() operation,
  ) async {
    try {
      final response = await operation();
      return right(response);
    } on DioError catch (error, stack) {
      _errorHandler.onError(error, stack);
      return left(
        BaseError(
          statusCode: error.response?.statusCode,
          message: error.response?.statusMessage,
          data: error.response?.data,
          error: error.error ?? error,
        ),
      );
    } catch (error, stack) {
      _errorHandler.onError(error, stack);
      return left(
        BaseError(
          message: error.toString(),
          error: error,
        ),
      );
    }
  }

  Future<Either<BaseError, Unit>> safeUnitAsyncOp<T>(
    Future<T> Function() operation,
  ) async =>
      safeAsyncOp<T>(operation).then(
        (value) => value.fold(
          (l) => left(l),
          (r) => right(unit),
        ),
      );

  Either<BaseError, T> safeSyncOp<T>(T Function() operation) {
    try {
      final response = operation();
      return right(response);
    } catch (error, stack) {
      _errorHandler.onError(error, stack);

      return left(BaseError(message: error.toString(), error: error));
    }
  }

  Either<BaseError, Unit> safeUnitSyncOp<T>(T Function() operation) =>
      safeSyncOp<T>(operation).fold(
        (l) => left(l),
        (r) => right(unit),
      );
}
