import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:bin7r4decl/core/constants/request_helper.dart';
import 'package:bin7r4decl/features/news/data/models/news_model.dart';

part 'news_api.g.dart';

@RestApi(baseUrl: AppUrls.beretukBaseUrl)
abstract class NewsApi {
  factory NewsApi(Dio dio) = _NewsApi;

  @GET('/news')
  Future<HttpResponse<Map<String, List<NewsModel>>>> getNews(
    @Query('token') String token,
  );
}
