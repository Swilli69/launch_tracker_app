// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:launch_tracker_app/data/network_api/launch_api.dart' as _i4;
import 'package:launch_tracker_app/data/repositories/launch_repository_impl.dart'
    as _i9;
import 'package:launch_tracker_app/data/services/share_service_impl.dart'
    as _i6;
import 'package:launch_tracker_app/dependencies/register_module.dart' as _i12;
import 'package:launch_tracker_app/domain/repositories/launch_repository.dart'
    as _i8;
import 'package:launch_tracker_app/domain/services/share_service.dart' as _i5;
import 'package:launch_tracker_app/presentation/features/countdown/countdown_view_model.dart'
    as _i11;
import 'package:launch_tracker_app/presentation/features/launches/launches_view_model.dart'
    as _i10;
import 'package:shared_preferences/shared_preferences.dart' as _i7;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
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
    gh.lazySingleton<_i5.ShareService>(() => _i6.ShareServiceImpl());
    await gh.factoryAsync<_i7.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i8.LaunchRepository>(() => _i9.LaunchRepositoryImpl(
          gh<_i4.LaunchApi>(),
          gh<_i7.SharedPreferences>(),
        ));
    gh.factory<_i10.LaunchesViewModel>(
        () => _i10.LaunchesViewModel(gh<_i8.LaunchRepository>()));
    gh.factoryParam<_i11.CountdownViewModel, String, dynamic>((
      launchId,
      _,
    ) =>
        _i11.CountdownViewModel(
          launchId,
          gh<_i8.LaunchRepository>(),
          gh<_i5.ShareService>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i12.RegisterModule {}
