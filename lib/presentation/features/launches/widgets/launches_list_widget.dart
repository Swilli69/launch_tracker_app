import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:launch_tracker_app/domain/entities/launch.dart';
import 'package:launch_tracker_app/presentation/common/view_model/view.dart';
import 'package:launch_tracker_app/presentation/common/view_model/view_model.dart';
import 'package:launch_tracker_app/presentation/common/widgets/icon_text_placeholder_widget.dart';
import 'package:launch_tracker_app/presentation/common/widgets/loader_widget.dart';
import 'package:launch_tracker_app/presentation/common/widgets/sliver_refresh_indicator_widget.dart';
import 'package:launch_tracker_app/presentation/features/launches/launches_view_model.dart';
import 'package:launch_tracker_app/presentation/features/launches/widgets/launch_list_item_widget.dart';
import 'package:routemaster/routemaster.dart';

class LaunchesList extends StatelessWidget with ViewWidget<LaunchesViewModel> {
  const LaunchesList({
    super.key,
    required this.onRefresh,
    required this.launchesValue,
    required this.keyName,
    required this.emptyPlaceholder,
  });

  final AsyncCallback onRefresh;
  final ValueNotifier<List<Launch>> launchesValue;
  final String keyName;
  final Widget emptyPlaceholder;

  @override
  Widget build(BuildContext context) {
    final vm = getVM(context);

    return CustomScrollView(
      key: PageStorageKey(keyName),
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        SliverRefreshIndicator(onRefresh: onRefresh),
        ValueListenableBuilder(
          valueListenable: vm.loadingState,
          builder: (context, loadingState, widget) => loadingState ==
                  LoadingState.error
              ? IconTextPlaceholder.failedLoading()
              : loadingState == LoadingState.loading
                  ? const SliverFillRemaining(
                      child: Loader(),
                    )
                  : ValueListenableBuilder(
                      valueListenable: launchesValue,
                      builder: (context, launches, widget) => launches.isEmpty
                          ? emptyPlaceholder
                          : SliverList(
                              delegate: SliverChildListDelegate(
                                [
                                  LaunchListItem.header(),
                                  ...launches.map(
                                    (launch) => LaunchListItem(
                                      name: launch.name,
                                      time: launch.launchDateString,
                                      onTap: () => Routemaster.of(context)
                                          .push('/countdown/${launch.id}'),
                                      showDivider:
                                          launch.id != launches.last.id,
                                    ),
                                  )
                                ],
                              ),
                            ),
                    ),
        )
      ],
    );
  }
}
