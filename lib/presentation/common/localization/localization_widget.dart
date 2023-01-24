import 'package:easy_localization/easy_localization.dart';

//import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:launch_tracker_app/presentation/common/localization/localization_constants.dart';

class Localization extends StatelessWidget {
  const Localization({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: EasyLocalization.ensureInitialized(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return EasyLocalization(
            supportedLocales: const [
              LocalizationConstants.englishLocale,
            ],
            path: 'assets/translations',
            fallbackLocale: LocalizationConstants.englishLocale,
            child: child,
          );
        }
        return MaterialApp(
          //TODO: create loader widget
          home: Scaffold(body: Container()),
        );
      },
    );
  }
}
