import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:launch_tracker_app/dependencies/injectable.config.dart';

@InjectableInit()
Future<GetIt> configureDependencies() => GetIt.instance.init();