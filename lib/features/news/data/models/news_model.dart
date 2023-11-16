import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news_model.g.dart';

@JsonSerializable()
class NewsModel extends Equatable {
  const NewsModel({
    required this.resultImage,
    required this.resultMark,
    required this.resultDateTime,
    required this.resultText,
    required this.resultTotalLikes,
    required this.resultTotalComments,
    required this.resultId,
    required this.resultTitle,
  });

  final int resultId;
  final String resultTitle;
  final String resultImage;
  final String resultMark;
  final String resultDateTime;
  final String resultText;
  final int resultTotalLikes;
  final int resultTotalComments;

  @override
  List<Object?> get props => [
        resultImage,
        resultMark,
        resultDateTime,
        resultText,
        resultTotalLikes,
        resultTotalComments,
        resultId,
        resultTitle,
      ];

  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);
}
