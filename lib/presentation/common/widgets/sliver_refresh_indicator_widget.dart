import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:launch_tracker_app/presentation/common/widgets/loader_widget.dart';

class SliverRefreshIndicator extends StatelessWidget {
  const SliverRefreshIndicator({
    Key? key,
    required this.onRefresh,
  }) : super(key: key);
  final AsyncCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverRefreshControl(
      onRefresh: onRefresh,
      builder: (
        context,
        refreshState,
        pulledExtent,
        refreshTriggerPullDistance,
        refreshIndicatorExtent,
      ) =>
          Loader(size: min(30, pulledExtent)),
    );
  }
}
