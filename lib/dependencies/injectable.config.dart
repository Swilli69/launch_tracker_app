// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:launch_tracker_app/data/network_api/launch_api.dart' as _i4;
import 'package:launch_tracker_app/data/repositories_impl/launch_repository_impl.dart'
    as _i14;
import 'package:launch_tracker_app/data/repositories_impl/storage_repository_impl.dart'
    as _i12;
import 'package:launch_tracker_app/data/services/error_handler.dart' as _i7;
import 'package:launch_tracker_app/data/services/operation_service.dart' as _i8;
import 'package:launch_tracker_app/data/services/share_service_impl.dart'
    as _i10;
import 'package:launch_tracker_app/data/storage/storage_repository.dart'
    as _i11;
import 'package:launch_tracker_app/dependencies/register_module.dart' as _i17;
import 'package:launch_tracker_app/domain/repositories/launch_repository.dart'
    as _i13;
import 'package:launch_tracker_app/domain/services/share_service.dart' as _i9;
import 'package:launch_tracker_app/presentation/features/countdown/countdown_view_model.dart'
    as _i16;
import 'package:launch_tracker_app/presentation/features/launches/launches_view_model.dart'
    as _i15;
import 'package:logger/logger.dart' as _i5;
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i3.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i4.LaunchApi>(() => _i4.LaunchApi(gh<_i3.Dio>()));
    gh.factory<_i5.Logger>(() => registerModule.logger);
    await gh.factoryAsync<_i6.StreamingSharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i7.ErrorHandler>(
        () => _i7.ErrorHandler(gh<_i5.Logger>()));
    gh.lazySingleton<_i8.OperationService>(
        () => _i8.OperationService(gh<_i7.ErrorHandler>()));
    gh.lazySingleton<_i9.ShareService>(
        () => _i10.ShareServiceImpl(gh<_i8.OperationService>()));
    gh.lazySingleton<_i11.StorageRepository>(() => _i12.StorageRepositoryImpl(
          gh<_i6.StreamingSharedPreferences>(),
          gh<_i8.OperationService>(),
        ));
    gh.lazySingleton<_i13.LaunchRepository>(() => _i14.LaunchRepositoryImpl(
          gh<_i4.LaunchApi>(),
          gh<_i11.StorageRepository>(),
          gh<_i8.OperationService>(),
        ));
    gh.factory<_i15.LaunchesViewModel>(
        () => _i15.LaunchesViewModel(gh<_i13.LaunchRepository>()));
    gh.factoryParam<_i16.CountdownViewModel, String, dynamic>((
      launchId,
      _,
    ) =>
        _i16.CountdownViewModel(
          launchId,
          gh<_i13.LaunchRepository>(),
          gh<_i9.ShareService>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i17.RegisterModule {}
