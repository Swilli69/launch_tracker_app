import 'package:flutter/material.dart';
import 'package:launch_tracker_app/src/presentation/common/view_model/view.dart';
import 'package:launch_tracker_app/src/presentation/launches/launches_view_model.dart';
import 'package:provider/provider.dart';

class LaunchesScreen extends View<LaunchesViewModel> {
  const LaunchesScreen({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context) {
    final vm = context.read<LaunchesViewModel>();

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20),
        child: ValueListenableBuilder(
          valueListenable: vm.launches,
          builder: (context, launches, widget) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: launches.map((e) => Text(e.name)).toList(),
          ),
        ),
      ),
    );
  }
}
