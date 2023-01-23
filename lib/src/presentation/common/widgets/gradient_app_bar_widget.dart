import 'package:flutter/material.dart';
import 'package:launch_tracker_app/src/presentation/common/theme/app_colors.dart';
import 'package:launch_tracker_app/src/presentation/common/theme/text_styles.dart';

const double actionsWidth = 60;

class GradientAppBar extends StatelessWidget {
  const GradientAppBar({
    Key? key,
    required this.gradientColors,
    required this.title,
    this.hasLeading = false,
    this.action,
  }) : super(key: key);

  final List<Color> gradientColors;
  final String title;
  final bool hasLeading;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: gradientColors,
        ),
      ),
      child: FlexibleSpaceBar(
        centerTitle: true,
        expandedTitleScale: 1,
        titlePadding: const EdgeInsets.only(top: 30),
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: actionsWidth,
                child: hasLeading
                    ? const BackButton(color: AppColors.white)
                    : null,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyles.whiteRegular22,
                  ),
                ),
              ),
              SizedBox(
                width: actionsWidth,
                child: action,
              )
            ],
          ),
        ),
      ),
    );
  }
}
