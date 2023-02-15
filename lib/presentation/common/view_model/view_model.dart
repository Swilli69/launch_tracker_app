import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

enum LoadingState {
  none,
  loading,
  success,
  error,
}

abstract class ViewModel {
  final ValueNotifier<LoadingState> loadingState =
      ValueNotifier(LoadingState.none);

  @disposeMethod
  @mustCallSuper
  void dispose() {
    loadingState.dispose();
  }
}
