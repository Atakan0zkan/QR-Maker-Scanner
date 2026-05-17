// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generated_qr.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GeneratedQRAdapter extends TypeAdapter<GeneratedQR> {
  @override
  final int typeId = 1;

  @override
  GeneratedQR read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GeneratedQR(
      id: fields[0] as String,
      content: fields[1] as String,
      type: fields[2] as QRType,
      createdAt: fields[3] as DateTime,
      title: fields[4] as String?,
      qrImage: fields[5] as Uint8List?,
      isBarcode: fields[6] == null ? false : fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, GeneratedQR obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.qrImage)
      ..writeByte(6)
      ..write(obj.isBarcode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeneratedQRAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
