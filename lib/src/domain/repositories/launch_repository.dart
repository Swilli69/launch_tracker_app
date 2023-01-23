import 'package:dartz/dartz.dart';
import 'package:launch_tracker_app/src/domain/entities/launch.dart';
import 'package:launch_tracker_app/src/domain/entities/base_error.dart';

abstract class LaunchRepository {
  const LaunchRepository();

  Future<Either<BaseError, List<Launch>>> getLaunches();

  Future<Either<BaseError, Launch>> getLaunch(String id);
}
