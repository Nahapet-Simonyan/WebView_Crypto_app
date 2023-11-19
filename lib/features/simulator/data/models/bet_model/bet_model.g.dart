// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bet_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BetModelAdapter extends TypeAdapter<BetModel> {
  @override
  final int typeId = 1;

  @override
  BetModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BetModel(
      currencyPair: fields[0] as String,
      amount: fields[1] as int,
      type: fields[2] as String,
      startTime: fields[3] as DateTime,
      endTime: fields[4] as DateTime,
      isFinished: fields[5] as bool,
      isWon: fields[6] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, BetModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.currencyPair)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.startTime)
      ..writeByte(4)
      ..write(obj.endTime)
      ..writeByte(5)
      ..write(obj.isFinished)
      ..writeByte(6)
      ..write(obj.isWon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BetModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
