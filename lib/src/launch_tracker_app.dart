import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:launch_tracker_app/src/presentation/features/countdown/countdown_screen.dart';
import 'package:launch_tracker_app/src/presentation/features/launches/launches_screen.dart';
import 'package:go_router/go_router.dart';

class LaunchTrackerApp extends StatelessWidget {
  const LaunchTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const LaunchesScreen(),
            routes: [
              GoRoute(
                path: 'countdown/:launchId',
                builder: (
                  context,
                  state,
                ) =>
                    CountdownScreen(launchId: state.params['launchId']!),
              )
            ],
          ),
        ],
      ),
    );
  }
}
