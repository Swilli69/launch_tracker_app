import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:launch_tracker_app/src/presentation/common/theme/app_colors.dart';
import 'package:launch_tracker_app/src/presentation/common/theme/text_styles.dart';
import 'package:launch_tracker_app/src/presentation/features/launches/launches_view_model.dart';
import 'package:provider/provider.dart';

class NoLaunchesPlaceholder extends StatelessWidget {
  const NoLaunchesPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<LaunchesViewModel>();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.rocket_launch_outlined,
            color: AppColors.white,
            size: 200,
          ),
          const SizedBox(height: 20),
          ValueListenableBuilder(
            valueListenable: vm.showFavorite,
            builder: (context, showFavorite, widget) =>
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(

                    (showFavorite
                        ? 'launches.no_favorite_launches'
                        : 'launches.no_launches')
                        .tr(),
                    style: TextStyles.whiteRegular22,
                    textAlign: TextAlign.center,
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
