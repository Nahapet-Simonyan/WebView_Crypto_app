import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:bin7r4decl/features/news/data/models/news_model.dart';

abstract class NewsState extends Equatable {
  final List<NewsModel>? news;
  final DioException? error;

  const NewsState({
    this.news,
    this.error,
  });

  @override
  List<Object> get props => [news ?? 'news', error ?? 'error'];
}

class NewsLoading extends NewsState {
  const NewsLoading();
}

class NewsDone extends NewsState {
  const NewsDone({required List<NewsModel>? news}) : super(news: news);
}

class NewsError extends NewsState {
  const NewsError(DioException exception) : super(error: exception);
}
