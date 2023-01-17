import 'package:dio/dio.dart' hide Headers;
import 'package:injectable/injectable.dart';
import 'package:launch_tracker_app/src/network/constants.dart';
import 'package:retrofit/retrofit.dart';

part 'launch_api.g.dart';

@injectable
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class RestClient {
  @factoryMethod
  factory RestClient(Dio dio) = _RestClient;
}
