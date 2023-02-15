import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:launch_tracker_app/data/network_api/launch_api.dart';
import 'package:launch_tracker_app/data/services/operation_service.dart';
import 'package:launch_tracker_app/data/storage/storage_repository.dart';
import 'package:launch_tracker_app/domain/entities/base_error.dart';
import 'package:launch_tracker_app/domain/entities/launch.dart';
import 'package:launch_tracker_app/domain/repositories/launch_repository.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: LaunchRepository)
class LaunchRepositoryImpl extends LaunchRepository {
  LaunchRepositoryImpl(
    this._launchApi,
    this._storageRepository,
    this._operationService,
  ) {
    _storageRepository.getFavoritesStream().then(
          (value) => value.map((stream) {
            stream
                .forEach((favorites) => _storageFavoritesStream.add(favorites));
          }),
        );
  }

  final LaunchApi _launchApi;
  final OperationService _operationService;
  final StorageRepository _storageRepository;
  final _storageFavoritesStream = BehaviorSubject<List<String>>();

  @override
  Future<Either<BaseError, List<Launch>>> getLaunches() async =>
      _operationService.safeAsyncOp(() => _launchApi.getLaunches()).then(
            (value) =>
                value.map((launches) => launches.map((e) => e.launch).toList()),
          );

  @override
  Future<Either<BaseError, Launch>> getLaunch(String id) async =>
      _operationService.safeAsyncOp(() => _launchApi.getNextLaunch(id)).then(
            (value) => value.map((launchModel) => launchModel.launch),
          );

  @override
  Future<Either<BaseError, Unit>> addToFavorite(String id) async {
    final savedIdes = _storageFavoritesStream.value;
    if (!savedIdes.contains(id)) {
      return _storageRepository.saveFavorites(savedIdes..add(id));
    } else {
      return left(BaseError());
    }
  }

  @override
  Stream<List<String>> get favoritesStream async* {
    if (_storageFavoritesStream.hasValue) {
      yield _storageFavoritesStream.value;
    } else{
      yield [];
    }
    yield* _storageFavoritesStream.stream;
  }

  @override
  Future<Either<BaseError, Unit>> removeFromFavorite(String id) async =>
      _storageRepository
          .saveFavorites(_storageFavoritesStream.value..remove(id));
}
