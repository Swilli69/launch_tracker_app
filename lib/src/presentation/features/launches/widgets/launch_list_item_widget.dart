import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:launch_tracker_app/src/presentation/theme/colors.dart';
import 'package:launch_tracker_app/src/presentation/theme/text_styles.dart';

class LaunchListItem extends StatelessWidget {
  const LaunchListItem({
    Key? key,
    required this.name,
    required this.time,
    this.showDivider = false,
  }) : super(key: key);

  factory LaunchListItem.header() => LaunchListItem(
        name: 'launches.mission'.tr(),
        time: 'launches.date_utc'.tr(),
        showDivider: true,
      );

  final String name;
  final String time;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: showDivider
          ? const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.white, width: 1),
              ),
            )
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2,
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.whiteRegular18,
            ),
          ),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              time,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.whiteRegular18,
            ),
          ),
        ],
      ),
    );
  }
}
