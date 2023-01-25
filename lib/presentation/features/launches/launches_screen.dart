import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:launch_tracker_app/presentation/common/theme/app_colors.dart';
import 'package:launch_tracker_app/presentation/common/view_model/view.dart';
import 'package:launch_tracker_app/presentation/common/view_model/view_model.dart';
import 'package:launch_tracker_app/presentation/common/widgets/favorite_button_widget.dart';
import 'package:launch_tracker_app/presentation/common/widgets/gradient_app_bar_widget.dart';
import 'package:launch_tracker_app/presentation/common/widgets/gradient_background_widget.dart';
import 'package:launch_tracker_app/presentation/common/widgets/loader_widget.dart';
import 'package:launch_tracker_app/presentation/common/widgets/sliver_refresh_indicator_widget.dart';
import 'package:launch_tracker_app/presentation/features/launches/launches_view_model.dart';
import 'package:launch_tracker_app/presentation/common/widgets/sliver_failed_loading_widget.dart';
import 'package:launch_tracker_app/presentation/features/launches/widgets/launch_list_item_widget.dart';
import 'package:launch_tracker_app/presentation/features/launches/widgets/no_launches_placeholder_widget.dart';
import 'package:provider/provider.dart';

import 'package:routemaster/routemaster.dart';

class LaunchesScreen extends View<LaunchesViewModel> {
  const LaunchesScreen({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context) {
    final vm = context.read<LaunchesViewModel>();

    return Scaffold(
      body: GradientBackground(
        colors: const [AppColors.purplyMagenta, AppColors.bluishPurple],
        child: ValueListenableBuilder(
          valueListenable: vm.loadingState,
          builder: (context, loadingState, widget) => ValueListenableBuilder(
            valueListenable: vm.filteredLaunches,
            builder: (context, launches, widget) => CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                SliverAppBar(
                  expandedHeight: 100,
                  pinned: true,
                  flexibleSpace: GradientAppBar(
                    gradientColors: const [
                      AppColors.rouge,
                      AppColors.darkPurple
                    ],
                    title: 'launches.upcoming_launches'.tr(),
                    actions: [
                      FavoriteButton(
                        isFavorite: vm.showFavorite,
                        onPress: vm.toggleShowFavorite,
                      )
                    ],
                  ),
                ),
                if (loadingState == LoadingState.loading)
                  const SliverFillRemaining(child: Loader())
                else ...[
                  SliverRefreshIndicator(onRefresh: vm.updateLaunches),
                  (loadingState == LoadingState.error
                      ? const SliverFailedLoading()
                      : launches.isEmpty
                          ? const SliverFillRemaining(
                              child: NoLaunchesPlaceholder(),
                            )
                          : SliverList(
                              delegate: SliverChildListDelegate(
                                [
                                  LaunchListItem.header(),
                                  ...launches.map(
                                    (launch) => LaunchListItem(
                                      name: launch.name,
                                      time: launch.launchDateString,
                                      onTap: () => Routemaster.of(context)
                                          .push('/countdown/${launch.id}')
                                          .result
                                          .then(
                                            (value) => vm.updateFavorites(),
                                          ),
                                      showDivider:
                                          launch.id != launches.last.id,
                                    ),
                                  )
                                ],
                              ),
                            ))
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
