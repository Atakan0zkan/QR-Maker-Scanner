import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/scanned_qr.dart';
import '../models/generated_qr.dart';
import '../models/qr_type.dart';
import '../services/database_service.dart';

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

  Future<void> addScannedQR({
    required String content,
    required QRType type,
    Map<String, dynamic>? metadata,
  }) async {
    final qr = ScannedQR(
      id: const Uuid().v4(),
      content: content,
      type: type,
      scannedAt: DateTime.now(),
      metadata: metadata,
    );

    await DatabaseService.saveScannedQR(qr);
    loadData();
  }

  Future<void> addGeneratedQR({
    required String content,
    required QRType type,
    String? title,
    dynamic qrImage,
  }) async {
    final qr = GeneratedQR(
      id: const Uuid().v4(),
      content: content,
      type: type,
      createdAt: DateTime.now(),
      title: title,
      qrImage: qrImage,
    );

    await DatabaseService.saveGeneratedQR(qr);
    loadData();
  }

  Future<void> deleteScannedQR(String id) async {
    await DatabaseService.deleteScannedQR(id);
    loadData();
  }

  Future<void> deleteGeneratedQR(String id) async {
    await DatabaseService.deleteGeneratedQR(id);
    loadData();
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
