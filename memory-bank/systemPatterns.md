# System Patterns - QR Scanner & Generator

## Mimari Genel Bakış

```
lib/
├── main.dart                          # Giriş noktası (120 satır)
├── firebase_options.dart              # Firebase config (auto-generated)
├── core/
│   ├── constants/
│   │   ├── app_constants.dart         # SharedPrefs keys, Hive box names, analytics events
│   │   ├── app_colors.dart            # Renk paleti
│   │   └── app_gradients.dart        # 15 preset gradient (GradientPreset + AppGradients)
│   └── theme/
│       └── app_theme.dart             # Light/Dark tema (Material 3, Inter font)
├── models/                            # Hive veri modelleri
│   ├── qr_type.dart                   # QRType enum (9 tür) — TypeId: 2
│   ├── scanned_qr.dart               # ScannedQR — TypeId: 0
│   └── generated_qr.dart             # GeneratedQR — TypeId: 1
├── providers/                         # State Management (Provider)
│   ├── qr_provider.dart              # QR CRUD + analytics
│   ├── theme_provider.dart           # Tema (default: Dark)
│   ├── locale_provider.dart          # 17 dil + sistem dili algılama
│   └── settings_provider.dart        # Ayarlar (vibrate on scan)
├── services/                          # İş mantığı (static pattern)
│   ├── database_service.dart         # Hive DB (AES şifreli)
│   ├── ad_service.dart               # AdMob interstitial
│   ├── firebase_analytics_service.dart # Firebase Analytics
│   ├── feedback_service.dart         # Bug reporting
│   ├── permission_service.dart       # Kamera/depolama izinleri
│   └── qr_helper.dart               # QR format utilities
├── screens/                           # UI Ekranları
│   ├── main_screen.dart              # Bottom Navigation (90 satır)
│   ├── scanner_screen.dart           # QR tarama (408 satır)
│   ├── create_screen.dart            # QR oluşturma (~1600 satır) ✅ Refactored
│   ├── history_screen.dart           # Geçmiş (485 satır)
│   ├── settings_screen.dart          # Ayarlar (318 satır)
│   ├── qr_detail_screen.dart         # QR detay (433 satır)
│   ├── privacy_policy_screen.dart    # Gizlilik (68 satır)
│   └── terms_of_service_screen.dart  # Kullanım şartları (94 satır)
├── widgets/
│   ├── scanner_overlay.dart          # Animated scan line (184 satır)
│   └── permission_dialog.dart        # Kamera izni dialog (75 satır)
└── l10n/                             # 17 ARB + auto-generated delegates
```

## Anahtar Teknik Kararlar

### 1. State Management: Provider
- `ChangeNotifier` + `MultiProvider` (4 provider)
- `Consumer2` ile tema + dil birlikte dinleme
- **Tüm 4 provider'da** `_disposed` + `_notifySafe()` pattern (memory leak önleme)

### 2. Veritabanı: Hive (AES Şifreli)
- `HiveAesCipher` ile AES-256 şifreleme
- Şifreleme anahtarı: Android → `flutter_secure_storage` custom cipher storage (`AndroidOptions()`), iOS → Keychain
- Eski Android local datada plugin EncryptedSharedPreferences'tan custom cipher storage'a migration yapabilir; `Algorithm changed detected` logu tek başına crash göstergesi değildir, migration sonucuna bakılmalı
- 2 şifreli box: `scannedQrBox`, `generatedQrBox`
- **TypeId sırası sabit**: 0=ScannedQR, 1=GeneratedQR, 2=QRType — DEĞİŞTİRİLEMEZ

### 3. Servis Başlatma
```dart
// Kritik: paralel (startup %60 hızlandı)
await Future.wait([Firebase.initializeApp(...), DatabaseService.init()]);
await FirebaseAnalyticsService.initialize();
// Non-kritik: lazy
AdService.initialize().then((_) { ... }).ignore();
```

### 4. Logging: `developer.log()` + `kDebugMode` (avoid_print lint)

### 5. Analytics: Firebase Analytics — anonim, QR içeriği ASLA loglanmaz

