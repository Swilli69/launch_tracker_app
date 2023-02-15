import 'package:dartz/dartz.dart';
import 'package:launch_tracker_app/domain/entities/base_error.dart';
import 'package:launch_tracker_app/domain/repositories/base_repository.dart';

abstract class StorageRepository extends BaseRepository {
  Future<Either<BaseError, Stream<List<String>>>> getFavoritesStream();

  Future<Either<BaseError, Unit>> saveFavorites(List<String> favorites);
}
