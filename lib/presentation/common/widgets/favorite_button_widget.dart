import 'package:flutter/material.dart';
import 'package:launch_tracker_app/presentation/common/theme/app_colors.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    Key? key,
    required this.isFavorite,
    required this.onPress,
  }) : super(key: key);

  final ValueNotifier<bool> isFavorite;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: ValueListenableBuilder(
        valueListenable: isFavorite,
        builder: (context, isFavorite, widget) => Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: AppColors.white,
        ),
      ),
      onPressed: onPress,
    );
  }
}
