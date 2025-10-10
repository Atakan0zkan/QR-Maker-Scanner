import 'package:hive_flutter/hive_flutter.dart';
import '../models/scanned_qr.dart';
import '../models/generated_qr.dart';
import '../models/qr_type.dart';

class DatabaseService {
  static const String scannedBoxName = 'scanned_qr';
  static const String generatedBoxName = 'generated_qr';

  static Future<void> init() async {
    await Hive.initFlutter();
    
    // Register adapters
    Hive.registerAdapter(QRTypeAdapter());
    Hive.registerAdapter(ScannedQRAdapter());
    Hive.registerAdapter(GeneratedQRAdapter());
    
    // Open boxes
    await Hive.openBox<ScannedQR>(scannedBoxName);
    await Hive.openBox<GeneratedQR>(generatedBoxName);
  }

  // Scanned QR operations
  static Box<ScannedQR> get scannedBox => Hive.box<ScannedQR>(scannedBoxName);

  static Future<void> saveScannedQR(ScannedQR qr) async {
    await scannedBox.put(qr.id, qr);
  }

  static List<ScannedQR> getAllScannedQRs() {
    return scannedBox.values.toList()
      ..sort((a, b) => b.scannedAt.compareTo(a.scannedAt));
  }

  static Future<void> deleteScannedQR(String id) async {
    await scannedBox.delete(id);
  }

  static Future<void> clearAllScannedQRs() async {
    await scannedBox.clear();
  }

  // Generated QR operations
  static Box<GeneratedQR> get generatedBox => Hive.box<GeneratedQR>(generatedBoxName);

  static Future<void> saveGeneratedQR(GeneratedQR qr) async {
    await generatedBox.put(qr.id, qr);
  }

  static List<GeneratedQR> getAllGeneratedQRs() {
    return generatedBox.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  static Future<void> deleteGeneratedQR(String id) async {
    await generatedBox.delete(id);
  }

  static Future<void> clearAllGeneratedQRs() async {
    await generatedBox.clear();
  }
}
