// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_event.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnalyticsEventAdapter extends TypeAdapter<AnalyticsEvent> {
  @override
  final int typeId = 3;

  @override
  AnalyticsEvent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AnalyticsEvent(
      eventName: fields[0] as String,
      timestamp: fields[1] as DateTime,
      properties: (fields[2] as Map?)?.cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, AnalyticsEvent obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.eventName)
      ..writeByte(1)
      ..write(obj.timestamp)
      ..writeByte(2)
      ..write(obj.properties);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnalyticsEventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
