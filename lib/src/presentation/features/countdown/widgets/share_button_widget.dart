import 'package:flutter/material.dart';
import 'package:launch_tracker_app/src/presentation/common/theme/app_colors.dart';
import 'package:launch_tracker_app/src/presentation/features/countdown/countdown_view_model.dart';
import 'package:provider/provider.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<CountdownViewModel>();

    return GestureDetector(
      onTap: vm.shareLaunch,
      child: const Icon(Icons.share, color: AppColors.white),
    );
  }
}
