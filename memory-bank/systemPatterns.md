# System Patterns - QR Scanner & Generator

## Mimari Genel Bakış

```
lib/
├── main.dart                         # Uygulama giriş noktası
├── firebase_options.dart             # Firebase config (auto-generated)
├── core/
│   ├── constants/
│   │   ├── app_constants.dart        # Sabit değerler (box names, keys, analytics events)
│   │   └── app_colors.dart           # Renk paleti
│   └── theme/
│       └── app_theme.dart            # Light/Dark tema tanımları
├── models/                           # Hive veri modelleri
│   ├── qr_type.dart                  # QRType enum (9 tür)
│   ├── scanned_qr.dart              # Taranan QR modeli
│   └── generated_qr.dart            # Oluşturulan QR modeli
├── providers/                        # State Management (Provider)
│   ├── qr_provider.dart             # QR CRUD işlemleri
│   ├── theme_provider.dart          # Tema yönetimi
│   ├── locale_provider.dart         # Dil yönetimi
│   └── settings_provider.dart       # Uygulama ayarları (vibrate on scan)
├── services/                         # İş mantığı servisleri
│   ├── database_service.dart        # Hive DB (şifreli)
│   ├── ad_service.dart              # AdMob yönetimi
│   ├── firebase_analytics_service.dart  # Firebase Analytics
│   ├── feedback_service.dart        # Bug reporting
│   ├── permission_service.dart      # İzin yönetimi
│   └── qr_helper.dart              # QR format utilities
├── screens/                          # UI Ekranları
│   ├── main_screen.dart             # Bottom Navigation
│   ├── scanner_screen.dart          # QR tarama
│   ├── create_screen.dart           # QR oluşturma (68KB - en büyük)
│   ├── history_screen.dart          # Geçmiş
│   ├── settings_screen.dart         # Ayarlar
│   ├── qr_detail_screen.dart        # QR detay
│   ├── privacy_policy_screen.dart   # Gizlilik politikası
│   └── terms_of_service_screen.dart # Kullanım şartları
├── widgets/                          # Yeniden kullanılabilir widget'lar
│   ├── scanner_overlay.dart         # Tarayıcı overlay UI
│   └── permission_dialog.dart       # İzin dialog'u
└── l10n/                            # Lokalizasyon (18 ARB, 16 aktif dil)
    ├── app_*.arb                    # Çeviri dosyaları
    └── app_localizations*.dart      # Auto-generated delegates
```

## Anahtar Teknik Kararlar

### 1. State Management: Provider
- `ChangeNotifier` + `ChangeNotifierProvider` pattern
- `Consumer2` ile çoklu provider dinleme (tema + dil)
- `_disposed` flag ile güvenli `notifyListeners()` çağrısı (memory leak önleme)

### 2. Veritabanı: Hive (Şifreli)
- `HiveAesCipher` ile AES şifreleme
- Şifreleme anahtarı `flutter_secure_storage` ile güvenli saklama
  - Android: `EncryptedSharedPreferences`
  - iOS: `Keychain`
- 2 şifreli box: `scannedQrBox`, `generatedQrBox`
- Tüm model sınıfları `HiveObject` extend eder ve `@HiveType` annotation kullanır

### 3. Servis Başlatma (Performans)
```dart
// Kritik servisler paralel başlatma
await Future.wait([
  Firebase.initializeApp(...),
  DatabaseService.init(),
]);

// Kritik olmayan servisler lazy başlatma
AdService.initialize().then((_) { ... }).ignore();
```

### 4. Logging Stratejisi
- `print()` kullanılmaz (avoid_print lint rule)
- `dart:developer` `developer.log()` ile production-safe logging
- `kDebugMode` kontrolü ile sadece debug'da log

### 5. Analytics Stratejisi
- Firebase Analytics ile anonim kullanım istatistikleri
- QR içerikleri ASLA loglanmaz
- Event isimleri `AppConstants` içinde merkezi olarak tanımlı

## Tasarım Desenleri
1. **Service Locator (Static)**: Tüm servisler static method'larla çağrılır (`DatabaseService.init()`)
2. **Provider Pattern**: UI state yönetimi
3. **Builder Pattern**: QR oluşturma form alanları
4. **Repository Pattern**: `DatabaseService` veri erişim katmanı
5. **Observer Pattern**: `ChangeNotifier` ile reaktif UI

## Bileşen İlişkileri
```
main.dart
  ├── Firebase.initializeApp()
  ├── DatabaseService.init()
  ├── FirebaseAnalyticsService.initialize()
  ├── AdService.initialize()
  └── MyApp (MultiProvider)
        ├── ThemeProvider → SharedPreferences
        ├── LocaleProvider → SharedPreferences
        ├── QRProvider → DatabaseService → Hive
        ├── SettingsProvider → SharedPreferences
        └── MainScreen (BottomNavigationBar)
              ├── ScannerScreen → mobile_scanner, QRProvider
              ├── CreateScreen → qr_flutter, QRProvider, AdService
              ├── HistoryScreen → QRProvider
              └── SettingsScreen → ThemeProvider, LocaleProvider, FeedbackService
```
