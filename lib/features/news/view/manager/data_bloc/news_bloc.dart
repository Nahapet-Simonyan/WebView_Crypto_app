import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bin7r4decl/core/resources/data_state.dart';
import 'package:bin7r4decl/features/news/data/repository/news_repository.dart';

import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc(this._newsRepository) : super(const NewsLoading()) {
    on<GetNews>(onGetData);
  }

  final NewsRepository _newsRepository;

  void onGetData(GetNews event, Emitter<NewsState> emit) async {
    emit(const NewsLoading());
    final dataState = await _newsRepository.getNews();

    if (dataState is DataSuccess) {
      emit(NewsDone(news: dataState.data!));
      event.completer?.complete();
    }
    if (dataState is DataFailed) {
      emit(NewsError(dataState.dioException!));
    }
  }
}
