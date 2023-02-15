import 'package:flutter/material.dart';
import 'package:launch_tracker_app/presentation/common/theme/app_colors.dart';
import 'package:launch_tracker_app/presentation/common/theme/text_styles.dart';

const double actionWidth = 60;

class GradientAppBar extends StatelessWidget {
  const GradientAppBar({
    super.key,
    required this.gradientColors,
    required this.title,
    this.hasLeading = false,
    this.bottom,
    this.actions,
  });

  final List<Color> gradientColors;
  final String title;
  final bool hasLeading;
  final Widget? bottom;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: gradientColors),
              ),
              child: FlexibleSpaceBar(
                centerTitle: true,
                expandedTitleScale: 1,
                titlePadding: const EdgeInsets.only(top: 30),
                title: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: actionWidth,
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
                      if (actions?.isEmpty ?? true)
                        const SizedBox(width: actionWidth)
                      else
                        ...actions!
                          ..forEach(
                            (action) => SizedBox(
                              width: actionWidth,
                              child: action,
                            ),
                          )
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (bottom != null) bottom!,
        ],
      );
}
