import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class BaseDataState extends Equatable {
  const BaseDataState({this.num, this.error});

  final String? num;
  final DioException? error;

  @override
  List<Object> get props => [num ?? 0, error ?? 'error'];
}

class BaseDataLoading extends BaseDataState {
  const BaseDataLoading();
}

class BaseDataDone extends BaseDataState {
  const BaseDataDone({required String? num}) : super(num: num);
}

class BaseDataError extends BaseDataState {
  const BaseDataError(DioException exception) : super(error: exception);
}
