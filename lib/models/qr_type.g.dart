// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QRTypeAdapter extends TypeAdapter<QRType> {
  @override
  final int typeId = 2;

  @override
  QRType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return QRType.url;
      case 1:
        return QRType.text;
      case 2:
        return QRType.wifi;
      case 3:
        return QRType.contact;
      case 4:
        return QRType.email;
      case 5:
        return QRType.sms;
      case 6:
        return QRType.phone;
      case 7:
        return QRType.location;
      case 8:
        return QRType.social;
      default:
        return QRType.url;
    }
  }

  @override
  void write(BinaryWriter writer, QRType obj) {
    switch (obj) {
      case QRType.url:
        writer.writeByte(0);
        break;
      case QRType.text:
        writer.writeByte(1);
        break;
      case QRType.wifi:
        writer.writeByte(2);
        break;
      case QRType.contact:
        writer.writeByte(3);
        break;
      case QRType.email:
        writer.writeByte(4);
        break;
      case QRType.sms:
        writer.writeByte(5);
        break;
      case QRType.phone:
        writer.writeByte(6);
        break;
      case QRType.location:
        writer.writeByte(7);
        break;
      case QRType.social:
        writer.writeByte(8);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QRTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
