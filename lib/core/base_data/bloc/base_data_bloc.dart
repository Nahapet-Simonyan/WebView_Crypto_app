import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bin7r4decl/core/resources/data_state.dart';

import '../base_data.dart';

class BaseDataBloc extends Bloc<BaseDataEvent, BaseDataState> {
  BaseDataBloc(this._baseRepository) : super(const BaseDataLoading()) {
    on<GetData>(onGetData);
  }

  final BaseRepository _baseRepository;

  void onGetData(GetData event, Emitter<BaseDataState> emit) async {
    emit(const BaseDataLoading());
    final dataState = await _baseRepository.getOnboardingNum();

    if (dataState is DataSuccess) {
      emit(BaseDataDone(num: dataState.data));
    }
    if (dataState is DataFailed) {
      print(dataState.dioException!);
      emit(BaseDataError(dataState.dioException!));
    }
  }
}
