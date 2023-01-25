import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:launch_tracker_app/domain/entities/launch.dart';
import 'package:launch_tracker_app/presentation/common/view_model/view_model.dart';
import 'package:launch_tracker_app/presentation/common/widgets/icon_text_placeholder_widget.dart';
import 'package:launch_tracker_app/presentation/common/widgets/sliver_refresh_indicator_widget.dart';
import 'package:launch_tracker_app/presentation/features/launches/launches_view_model.dart';
import 'package:launch_tracker_app/presentation/features/launches/widgets/launch_list_item_widget.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class LaunchesList extends StatelessWidget {
  const LaunchesList({
    Key? key,
    required this.onRefresh,
    required this.launchesValue,
    required this.keyName,
    required this.emptyPlaceholder,
  }) : super(key: key);

  final AsyncCallback onRefresh;
  final ValueNotifier<List<Launch>> launchesValue;
  final String keyName;
  final Widget emptyPlaceholder;

  @override
  Widget build(BuildContext context) {
    final vm = context.read<LaunchesViewModel>();

    return ValueListenableBuilder(
      valueListenable: launchesValue,
      builder: (context, launches, widget) => CustomScrollView(
        key: PageStorageKey(keyName),
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverRefreshIndicator(onRefresh: onRefresh),
          vm.loadingState.value == LoadingState.error
              ?  IconTextPlaceholder.failedLoading()
              : launches.isEmpty
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
                                  .push('/countdown/${launch.id}')
                                  .result
                                  .then(
                                    (value) => vm.updateFavorites(),
                                  ),
                              showDivider: launch.id != launches.last.id,
                            ),
                          )
                        ],
                      ),
                    )
        ],
      ),
    );
  }
}
