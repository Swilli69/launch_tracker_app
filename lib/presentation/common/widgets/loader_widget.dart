import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:launch_tracker_app/presentation/common/theme/app_colors.dart';
import 'package:launch_tracker_app/presentation/common/widgets/platform_resolver_widget.dart';

class Loader extends StatelessWidget {
  const Loader({super.key, this.size = 50});
  final double size;

  @override
  Widget build(BuildContext context) => Center(
      child: PlatformResolver(
        ios: CupertinoActivityIndicator(
          color: AppColors.white,
          radius: size / 2,
        ),
        android: SizedBox(
          height: size,
          width: size,
          child: const CircularProgressIndicator(color: AppColors.white,),
        ),
      ),
    );
}
