import 'dart:typed_data';
import 'package:hive/hive.dart';
import 'qr_type.dart';

part 'generated_qr.g.dart';

@HiveType(typeId: 1)
class GeneratedQR extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String content;

  @HiveField(2)
  late QRType type;

  @HiveField(3)
  late DateTime createdAt;

  @HiveField(4)
  String? title;

  @HiveField(5)
  Uint8List? qrImage;

  @HiveField(6, defaultValue: false)
  bool isBarcode;

  GeneratedQR({
    required this.id,
    required this.content,
    required this.type,
    required this.createdAt,
    this.title,
    this.qrImage,
    this.isBarcode = false,
  });
}
