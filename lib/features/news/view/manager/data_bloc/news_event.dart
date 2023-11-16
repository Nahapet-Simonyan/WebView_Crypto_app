import 'dart:async';
import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable{
  const NewsEvent();
}

class GetNews extends NewsEvent {
  const GetNews({this.completer});

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}