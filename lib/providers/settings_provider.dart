import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  static const String _keyVibrateOnScan = 'vibrate_on_scan';
  
  bool _vibrateOnScan = false;
  bool _disposed = false;
  bool get vibrateOnScan => _vibrateOnScan;

  SettingsProvider() {
    _loadSettings();
  }

  void _notifySafe() {
    if (_disposed) return;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _vibrateOnScan = prefs.getBool(_keyVibrateOnScan) ?? false;
    _notifySafe();
  }

  Future<void> setVibrateOnScan(bool value) async {
    if (_vibrateOnScan == value) return;
    
    _vibrateOnScan = value;
    _notifySafe();
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyVibrateOnScan, value);
  }
}
