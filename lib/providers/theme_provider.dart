import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants/app_constants.dart';
import '../services/firebase_analytics_service.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark; // Default: Dark theme
  bool _disposed = false;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadTheme();
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

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeIndex = prefs.getInt(AppConstants.themeKey) ?? ThemeMode.dark.index; // Default: Dark
    _themeMode = ThemeMode.values[themeModeIndex];
    _notifySafe();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    _notifySafe();
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(AppConstants.themeKey, mode.index);
    
    // Log analytics
    FirebaseAnalyticsService.logEvent(name: AppConstants.themeChanged, parameters: {
      'theme': mode.toString(),
    });
  }
}
