import 'package:dio/dio.dart';

abstract class DataState<T> {
  const DataState({
    this.data,
    this.dioException,
  });

  final T? data;
  final DioException? dioException;
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess({required T data}) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed({
    DioException? dioException,
  }) : super(dioException: dioException);
}
