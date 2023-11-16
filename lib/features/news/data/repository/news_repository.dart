import 'dart:io';

import 'package:dio/dio.dart';
import 'package:bin7r4decl/core/constants/request_helper.dart';
import 'package:bin7r4decl/core/resources/data_state.dart';
import '../data_sources/news_api.dart';
import '../models/news_model.dart';

class NewsRepository {
  NewsRepository(this._newsApi);

  final NewsApi _newsApi;

  Future<DataState<List<NewsModel>>> getNews() async {
    try {
      final httpResponse = await _newsApi.getNews(
        AppTokens.beretukToken,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(data: httpResponse.data['results']!);
      } else {
        return DataFailed(
          dioException: DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(dioException: e);
    }
  }
}
