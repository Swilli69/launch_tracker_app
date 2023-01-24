import 'package:dartz/dartz.dart';
import 'package:launch_tracker_app/domain/entities/launch.dart';
import 'package:launch_tracker_app/domain/entities/base_error.dart';

abstract class LaunchRepository {
  const LaunchRepository();

  Future<Either<BaseError, List<Launch>>> getLaunches();

  Future<Either<BaseError, Launch>> getLaunch(String id);

  Future<Either<BaseError, List<String>>> getFavorites();

  Future<Either<BaseError, Unit>> addToFavorite(String id);

  Future<Either<BaseError, Unit>> removeFromFavorite(String id);
}
