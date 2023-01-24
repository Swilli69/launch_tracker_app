import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:launch_tracker_app/src/dependencies/injectable.config.dart';

@InjectableInit()
Future<GetIt> configureDependencies() => GetIt.instance.init();