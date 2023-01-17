import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:launch_tracker_app/src/injectable/injectable.config.dart';

@InjectableInit()
GetIt configureDependencies() => GetIt.instance.init();
