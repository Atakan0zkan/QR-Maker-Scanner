import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';

class NetworkService {
  static final NetworkService _instance = NetworkService._internal();
  factory NetworkService() => _instance;
  NetworkService._internal();

  final _connectivityController = StreamController<bool>.broadcast();
  Stream<bool> get connectivityStream => _connectivityController.stream;

  bool _isOnline = true;
  bool get isOnline => _isOnline;

  Timer? _timer;

  void startMonitoring() {
    // İlk kontrolü yap
    checkConnectivity();
    
    // Her 10 saniyede bir kontrol et
    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      checkConnectivity();
    });
  }

  void stopMonitoring() {
    _timer?.cancel();
  }

  Future<void> checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      final wasOnline = _isOnline;
      _isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      
      if (wasOnline != _isOnline) {
        _connectivityController.add(_isOnline);
        if (kDebugMode) {
          print(_isOnline ? '✅ İnternet bağlantısı var' : '❌ İnternet bağlantısı yok');
        }
      }
    } catch (e) {
      final wasOnline = _isOnline;
      _isOnline = false;
      if (wasOnline != _isOnline) {
        _connectivityController.add(_isOnline);
        if (kDebugMode) {
          print('❌ İnternet bağlantısı yok');
        }
      }
    }
  }

  void dispose() {
    _timer?.cancel();
    _connectivityController.close();
  }
}
