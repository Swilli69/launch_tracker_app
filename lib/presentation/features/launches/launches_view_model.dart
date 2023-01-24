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
    showFavorite.addListener(_filterLaunches);
    _allLaunches.addListener(_filterLaunches);
    _favoriteLaunches.addListener(_filterLaunches);
    _loadLaunches();
    _loadFavorites();
  }

  final LaunchRepository _launchRepository;

  final ValueNotifier<List<Launch>> filteredLaunches = ValueNotifier([]);
  final ValueNotifier<bool> showFavorite = ValueNotifier(false);
  final ValueNotifier<List<String>> _favoriteLaunches = ValueNotifier([]);
  final ValueNotifier<List<Launch>> _allLaunches = ValueNotifier([]);

  Future<void> updateLaunches() async => _loadLaunches();

  Future<void> updateFavorites() async => _loadFavorites();

  void toggleShowFavorite() => showFavorite.value = !showFavorite.value;

  Future<void> _loadLaunches() async {
    return loadOperation(_launchRepository.getLaunches()).then(
      (value) => value.forEach(
        (loadedLaunches) {
          _allLaunches.value = loadedLaunches.sortByLaunchTime;
        },
      ),
    );
  }

  Future<void> _loadFavorites() async {
    return loadOperation(_launchRepository.getFavorites()).then(
      (value) => value.forEach(
        (favorites) {
          _favoriteLaunches.value = favorites;
        },
      ),
    );
  }

  void _filterLaunches() {
    if (showFavorite.value) {
      filteredLaunches.value = _allLaunches.value
          .where(
            (launch) => _favoriteLaunches.value.contains(launch.id),
          )
          .toList();
    } else {
      filteredLaunches.value = _allLaunches.value;
    }
  }
}
