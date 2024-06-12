// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderModelAdapter extends TypeAdapter<ReminderModel> {
  @override
  final int typeId = 0;

  @override
  ReminderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReminderModel(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      time: fields[3] as DateTime,
      repeatInterval: fields[4] as RepeatInterval,
    );
  }

  @override
  void write(BinaryWriter writer, ReminderModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.repeatInterval);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RepeatIntervalAdapter extends TypeAdapter<RepeatInterval> {
  @override
  final int typeId = 1;

  @override
  RepeatInterval read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return RepeatInterval.none;
      case 1:
        return RepeatInterval.daily;
      case 2:
        return RepeatInterval.weekly;
      case 3:
        return RepeatInterval.monthly;
      default:
        return RepeatInterval.none;
    }
  }

  @override
  void write(BinaryWriter writer, RepeatInterval obj) {
    switch (obj) {
      case RepeatInterval.none:
        writer.writeByte(0);
        break;
      case RepeatInterval.daily:
        writer.writeByte(1);
        break;
      case RepeatInterval.weekly:
        writer.writeByte(2);
        break;
      case RepeatInterval.monthly:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RepeatIntervalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
