import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:launch_tracker_app/src/presentation/common/view_model/view_model.dart';
import 'package:provider/provider.dart';

abstract class View<VM extends ViewModel> extends StatelessWidget {
  const View({required super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<VM>(
      create: (_) => context.read<GetIt>()<VM>(),
      child: Builder(
        builder: (context) => buildWidget(context),
      ),
    );
  }

  Widget buildWidget(BuildContext context);
}
