import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:launch_tracker_app/presentation/common/theme/app_colors.dart';
import 'package:launch_tracker_app/presentation/common/theme/text_styles.dart';
import 'package:launch_tracker_app/presentation/common/view_model/view.dart';
import 'package:launch_tracker_app/presentation/common/view_model/view_model.dart';
import 'package:launch_tracker_app/presentation/common/widgets/gradient_app_bar_widget.dart';
import 'package:launch_tracker_app/presentation/common/widgets/gradient_background_widget.dart';
import 'package:launch_tracker_app/presentation/common/widgets/icon_text_placeholder_widget.dart';
import 'package:launch_tracker_app/presentation/common/widgets/loader_widget.dart';
import 'package:launch_tracker_app/presentation/features/launches/launches_view_model.dart';
import 'package:launch_tracker_app/presentation/features/launches/widgets/launches_list_widget.dart';
import 'package:provider/provider.dart';

const appBarCollapsedHeight = 56.0;
const appBarGradientColors = [AppColors.rouge, AppColors.darkPurple];

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
          builder: (context, loadingState, widget) => loadingState ==
                  LoadingState.loading
              ? const Loader()
              : DefaultTabController(
                  length: 2,
                  child: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverOverlapAbsorber(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context,
                          ),
                          sliver: SliverAppBar(
                            toolbarHeight: appBarCollapsedHeight -
                                MediaQuery.of(context).padding.top / 2,
                            forceElevated: innerBoxIsScrolled,
                            expandedHeight: 110,
                            pinned: true,
                            flexibleSpace: GradientAppBar(
                              gradientColors: appBarGradientColors,
                              title: 'launches.upcoming_launches'.tr(),
                              bottom: SizedBox(
                                height: appBarCollapsedHeight,
                                child: GradientBackground(
                                  colors: appBarGradientColors,
                                  child: TabBar(
                                    labelStyle: TextStyles.whiteRegular18,
                                    tabs: [
                                      Tab(text: 'launches.all'.tr()),
                                      Tab(text: 'launches.favorite'.tr())
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.only(
                            top: appBarCollapsedHeight -
                                MediaQuery.of(context).padding.top / 2,
                          ),
                        ),
                      ];
                    },
                    body: SafeArea(
                      child: TabBarView(
                        children: [
                          LaunchesList(
                            keyName: 'all',
                            onRefresh: vm.updateLaunches,
                            launchesValue: vm.allLaunches,
                            emptyPlaceholder: IconTextPlaceholder.noLaunches(
                              text: 'launches.no_launches'.tr(),
                            ),
                          ),
                          LaunchesList(
                            keyName: 'favorite',
                            onRefresh: vm.updateLaunches,
                            launchesValue: vm.favoriteLaunches,
                            emptyPlaceholder: IconTextPlaceholder.noLaunches(
                              text: 'launches.no_favorite_launches'.tr(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
