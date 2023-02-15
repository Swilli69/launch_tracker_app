import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:launch_tracker_app/dependencies/injectable.dart';
import 'package:launch_tracker_app/presentation/common/widgets/loader_widget.dart';
import 'package:provider/provider.dart';

class DependenciesWidget extends StatefulWidget {
  const DependenciesWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<DependenciesWidget> createState() => _DependenciesWidgetState();
}

class _DependenciesWidgetState extends State<DependenciesWidget> {
  late final Future<GetIt> getIt;

  @override
  void initState() {
    getIt = configureDependencies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: getIt,
        builder: (context, getItSnapshot) =>
            getItSnapshot.connectionState == ConnectionState.done
                ? Provider(
                    lazy: false,
                    create: (context) => getItSnapshot.requireData,
                    child: widget.child,
                  )
                : const MaterialApp(home: Loader()),
      );
}
