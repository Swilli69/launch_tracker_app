import 'package:flutter/material.dart';
import 'package:launch_tracker_app/dependencies/dependencies_widget.dart';
import 'package:launch_tracker_app/launch_tracker_app.dart';
import 'package:launch_tracker_app/presentation/common/localization/localization_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    DependenciesWidget(
      child: const Localization(
        child: LaunchTrackerApp(),
      ),
    ),
  );
}
