class AppConstants {
  // SharedPreferences Keys
  static const String localeKey = 'locale';
  static const String themeKey = 'theme_mode';

  // Hive Box Names
  static const String analyticsBox = 'analytics_events';
  static const String scannedQrBox = 'scanned_qr';
  static const String generatedQrBox = 'generated_qr';

  // Analytics Events
  static const String languageChanged = 'language_changed';
  static const String themeChanged = 'theme_changed';
  static const String qrScanned = 'qr_scanned';
  static const String qrGenerated = 'qr_generated';
  static const String appOpened = 'app_opened';
}
