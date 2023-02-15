import 'package:flutter/material.dart';
import 'package:launch_tracker_app/presentation/common/theme/app_colors.dart';
import 'package:launch_tracker_app/presentation/common/view_model/view.dart';
import 'package:launch_tracker_app/presentation/features/countdown/countdown_view_model.dart';

class ShareButton extends StatelessWidget with ViewWidget<CountdownViewModel>{
  const ShareButton({super.key});

  @override
  Widget build(BuildContext context) => IconButton(
      icon: const Icon(Icons.share, color: AppColors.white),
      onPressed: getVM(context).shareLaunch,
    );
}
