import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:launch_tracker_app/presentation/common/view_model/view.dart';
import 'package:launch_tracker_app/presentation/features/countdown/countdown_view_model.dart';
import 'package:launch_tracker_app/presentation/features/countdown/widgets/counter_section_widget.dart';
import 'package:launch_tracker_app/translations/locale_keys.g.dart';

class Counter extends StatelessWidget with ViewWidget<CountdownViewModel> {
  const Counter({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = getVM(context);

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
          name: LocaleKeys.countdown_days.tr(),
          counterValue: vm.daysLeft,
        ),
        CounterSection(
          name: LocaleKeys.countdown_hours.tr(),
          counterValue: vm.hoursLeft,
        ),
        CounterSection(
          name: LocaleKeys.countdown_minutes.tr(),
          counterValue: vm.minutesLeft,
        ),
        CounterSection(
          name: LocaleKeys.countdown_seconds.tr(),
          counterValue: vm.secondsLeft,
        )
      ];
}
