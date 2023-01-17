import 'package:dio/dio.dart' hide Headers;
import 'package:injectable/injectable.dart';
import 'package:launch_tracker_app/src/data/network_api/api_constants.dart';
import 'package:launch_tracker_app/src/domain/entities/launch.dart';
import 'package:retrofit/retrofit.dart';

part 'launch_api.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class LaunchApi {
  @factoryMethod
  factory LaunchApi(Dio dio) = _LaunchApi;

  @GET('launches/upcoming')
  Future<List<Launch>> getLaunches();
}
