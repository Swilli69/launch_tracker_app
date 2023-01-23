import 'package:flutter/material.dart';
import 'package:launch_tracker_app/src/presentation/common/theme/text_styles.dart';

class GradientAppBar extends StatelessWidget {
  const GradientAppBar({
    Key? key,
    required this.gradientColors,
    required this.title,
  }) : super(key: key);

  final List<Color> gradientColors;
  final String title;

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
        title: Text(
          title,
          style: TextStyles.whiteRegular22,
        ),
      ),
    );
  }
}
