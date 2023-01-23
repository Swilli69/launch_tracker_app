import 'package:flutter/cupertino.dart';
import 'package:launch_tracker_app/src/domain/entities/launch.dart';
import 'package:launch_tracker_app/src/domain/repositories/launch_repository.dart';
import 'package:launch_tracker_app/src/presentation/common/view_model/view_model.dart';

class CountdownViewModel extends ViewModel {
  CountdownViewModel(
    this.launchId,
    this._launchRepository,
  ) {
    _timeLeftBeforeLaunch.addListener(_updateTimeLeftValues);
    _initCounterStream();
    _loadLaunch();
  }

  final String launchId;
  final LaunchRepository _launchRepository;
  final ValueNotifier<Duration?> _timeLeftBeforeLaunch = ValueNotifier(null);
  ValueNotifier<Launch?> launch = ValueNotifier(null);
  ValueNotifier<int?> daysLeft = ValueNotifier(null);
  ValueNotifier<int?> hoursLeft = ValueNotifier(null);
  ValueNotifier<int?> minutesLeft = ValueNotifier(null);
  ValueNotifier<int?> secondsLeft = ValueNotifier(null);

  Future<void> _loadLaunch() async {
    return loadOperation(_launchRepository.getLaunch(launchId)).then(
      (value) => value.forEach(
        (loadedLaunch) {
          launch.value = loadedLaunch;
          _updateTimeLeft();
        },
      ),
    );
  }

  void _initCounterStream() {
    Stream.periodic(const Duration(seconds: 1))
        .listen((event) => _updateTimeLeft());
  }

  void _updateTimeLeft() {
    _timeLeftBeforeLaunch.value =
        launch.value?.launchDateTime.difference(DateTime.now());
  }

  void _updateTimeLeftValues() {
    final timeLeft = _timeLeftBeforeLaunch.value;
    if (timeLeft != null) {
      daysLeft.value = timeLeft.inDays;
      hoursLeft.value = timeLeft.inHours - (timeLeft.inDays * 24);
      minutesLeft.value = timeLeft.inMinutes - (timeLeft.inHours * 60);
      secondsLeft.value = timeLeft.inSeconds - (timeLeft.inMinutes * 60);
    }
  }
}
