import 'package:json_annotation/json_annotation.dart';

part 'currency_item.g.dart';

/// "resultIdItem": 3,
/// "resultCurrencyItem": "EURUSD",

@JsonSerializable()
class CurrencyItem {

  @JsonKey(name: "resultIdItem")
  final int? id;

  @JsonKey(name: "resultCurrencyItem")
  final String? currencyPair;

  CurrencyItem({
    this.id,
    this.currencyPair,
  });


  factory CurrencyItem.fromJson(Map<String,dynamic> json){
    return _$CurrencyItemFromJson(json);
  }

}