import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:bin7r4decl/core/constants/request_helper.dart';

part 'base_api.g.dart';

@RestApi(baseUrl: AppUrls.weretekBaseUrl)
abstract class BaseApi {
  factory BaseApi(Dio dio) = _BaseApi;

  @GET('/app/b1intradecl1ub')
  Future<HttpResponse> getOnboardingNum();
}
