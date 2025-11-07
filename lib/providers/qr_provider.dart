import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/scanned_qr.dart';
import '../models/generated_qr.dart';
import '../models/qr_type.dart';
import '../services/database_service.dart';
import '../core/constants/app_constants.dart';
import '../services/firebase_analytics_service.dart';

class QRProvider extends ChangeNotifier {
  List<ScannedQR> _scannedQRs = [];
  List<GeneratedQR> _generatedQRs = [];

  List<ScannedQR> get scannedQRs => _scannedQRs;
  List<GeneratedQR> get generatedQRs => _generatedQRs;

  QRProvider() {
    loadData();
  }

  void loadData() {
    _scannedQRs = DatabaseService.getAllScannedQRs();
    _generatedQRs = DatabaseService.getAllGeneratedQRs();
    notifyListeners();
  }

  Future<bool> addScannedQR({
    required String content,
    required QRType type,
    Map<String, dynamic>? metadata,
    bool isBarcode = false,
  }) async {
    final qr = ScannedQR(
      id: const Uuid().v4(),
      content: content,
      type: type,
      scannedAt: DateTime.now(),
      metadata: metadata,
      isBarcode: isBarcode,
    );

    final success = await DatabaseService.saveScannedQR(qr);
    if (success) {
      loadData();
      // Log analytics
      FirebaseAnalyticsService.logEvent(name: AppConstants.qrScanned, parameters: {
        'type': type.toString(),
        'is_barcode': isBarcode,
      });
    }
    return success;
  }

  Future<bool> addGeneratedQR({
    required String content,
    required QRType type,
    String? title,
    dynamic qrImage,
    bool isBarcode = false,
  }) async {
    final qr = GeneratedQR(
      id: const Uuid().v4(),
      content: content,
      type: type,
      createdAt: DateTime.now(),
      title: title,
      qrImage: qrImage,
      isBarcode: isBarcode,
    );

    final success = await DatabaseService.saveGeneratedQR(qr);
    if (success) {
      loadData();
      // Log analytics
      FirebaseAnalyticsService.logEvent(name: AppConstants.qrGenerated, parameters: {
        'type': type.toString(),
        'has_title': title != null,
      });
    }
    return success;
  }

  Future<bool> deleteScannedQR(String id) async {
    final success = await DatabaseService.deleteScannedQR(id);
    if (success) {
      loadData();
    }
    return success;
  }

  Future<bool> deleteGeneratedQR(String id) async {
    final success = await DatabaseService.deleteGeneratedQR(id);
    if (success) {
      loadData();
    }
    return success;
  }

  Future<void> clearAllScanned() async {
    await DatabaseService.clearAllScannedQRs();
    loadData();
  }

  Future<void> clearAllGenerated() async {
    await DatabaseService.clearAllGeneratedQRs();
    loadData();
  }
}
