import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:launch_tracker_app/domain/entities/launch.dart';
import 'package:launch_tracker_app/domain/repositories/launch_repository.dart';
import 'package:launch_tracker_app/domain/utils/extensions/launch_list_extension.dart';
import 'package:launch_tracker_app/presentation/common/view_model/view_model.dart';

@injectable
class LaunchesViewModel extends ViewModel {
  LaunchesViewModel(
    this._launchRepository,
  ) {
    allLaunches.addListener(_updateFavoriteLaunches);
    _favoriteLaunchesIdes.addListener(_updateFavoriteLaunches);
    _loadLaunches();
    _loadFavorites();
  }

  final LaunchRepository _launchRepository;

  final ValueNotifier<List<Launch>> favoriteLaunches = ValueNotifier([]);
  final ValueNotifier<List<String>> _favoriteLaunchesIdes = ValueNotifier([]);
  final ValueNotifier<List<Launch>> allLaunches = ValueNotifier([]);

  Future<void> updateLaunches() async => _loadLaunches(showLoader: false);

  Future<void> updateFavorites() async => _loadFavorites();

  Future<void> _loadLaunches({bool showLoader = true}) async {
    return loadOperation(
      _launchRepository.getLaunches(),
      showLoader: showLoader,
    ).then(
      (value) => value.forEach(
        (loadedLaunches) {
          allLaunches.value = loadedLaunches.sortByLaunchTime;
        },
      ),
    );
  }

  Future<void> _loadFavorites() async {
    return loadOperation(_launchRepository.getFavorites()).then(
      (value) => value.forEach(
        (favorites) {
          _favoriteLaunchesIdes.value = favorites;
        },
      ),
    );
  }

  void _updateFavoriteLaunches() {
    favoriteLaunches.value = allLaunches.value
        .where(
          (launch) => _favoriteLaunchesIdes.value.contains(launch.id),
        )
        .toList();
  }
}
