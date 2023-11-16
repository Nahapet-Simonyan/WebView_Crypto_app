import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bin7r4decl/core/constants/hive.dart';

part 'bet_model.g.dart';

@HiveType(typeId: HiveTypeId.bettingModelId)
class BetModel extends Equatable {
  const BetModel({
    required this.currencyPair,
    required this.amount,
    required this.type,
    required this.startTime,
    required this.endTime,
    required this.isFinished,
    this.isWon
  });

  @HiveField(0)
  final String currencyPair;

  @HiveField(1)
  final int amount;

  @HiveField(2)
  final String type;

  @HiveField(3)
  final DateTime startTime;

  @HiveField(4)
  final DateTime endTime;

  @HiveField(5)
  final bool isFinished;

  @HiveField(6)
  final bool? isWon;

  @override
  List<Object> get props => [
        currencyPair,
        amount,
        type,
        startTime,
        endTime,
        isFinished,
      ];
}
