// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:launch_tracker_app/src/data/network_api/launch_api.dart' as _i4;
import 'package:launch_tracker_app/src/data/repositories/launch_repository_impl.dart'
    as _i6;
import 'package:launch_tracker_app/src/domain/repositories/launch_repository.dart'
    as _i5;
import 'package:launch_tracker_app/src/injectable/register_modules.dart' as _i8;
import 'package:launch_tracker_app/src/presentation/features/launches/launches_view_model.dart'
    as _i7;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModules = _$RegisterModules();
    gh.factory<_i3.Dio>(() => registerModules.dio);
    gh.lazySingleton<_i4.LaunchApi>(() => _i4.LaunchApi(gh<_i3.Dio>()));
    gh.lazySingleton<_i5.LaunchRepository>(
        () => _i6.LaunchRepositoryImpl(gh<_i4.LaunchApi>()));
    gh.factory<_i7.LaunchesViewModel>(
        () => _i7.LaunchesViewModel(gh<_i5.LaunchRepository>()));
    return this;
  }
}

class _$RegisterModules extends _i8.RegisterModules {}
