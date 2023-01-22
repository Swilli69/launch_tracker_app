import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:launch_tracker_app/src/presentation/common/view_model/view.dart';
import 'package:launch_tracker_app/src/presentation/common/view_model/view_model.dart';
import 'package:launch_tracker_app/src/presentation/common/widgets/loader_widget.dart';
import 'package:launch_tracker_app/src/presentation/features/launches/launches_view_model.dart';
import 'package:launch_tracker_app/src/presentation/features/launches/widgets/launch_list_item_widget.dart';
import 'package:launch_tracker_app/src/presentation/theme/colors.dart';
import 'package:launch_tracker_app/src/presentation/theme/text_styles.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class LaunchesScreen extends View<LaunchesViewModel> {
  const LaunchesScreen({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context) {
    final vm = context.read<LaunchesViewModel>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [AppColors.purplyMagenta, AppColors.bluishPurple],
          ),
        ),
        child: ValueListenableBuilder(
          valueListenable: vm.launches,
          builder: (context, launches, widget) => CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: 100,
                pinned: true,
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [AppColors.rouge, AppColors.darkPurple],
                    ),
                  ),
                  child: FlexibleSpaceBar(
                    centerTitle: true,
                    expandedTitleScale: 1,
                    title: Text(
                      'launches.upcoming_launches'.tr(),
                      style: TextStyles.whiteRegular22,
                    ),
                  ),
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
                              time: DateFormat('dd/MM/yy')
                                  .format(launch.launchDateTime),
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
