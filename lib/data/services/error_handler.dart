import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@lazySingleton
class ErrorHandler {
  ErrorHandler(this._logger);

  final Logger _logger;

  void onError(
    dynamic error,
    StackTrace? stackTrace,
  ) {
    _logger.e(
      'Error! ${error is DioError ? error.message : error}',
      error,
      error is DioError ? error.stackTrace : stackTrace,
    );
  }
}
