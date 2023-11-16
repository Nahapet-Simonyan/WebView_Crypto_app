import 'dart:io';

import 'package:dio/dio.dart';
import 'package:bin7r4decl/core/resources/data_state.dart';

import '../data_sources/base_api.dart';

class BaseRepository {
  BaseRepository(this._onboardingApi);

  final BaseApi _onboardingApi;

  Future<DataState> getOnboardingNum() async {
    try {
      final httpResponse = await _onboardingApi.getOnboardingNum();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(data: httpResponse.data);
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
      // print(e);
      return DataFailed(dioException: e);
    }
  }
}
