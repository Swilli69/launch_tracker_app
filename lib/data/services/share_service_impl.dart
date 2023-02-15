import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:launch_tracker_app/data/services/operation_service.dart';
import 'package:launch_tracker_app/domain/entities/base_error.dart';
import 'package:launch_tracker_app/domain/entities/launch.dart';
import 'package:launch_tracker_app/domain/services/share_service.dart';
import 'package:launch_tracker_app/translations/locale_keys.g.dart';
import 'package:share_plus/share_plus.dart';

@LazySingleton(as: ShareService)
class ShareServiceImpl implements ShareService {
  const ShareServiceImpl(this._operationService);

  final OperationService _operationService;

  @override
  Future<Either<BaseError, Unit>> shareLaunch(Launch launch) async =>
      _operationService.safeUnitAsyncOp(
        () => Share.share(
          LocaleKeys.share_share_launch.tr(
            namedArgs: {'name': launch.name, 'date': launch.launchDateString},
          ),
          subject: launch.name,
        ),
      );
}
