import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:launch_tracker_app/data/services/operation_service.dart';
import 'package:launch_tracker_app/data/storage/storage_repository.dart';
import 'package:launch_tracker_app/domain/entities/base_error.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

const favoriteLaunchesKey = 'favorite_launches';

@LazySingleton(as: StorageRepository)
class StorageRepositoryImpl extends StorageRepository {
  StorageRepositoryImpl(
    this._prefs,
    this._operationService,
  );

  final StreamingSharedPreferences _prefs;
  final OperationService _operationService;

  @override
  Future<Either<BaseError, Stream<List<String>>>> getFavoritesStream() async =>
      _operationService.safeSyncOp(
        () => _prefs.getStringList(favoriteLaunchesKey, defaultValue: []),
      );

  @override
  Future<Either<BaseError, Unit>> saveFavorites(List<String> favorites) =>
      _operationService.safeUnitAsyncOp(
        () => _prefs.setStringList(favoriteLaunchesKey, favorites),
      );
}
