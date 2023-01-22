import 'package:launch_tracker_app/src/domain/entities/launch.dart';

extension LaunchListExtension on List<Launch> {
  List<Launch> get sortByLaunchTime => this
    ..sort(
      (first, second) => first.launchTimeUnix.compareTo(second.launchTimeUnix),
    );
}
