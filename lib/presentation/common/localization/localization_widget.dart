import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:launch_tracker_app/presentation/common/localization/localization_constants.dart';
import 'package:launch_tracker_app/presentation/common/widgets/loader_widget.dart';
import 'package:launch_tracker_app/translations/codegen_loader.g.dart';

class Localization extends StatelessWidget {
  const Localization({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: EasyLocalization.ensureInitialized(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return EasyLocalization(
              supportedLocales: const [
                LocalizationConstants.englishLocale,
              ],
              path: 'assets/translations',
              assetLoader: const CodegenLoader(),
              child: child,
            );
          }
          return const MaterialApp(
            home: Loader(),
          );
        },
      );
}
