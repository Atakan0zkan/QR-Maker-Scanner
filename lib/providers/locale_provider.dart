import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;
import '../core/constants/app_constants.dart';
import '../services/firebase_analytics_service.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  // Desteklenen diller
  static const List<String> supportedLanguages = [
    'en', // İngilizce
    'tr', // Türkçe
    'es', // İspanyolca
    'de', // Almanca
    'fr', // Fransızca
    'it', // İtalyanca
    'el', // Yunanca
    'ar', // Arapça
    'zh', // Çince
    'ja', // Japonca
  ];

  LocaleProvider() {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguageCode = prefs.getString(AppConstants.localeKey);
    
    if (savedLanguageCode != null && supportedLanguages.contains(savedLanguageCode)) {
      // Kullanıcı daha önce bir dil seçmiş, onu kullan
      _locale = Locale(savedLanguageCode);
    } else {
      // Kullanıcı dil seçmemiş, sistem dilini kullan
      final systemLocale = ui.PlatformDispatcher.instance.locale;
      final systemLanguageCode = systemLocale.languageCode;
      
      // Eğer sistem dili destekleniyorsa onu kullan, yoksa İngilizce
      if (supportedLanguages.contains(systemLanguageCode)) {
        _locale = Locale(systemLanguageCode);
      } else {
        _locale = const Locale('en'); // Default: İngilizce
      }
    }
    
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    if (!supportedLanguages.contains(locale.languageCode)) {
      return;
    }
    
    _locale = locale;
    notifyListeners();
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.localeKey, locale.languageCode);
    
    // Log analytics
    FirebaseAnalyticsService.logEvent(name: AppConstants.languageChanged, parameters: {
      'language': locale.languageCode,
    });
  }
}
