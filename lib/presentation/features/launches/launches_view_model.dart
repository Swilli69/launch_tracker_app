import 'dart:async';

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
    loadingState.value = LoadingState.loading;
    _loadLaunches();
    _subscribeFavorites();
  }

  final LaunchRepository _launchRepository;

  final ValueNotifier<List<Launch>> favoriteLaunches = ValueNotifier([]);
  final ValueNotifier<List<String>> _favoriteLaunchesIdes = ValueNotifier([]);
  final ValueNotifier<List<Launch>> allLaunches = ValueNotifier([]);

  late final StreamSubscription<List<String>> _favoritesSubscription;

  Future<void> updateLaunches() async => _loadLaunches();

  Future<void> updateFavorites() async => _subscribeFavorites();

  Future<void> _loadLaunches() async => _launchRepository.getLaunches().then(
          (value) => value.fold(
            (l) {
              loadingState.value = LoadingState.error;
            },
            (loadedLaunches) {
              allLaunches.value = loadedLaunches.sortByLaunchTime;
              loadingState.value = LoadingState.success;
            },
          ),
        );

  Future<void> _subscribeFavorites() async =>
      _favoritesSubscription = _launchRepository.favoritesStream
          .listen((ides) => _favoriteLaunchesIdes.value = ides);

  void _updateFavoriteLaunches() {
    favoriteLaunches.value = allLaunches.value
        .where((launch) => _favoriteLaunchesIdes.value.contains(launch.id))
        .toList();
  }

  @override
  void dispose() {
    favoriteLaunches.dispose();
    _favoriteLaunchesIdes.dispose();
    allLaunches.dispose();
    _favoritesSubscription.cancel();

    super.dispose();
  }
}
