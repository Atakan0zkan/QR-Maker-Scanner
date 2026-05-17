import 'package:hive/hive.dart';
import 'qr_type.dart';

part 'scanned_qr.g.dart';

@HiveType(typeId: 0)
class ScannedQR extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String content;

  @HiveField(2)
  late QRType type;

  @HiveField(3)
  late DateTime scannedAt;

  @HiveField(4)
  Map<String, dynamic>? metadata;

  @HiveField(5, defaultValue: false)
  bool isBarcode;

  ScannedQR({
    required this.id,
    required this.content,
    required this.type,
    required this.scannedAt,
    this.metadata,
    this.isBarcode = false,
  });
}
