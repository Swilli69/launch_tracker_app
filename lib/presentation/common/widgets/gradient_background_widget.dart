import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({
    Key? key,
    required this.child,
    required this.colors,
  }) : super(key: key);
  final Widget child;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: colors,
        ),
      ),
      child: child,
    );
  }
}
