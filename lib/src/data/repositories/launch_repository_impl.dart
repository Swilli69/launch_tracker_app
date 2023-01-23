import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:launch_tracker_app/src/data/network_api/launch_api.dart';
import 'package:launch_tracker_app/src/domain/entities/launch.dart';
import 'package:launch_tracker_app/src/domain/entities/base_error.dart';
import 'package:launch_tracker_app/src/domain/repositories/launch_repository.dart';

@LazySingleton(as: LaunchRepository)
class LaunchRepositoryImpl extends LaunchRepository {
  const LaunchRepositoryImpl(
    this._launchApi,
  );

  final LaunchApi _launchApi;

  @override
  Future<Either<BaseError, List<Launch>>> getLaunches() async {
    try {
      return _launchApi.getLaunches().then(
            (value) =>
                Right(value.map((launchModel) => launchModel.launch).toList()),
          );
    } catch (e) {
      return const Left(BaseError.loadingError);
    }
  }

  @override
  Future<Either<BaseError, Launch>> getLaunch(String id) async {
    try {
      return _launchApi
          .getNextLaunch(id)
          .then((launchModel) => Right(launchModel.launch));
    } catch (e) {
      return const Left(BaseError.loadingError);
    }
  }
}
