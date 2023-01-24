import 'package:dio/dio.dart' hide Headers;
import 'package:injectable/injectable.dart';
import 'package:launch_tracker_app/data/network_api/constants/api_constants.dart';
import 'package:launch_tracker_app/data/network_api/entities/launch_model.dart';
import 'package:retrofit/retrofit.dart';

part 'launch_api.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class LaunchApi {
  @factoryMethod
  factory LaunchApi(Dio dio) = _LaunchApi;

  @GET('launches/upcoming')
  Future<List<LaunchModel>> getLaunches();

  @GET('launches/{id}')
  Future<LaunchModel> getNextLaunch(@Path("id") String id);
}
