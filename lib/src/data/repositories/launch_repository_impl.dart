import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:launch_tracker_app/src/data/network_api/launch_api.dart';
import 'package:launch_tracker_app/src/domain/entities/launch.dart';
import 'package:launch_tracker_app/src/domain/entities/base_error.dart';
import 'package:launch_tracker_app/src/domain/repositories/launch_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const favoriteLaunchesName = 'favorite_launches';

@LazySingleton(as: LaunchRepository)
class LaunchRepositoryImpl extends LaunchRepository {
  const LaunchRepositoryImpl(
    this._launchApi,
    this.sharedPreferences,
  );

  final LaunchApi _launchApi;
  final SharedPreferences sharedPreferences;

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

  @override
  Future<Either<BaseError, Unit>> addToFavorite(String id) async {
    try {
      final savedIdes =
          sharedPreferences.getStringList(favoriteLaunchesName) ?? [];
      if (!savedIdes.contains(id)) {
        sharedPreferences.setStringList(
          favoriteLaunchesName,
          savedIdes..add(id),
        );
      }
      return const Right(unit);
    } catch (e) {
      return const Left(BaseError.localStorageError);
    }
  }

  @override
  Future<Either<BaseError, List<String>>> getFavorites() async {
    try {
      final savedIdes =
          sharedPreferences.getStringList(favoriteLaunchesName) ?? [];
      return Right(savedIdes);
    } catch (e) {
      return const Left(BaseError.localStorageError);
    }
  }

  @override
  Future<Either<BaseError, Unit>> removeFromFavorite(String id) async {
    try {
      final savedIdes =
          sharedPreferences.getStringList(favoriteLaunchesName) ?? [];

      sharedPreferences.setStringList(
        favoriteLaunchesName,
        savedIdes..remove(id),
      );

      return const Right(unit);
    } catch (e) {
      return const Left(BaseError.localStorageError);
    }
  }
}
