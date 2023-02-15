import 'package:dartz/dartz.dart';
import 'package:launch_tracker_app/domain/entities/base_error.dart';
import 'package:launch_tracker_app/domain/entities/launch.dart';
import 'package:launch_tracker_app/domain/repositories/base_repository.dart';

abstract class LaunchRepository extends BaseRepository {
  const LaunchRepository();

  Stream<List<String>> get favoritesStream;


  Future<Either<BaseError, List<Launch>>> getLaunches();

  Future<Either<BaseError, Launch>> getLaunch(String id);

  Future<Either<BaseError, Unit>> addToFavorite(String id);

  Future<Either<BaseError, Unit>> removeFromFavorite(String id);
}
