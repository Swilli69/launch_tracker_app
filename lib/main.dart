import 'package:flutter/material.dart';
import 'package:launch_tracker_app/src/launch_tracker_app.dart';
import 'package:launch_tracker_app/src/presentation/common/localization/localization_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const Localization(
      child: LaunchTrackerApp(),
    ),
  );
}