### 6. QR Oluşturma
- `pretty_qr_code`: Modern QR (rounded corners, logo, gradient)
- `qr_flutter`: History/detail preview
- `RepaintBoundary` + `toImage()` ile PNG export
- 15 preset gradient (Instagram, TikTok, Facebook vb.)
- 8 preset logo (sosyal medya)

### 7. QR Tür Algılama: `QRHelper.detectQRType()` — URL, WiFi, vCard, mailto, sms, tel, geo, Maps

## Tasarım Desenleri
1. **Static Service Locator**: Tüm servisler static method
2. **Provider Pattern**: UI state yönetimi
3. **Builder Pattern**: QR form alanları switch-case
4. **Repository Pattern**: DatabaseService → Hive
5. **Observer**: ChangeNotifier → reaktif UI
6. **Deferred Loading**: addPostFrameCallback ile data loading

## Bileşen İlişkileri
```
main.dart → Firebase, DatabaseService, Analytics, AdService
  └── MyApp (MultiProvider) → ThemeProvider, LocaleProvider, QRProvider, SettingsProvider
        └── BetterFeedback → MaterialApp → MainScreen
              ├── ScannerScreen → MobileScanner, QRProvider, SettingsProvider
              ├── CreateScreen → PrettyQrView, QRProvider, AdService
              ├── HistoryScreen → QRProvider → QRDetailScreen
              └── SettingsScreen → LocaleProvider, FeedbackService
```

## Kritik Dosya Boyutları
| Dosya | Satır | Not |
|-------|-------|-----|
| `create_screen.dart` | ~1600 | ✅ Refactored — gradient tek kaynakta |
| `history_screen.dart` | 485 | Normal |
| `qr_detail_screen.dart` | 433 | Normal |
| `scanner_screen.dart` | 408 | Normal |

## Build Ortamı Kısıtlamaları (Windows)
| Kısıtlama | Detay |
|-----------|-------|
| Gradle versiyonu | 8.14.1 (8.12'de Windows file locking bug var) |
| Gradle daemon | Kapalı (`org.gradle.daemon=false`) — Windows Defender çakışması |
| CLI + Android Studio | Aynı anda build yapılamaz — daemon lock |
| GRADLE_USER_HOME | CLI build için `C:\g` kullanılmalı (Defender bypass) |
| Emülatör | Pixel 9 (API 37) — 4 GB RAM (`hw.ramSize=4096`) kullanılmalı; 2 GB LOW_MEMORY kill üretti |
| Native plugin metadata | Dependency update sonrası `flutter pub get` zorunlu; `jni`/`libdartjni.so` gibi native library'ler aksi halde APK'ye girmeyebilir |
| İlk build süresi | ~5-8 dk (Gradle cache indirme) |
| Sonraki build'ler | ~30s (cache mevcut) |

## Android Build Değerleri
- `android/app/build.gradle.kts` Flutter DSL değerlerini kullanır:
  - `compileSdk = flutter.compileSdkVersion`
  - `ndkVersion = flutter.ndkVersion`
  - `targetSdk = flutter.targetSdkVersion`
  - `versionCode = flutter.versionCode`
  - `versionName = flutter.versionName`
- Bu değerler hardcoded yapılmamalı; aksi halde Android tarafında APK `versionName=1.0`, `versionCode=1` gibi eski görünebilir.

## Dependency Update Pattern
- Direct dependencies major dahil güncellendikten sonra sıra şu olmalı:
  1. `flutter pub get`
  2. `dart analyze`
  3. `flutter build apk --debug --no-pub`
  4. APK native library kontrolü gerekiyorsa: `tar -tf build\app\outputs\flutter-apk\app-debug.apk | Select-String libdartjni`
  5. ADB install/run ve logcat doğrulaması
- `build_runner` latest'e kör yükseltilmemeli. Mevcut durumda `build_runner >=2.9.0` `build ^4.0.0` isterken `hive_generator ^2.0.1` `build ^2.0.0` istediği için `build_runner 2.4.13` current resolvable sürümdür.
