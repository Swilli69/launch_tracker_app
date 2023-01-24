import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:launch_tracker_app/src/dependencies/injectable.dart';
import 'package:launch_tracker_app/src/presentation/common/widgets/loader_widget.dart';
import 'package:provider/provider.dart';

class DependenciesWidget extends StatelessWidget {
   DependenciesWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final Future<GetIt> getIt = configureDependencies();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getIt,
      builder: (context, getItSnapshot) {
        return getItSnapshot.hasData
            ? Provider(
                lazy: false,
                create: (context) => getItSnapshot.requireData,
                child: child,
              )
            : const MaterialApp(home: Loader());
      },
    );
  }
}
