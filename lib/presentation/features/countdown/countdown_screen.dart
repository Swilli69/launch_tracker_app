import 'package:flutter/material.dart';
import 'package:launch_tracker_app/presentation/common/theme/app_colors.dart';
import 'package:launch_tracker_app/presentation/common/view_model/view.dart';
import 'package:launch_tracker_app/presentation/common/view_model/view_model.dart';
import 'package:launch_tracker_app/presentation/common/widgets/gradient_app_bar_widget.dart';
import 'package:launch_tracker_app/presentation/common/widgets/sliver_failed_loading_widget.dart';
import 'package:launch_tracker_app/presentation/common/widgets/gradient_background_widget.dart';
import 'package:launch_tracker_app/presentation/common/widgets/loader_widget.dart';
import 'package:launch_tracker_app/presentation/common/widgets/sliver_refresh_indicator_widget.dart';
import 'package:launch_tracker_app/presentation/features/countdown/countdown_view_model.dart';
import 'package:launch_tracker_app/presentation/features/countdown/widgets/counter_widget.dart';
import 'package:launch_tracker_app/presentation/common/widgets/favorite_button_widget.dart';
import 'package:launch_tracker_app/presentation/features/countdown/widgets/share_button_widget.dart';
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
      valueListenable: vm.loadingState,
      builder: (context, loadingState, widget) => ValueListenableBuilder(
        valueListenable: vm.launch,
        builder: (context, launch, widget) => Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100.0),
            child: AppBar(
              flexibleSpace: GradientAppBar(
                gradientColors: const [
                  AppColors.macawBlueGreen,
                  AppColors.riverBed
                ],
                title: launch?.name ?? '',
                hasLeading: true,
                actions: launch != null
                    ? [
                        FavoriteButton(
                          isFavorite: vm.isFavorite,
                          onPress: vm.toggleFavorite,
                        ),
                        const ShareButton(),
                      ]
                    : null,
              ),
              leadingWidth: 60,
              automaticallyImplyLeading: false,
            ),
          ),
          body: GradientBackground(
            colors: const [AppColors.gableGreen, AppColors.dark],
            child: loadingState == LoadingState.error
                ? CustomScrollView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    slivers: [
                      SliverRefreshIndicator(onRefresh: vm.refreshLaunch),
                      const SliverFailedLoading(),
                    ],
                  )
                : loadingState == LoadingState.loading
                    ? const Loader()
                    : const Counter(),
          ),
        ),
      ),
    );
  }
}
