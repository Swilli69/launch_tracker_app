//ignore_for_file:one_member_abstracts
import 'package:dartz/dartz.dart';
import 'package:launch_tracker_app/src/domain/entities/base_error.dart';
import 'package:launch_tracker_app/src/domain/entities/launch.dart';

abstract class ShareService {
  Future<Either<BaseError, Unit>> shareLaunch(Launch launch);
}
