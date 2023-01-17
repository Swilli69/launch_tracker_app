import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:launch_tracker_app/src/injectable/injectable.dart';
import 'package:provider/provider.dart';

class DependenciesWidget extends StatelessWidget {
  DependenciesWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final GetIt getIt = configureDependencies();

  @override
  Widget build(BuildContext context) {
    return Provider(
      lazy: false,
      create: (context) => getIt,
      child: child,
    );
  }
}
