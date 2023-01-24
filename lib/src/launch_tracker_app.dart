import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:launch_tracker_app/src/presentation/features/countdown/countdown_screen.dart';
import 'package:launch_tracker_app/src/presentation/features/launches/launches_screen.dart';
import 'package:routemaster/routemaster.dart';

class LaunchTrackerApp extends StatelessWidget {
  const LaunchTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerDelegate: RoutemasterDelegate(
        routesBuilder: (context) => RouteMap(
          routes: {
            '/': (_) => const MaterialPage(child: LaunchesScreen()),
            '/countdown/:launchId': (params) => MaterialPage(
                  child: CountdownScreen(
                    launchId: params.pathParameters['launchId']!,
                  ),
                ),
          },
        ),
      ),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
