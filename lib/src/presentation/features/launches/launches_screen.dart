import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:launch_tracker_app/src/presentation/common/theme/app_colors.dart';
import 'package:launch_tracker_app/src/presentation/common/view_model/view.dart';
import 'package:launch_tracker_app/src/presentation/common/view_model/view_model.dart';
import 'package:launch_tracker_app/src/presentation/common/widgets/gradient_app_bar_widget.dart';
import 'package:launch_tracker_app/src/presentation/common/widgets/gradient_background_widget.dart';
import 'package:launch_tracker_app/src/presentation/common/widgets/loader_widget.dart';
import 'package:launch_tracker_app/src/presentation/features/launches/launches_view_model.dart';
import 'package:launch_tracker_app/src/presentation/features/launches/widgets/launch_list_item_widget.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class LaunchesScreen extends View<LaunchesViewModel> {
  const LaunchesScreen({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context) {
    final vm = context.read<LaunchesViewModel>();

    return Scaffold(
      body: GradientBackground(
        colors: const [AppColors.purplyMagenta, AppColors.bluishPurple],
        child: ValueListenableBuilder(
          valueListenable: vm.launches,
          builder: (context, launches, widget) => CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: 100,
                pinned: true,
                flexibleSpace: GradientAppBar(
                  gradientColors: const [AppColors.rouge, AppColors.darkPurple],
                  title: 'launches.upcoming_launches'.tr(),
                ),
              ),
              CupertinoSliverRefreshControl(
                onRefresh: vm.updateLaunches,
                builder: (
                  context,
                  refreshState,
                  pulledExtent,
                  refreshTriggerPullDistance,
                  refreshIndicatorExtent,
                ) =>
                    Loader(size: min(30, pulledExtent)),
              ),
              vm.loadingState == LoadingState.loading
                  ? const SliverFillRemaining(
                      child: Loader(),
                    )
                  : SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          LaunchListItem.header(),
                          ...launches.map(
                            (launch) => LaunchListItem(
                              name: launch.name,
                              time: launch.launchDateString,
                              onTap: () =>
                                  context.go('/countdown/${launch.id}'),
                              showDivider: launch.id != launches.last.id,
                            ),
                          )
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
