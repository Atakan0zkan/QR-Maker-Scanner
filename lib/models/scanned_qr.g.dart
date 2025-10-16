// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scanned_qr.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScannedQRAdapter extends TypeAdapter<ScannedQR> {
  @override
  final int typeId = 0;

  @override
  ScannedQR read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScannedQR(
      id: fields[0] as String,
      content: fields[1] as String,
      type: fields[2] as QRType,
      scannedAt: fields[3] as DateTime,
      metadata: (fields[4] as Map?)?.cast<String, dynamic>(),
      isBarcode: fields[5] == null ? false : fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ScannedQR obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.scannedAt)
      ..writeByte(4)
      ..write(obj.metadata)
      ..writeByte(5)
      ..write(obj.isBarcode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScannedQRAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
