import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
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

  static Future<bool> saveScannedQR(ScannedQR qr) async {
    try {
      await scannedBox.put(qr.id, qr);
      return true;
    } catch (e) {
      if (kDebugMode) developer.log('Error saving scanned QR: $e', name: 'DatabaseService');
      return false;
    }
  }

  static List<ScannedQR> getAllScannedQRs() {
    return scannedBox.values.toList()
      ..sort((a, b) => b.scannedAt.compareTo(a.scannedAt));
  }

  static Future<bool> deleteScannedQR(String id) async {
    try {
      await scannedBox.delete(id);
      return true;
    } catch (e) {
      if (kDebugMode) developer.log('Error deleting scanned QR: $e', name: 'DatabaseService');
      return false;
    }
  }

  static Future<bool> clearAllScannedQRs() async {
    try {
      await scannedBox.clear();
      return true;
    } catch (e) {
      if (kDebugMode) developer.log('Error clearing scanned QRs: $e', name: 'DatabaseService');
      return false;
    }
  }

  // Generated QR operations
  static Box<GeneratedQR> get generatedBox => Hive.box<GeneratedQR>(generatedBoxName);

  static Future<bool> saveGeneratedQR(GeneratedQR qr) async {
    try {
      await generatedBox.put(qr.id, qr);
      return true;
    } catch (e) {
      if (kDebugMode) developer.log('Error saving generated QR: $e', name: 'DatabaseService');
      return false;
    }
  }

  static List<GeneratedQR> getAllGeneratedQRs() {
    return generatedBox.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  static Future<bool> deleteGeneratedQR(String id) async {
    try {
      await generatedBox.delete(id);
      return true;
    } catch (e) {
      if (kDebugMode) developer.log('Error deleting generated QR: $e', name: 'DatabaseService');
      return false;
    }
  }

  static Future<bool> clearAllGeneratedQRs() async {
    try {
      await generatedBox.clear();
      return true;
    } catch (e) {
      if (kDebugMode) developer.log('Error clearing generated QRs: $e', name: 'DatabaseService');
      return false;
    }
  }
}
