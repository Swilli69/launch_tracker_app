import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:launch_tracker_app/domain/entities/base_error.dart';
import 'package:launch_tracker_app/domain/entities/launch.dart';
import 'package:launch_tracker_app/domain/services/share_service.dart';
import 'package:share_plus/share_plus.dart';

@LazySingleton(as: ShareService)
class ShareServiceImpl implements ShareService {
  const ShareServiceImpl();

  @override
  Future<Either<BaseError, Unit>> shareLaunch(Launch launch) async {
    try {
      Share.share(
        'share.share_launch'.tr(
          namedArgs: {'name': launch.name, 'date': launch.launchDateString},
        ),
        subject: launch.name,
      );
      return const Right(unit);
    } catch (e) {
      return const Left(BaseError.shareError);
    }
  }
}
