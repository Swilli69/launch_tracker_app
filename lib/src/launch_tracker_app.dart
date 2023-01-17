import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LaunchTrackerApp extends StatelessWidget {
  const LaunchTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: Container(),
    );
  }
}
