// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsModel _$NewsModelFromJson(Map<String, dynamic> json) => NewsModel(
      resultImage: json['resultImage'] as String,
      resultMark: json['resultMark'] as String,
      resultDateTime: json['resultDateTime'] as String,
      resultText: json['resultText'] as String,
      resultTotalLikes: json['resultTotalLikes'] as int,
      resultTotalComments: json['resultTotalComments'] as int,
      resultId: json['resultId'] as int,
      resultTitle: json['resultTitle'] as String,
    );

Map<String, dynamic> _$NewsModelToJson(NewsModel instance) => <String, dynamic>{
      'resultId': instance.resultId,
      'resultTitle': instance.resultTitle,
      'resultImage': instance.resultImage,
      'resultMark': instance.resultMark,
      'resultDateTime': instance.resultDateTime,
      'resultText': instance.resultText,
      'resultTotalLikes': instance.resultTotalLikes,
      'resultTotalComments': instance.resultTotalComments,
    };
