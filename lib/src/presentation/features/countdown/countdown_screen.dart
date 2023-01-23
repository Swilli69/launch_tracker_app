import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:launch_tracker_app/src/presentation/common/theme/app_colors.dart';
import 'package:launch_tracker_app/src/presentation/common/view_model/view.dart';
import 'package:launch_tracker_app/src/presentation/common/view_model/view_model.dart';
import 'package:launch_tracker_app/src/presentation/common/widgets/gradient_app_bar_widget.dart';
import 'package:launch_tracker_app/src/presentation/common/widgets/loader_widget.dart';
import 'package:launch_tracker_app/src/presentation/features/countdown/countdown_view_model.dart';
import 'package:launch_tracker_app/src/presentation/features/countdown/widgets/counter_section_widget.dart';

import 'package:provider/provider.dart';

class CountdownScreen extends View<CountdownViewModel> {
  const CountdownScreen({
    Key? key,
    required String launchId,
  }) : super(key: key, param1: launchId);

  @override
  Widget buildWidget(BuildContext context) {
    final vm = context.read<CountdownViewModel>();

    return ValueListenableBuilder(
      valueListenable: vm.launch,
      builder: (context, launch, widget) =>
          vm.loadingState == LoadingState.loading
              ? const Loader()
              : Scaffold(
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(100.0),
                    child: AppBar(
                      flexibleSpace: GradientAppBar(
                        gradientColors: const [
                          AppColors.macawBlueGreen,
                          AppColors.riverBed
                        ],
                        title: launch?.name ?? 'name',
                      ),
                    ),
                  ),
                  body: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [AppColors.gableGreen, AppColors.dark],
                      ),
                    ),
                    child: OrientationBuilder(
                      builder: (context, orientation) =>
                          orientation == Orientation.portrait
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: _getCounterChildren(vm),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: _getCounterChildren(vm),
                                ),
                    ),
                  ),
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
