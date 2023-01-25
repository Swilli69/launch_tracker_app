import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:launch_tracker_app/domain/entities/base_error.dart';

enum LoadingState {
  none,
  loading,
  success,
  error,
}

abstract class ViewModel {
  final ValueNotifier<LoadingState> loadingState =
      ValueNotifier(LoadingState.none);

  Future<Either<BaseError, T>> loadOperation<T>(
    Future<Either<BaseError, T>> operation, {
    bool showLoader = true,
  }) {
    if (showLoader) {
      loadingState.value = LoadingState.loading;
    }

    return operation.then<Either<BaseError, T>>((value) {
      if (value.isLeft()) {
        loadingState.value = LoadingState.error;
      } else {
        loadingState.value = LoadingState.success;
      }
      return value;
    });
  }
}
