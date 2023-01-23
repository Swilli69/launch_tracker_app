import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:launch_tracker_app/src/domain/repositories/launch_repository.dart';
import 'package:launch_tracker_app/src/injectable/injectable.config.dart';
import 'package:launch_tracker_app/src/presentation/features/countdown/countdown_view_model.dart';

@InjectableInit()
GetIt configureDependencies() {
  final getIt = GetIt.instance.init();

  getIt.registerSingleton<Dio>(Dio());
  getIt.registerFactoryParam<CountdownViewModel, String, void>(
    (id, _) => CountdownViewModel(id, getIt.get<LaunchRepository>()),
  );

  return getIt;
}
