import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:launch_tracker_app/presentation/features/countdown/countdown_screen.dart';
import 'package:launch_tracker_app/presentation/features/launches/launches_screen.dart';
import 'package:routemaster/routemaster.dart';

class LaunchTrackerApp extends StatelessWidget {
  const LaunchTrackerApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
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
