// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyItem _$CurrencyItemFromJson(Map<String, dynamic> json) => CurrencyItem(
      id: json['resultIdItem'] as int?,
      currencyPair: json['resultCurrencyItem'] as String?,
    );

Map<String, dynamic> _$CurrencyItemToJson(CurrencyItem instance) =>
    <String, dynamic>{
      'resultIdItem': instance.id,
      'resultCurrencyItem': instance.currencyPair,
    };
