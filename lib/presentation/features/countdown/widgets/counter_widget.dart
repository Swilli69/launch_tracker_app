import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:launch_tracker_app/presentation/features/countdown/countdown_view_model.dart';
import 'package:launch_tracker_app/presentation/features/countdown/widgets/counter_section_widget.dart';
import 'package:provider/provider.dart';

class Counter extends StatelessWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<CountdownViewModel>();

    return OrientationBuilder(
      builder: (context, orientation) => orientation == Orientation.portrait
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _getCounterChildren(vm),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _getCounterChildren(vm),
            ),
    );
  }

  List<Widget> _getCounterChildren(CountdownViewModel vm) => [
        CounterSection(
          name: 'countdown.days'.tr(),
          counterValue: vm.daysLeft,
        ),
        CounterSection(
          name: 'countdown.hours'.tr(),
          counterValue: vm.hoursLeft,
        ),
        CounterSection(
          name: 'countdown.minutes'.tr(),
          counterValue: vm.minutesLeft,
        ),
        CounterSection(
          name: 'countdown.seconds'.tr(),
          counterValue: vm.secondsLeft,
        )
      ];
}
