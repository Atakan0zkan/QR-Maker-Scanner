import 'package:flutter/material.dart';
import 'dart:ui' as ui;

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

  void _loadLocale() {
    // Kullanıcının sistem dilini al
    final systemLocale = ui.PlatformDispatcher.instance.locale;
    final systemLanguageCode = systemLocale.languageCode;
    
    // Eğer sistem dili destekleniyorsa onu kullan, yoksa İngilizce
    if (supportedLanguages.contains(systemLanguageCode)) {
      _locale = Locale(systemLanguageCode);
    } else {
      _locale = const Locale('en'); // Default: İngilizce
    }
    
    notifyListeners();
  }
}
