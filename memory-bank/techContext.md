# Tech Context - QR Scanner & Generator

## Teknoloji Stack

### Framework
- **Flutter** 3.38+ (Dart SDK ^3.9.2)
- **Material 3** (useMaterial3: true)
- Hedef platformlar: Android & iOS (web/linux/macos/windows klasörleri mevcut ama aktif değil)

### Core Bağımlılıklar

| Kategori | Paket | Versiyon | Amaç |
|----------|-------|----------|------|
| **QR Tarama** | `mobile_scanner` | ^7.1.4 | Kamera ile QR/barkod tarama |
| **QR Oluşturma** | `qr_flutter` | ^4.1.0 | Standart QR (history/detail) |
| **QR Oluşturma** | `pretty_qr_code` | ^3.5.0 | Modern QR (rounded, logo, gradient) |
| **Veritabanı** | `hive` + `hive_flutter` | ^2.2.3 / ^1.1.0 | Şifreli yerel NoSQL DB |
| **Güvenli Depolama** | `flutter_secure_storage` | ^10.3.1 | Hive şifreleme anahtarı |
| **State** | `provider` | ^6.1.2 | State management |
| **Ayarlar** | `shared_preferences` | ^2.5.4 | Tema/dil tercihleri |
| **Reklamlar** | `google_mobile_ads` | ^8.0.0 | AdMob interstitial |
| **Firebase** | `firebase_core` | ^4.3.0 | Firebase init |
| **Firebase** | `firebase_analytics` | ^12.1.0 | Anonim analytics |
| **Lokalizasyon** | `intl` | ^0.20.2 | 17 dil desteği |
| **Geri Bildirim** | `feedback` | ^3.1.0 | Screenshot + feedback UI |
| **Cihaz Bilgisi** | `device_info_plus` | ^13.1.0 | Bug report cihaz bilgisi |
| **Uygulama Bilgisi** | `package_info_plus` | ^10.1.0 | Versiyon bilgisi |
| **Paylaşım** | `share_plus` | ^13.1.0 | QR kod paylaşma |
| **URL** | `url_launcher` | ^6.3.1 | Harici URL açma |
| **İzinler** | `permission_handler` | ^12.0.1 | Kamera izni |
| **Titreşim** | `vibration` | ^3.1.5 | Taramada haptic feedback |
| **UUID** | `uuid` | ^4.5.2 | Benzersiz QR ID oluşturma |
| **Dosya** | `path_provider` | ^2.1.5 | Geçici dosya yolu |
| **Font** | `google_fonts` | ^8.1.0 | Inter tipografi |
| **UI** | `cupertino_icons` | ^1.0.8 | iOS tarzı ikonlar |

### Dev Bağımlılıklar
- `flutter_lints` ^6.0.0 — Lint kuralları
- `hive_generator` ^2.0.1 + `build_runner` ^2.4.13 — Hive kod üretimi
- `flutter_launcher_icons` ^0.14.2 — Uygulama ikonu
- `flutter_native_splash` ^2.4.7 — Splash screen

## Geliştirme Ortamı

### Kurulum
```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter gen-l10n
flutter run
```

### Production Build
```bash
flutter clean && flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter gen-l10n
flutter analyze  # 0 issue olmalı
flutter build apk --release           # Android APK (~35MB)
flutter build appbundle --release     # Android App Bundle (Google Play)
flutter build ios --release           # iOS (Xcode'da archive)
```

### Environment Variables
- `.env` dosyası ile AdMob ID'leri yönetilir (`.env.example` mevcut)
- `.env` ASLA commit edilmez (`.gitignore`'da)
- Firebase config: `lib/firebase_options.dart` (FlutterFire CLI)
- Firebase API anahtarları `firebase_options.dart` içinde (Google Cloud Console'da kısıtlanmalı)

### CI/CD: Codemagic
- `codemagic.yaml` ile 3 workflow: `android-workflow`, `ios-workflow`, `all-platforms-workflow`
- Android: APK + AAB → Google Play (internal track, draft)
- iOS: IPA → TestFlight (Beta Testers grubu)
- Trigger: `main` ve `release/*` branch push, `v*` tag'leri
- Build instance: `mac_mini_m1`
- Android signing: `qr_scanner_dist_cert` keystore
- iOS signing: App Store Connect integration (`app_store_key`)

### Kod Üretimi
```bash
# Hive adapter'ları (model değişikliklerinden sonra)
flutter pub run build_runner build --delete-conflicting-outputs

# Lokalizasyon (ARB dosyası değişikliklerinden sonra)
flutter gen-l10n
```

### Lint Kuralları (analysis_options.yaml)
- `prefer_const_constructors`
- `prefer_const_literals_to_create_immutables`
- `prefer_final_fields`
- `use_key_in_widget_constructors`
- `prefer_relative_imports`
- `avoid_print` ✅ (production güvenliği)

## Android Build Ortamı (Windows)

### Gradle Konfigürasyonu
- **Gradle versiyonu**: 8.14.1 (`android/gradle/wrapper/gradle-wrapper.properties`)
- **gradle.properties ayarları** (Mayıs 2026'da güncellendi):
  ```properties
  org.gradle.jvmargs=-Xmx8G -XX:MaxMetaspaceSize=4G -XX:ReservedCodeCacheSize=512m -XX:+HeapDumpOnOutOfMemoryError
  android.useAndroidX=true
  android.enableJetifier=false
  org.gradle.daemon=false
  org.gradle.parallel=false
  org.gradle.caching=false
  ```
- **Not**: daemon/parallel/caching kapatıldı çünkü Windows'ta dosya kilitleme sorunu var

### ⚠️ Gradle Windows Dosya Kilitleme Sorunu (Kritik)

**Hata**: `MergeInstrumentationAnalysisTransform` — `Could not move temporary workspace to immutable location`

**Root Cause**: Windows Defender real-time taraması + Android Studio Gradle daemon'u `.gradle/caches/` dizinindeki dosyaları kilitleliyor.

**Çözüm Adımları** (sırasıyla):
```powershell
# 1. Android Studio'yu kapat (ZORUNLU — daemon çakışması önler)
Stop-Process -Name "studio64" -Force -ErrorAction SilentlyContinue

# 2. Java/Gradle daemon'ları durdur
Stop-Process -Name "java" -Force -ErrorAction SilentlyContinue

# 3. Bozuk cache'i temizle
Remove-Item -Recurse -Force "$env:USERPROFILE\.gradle\caches" -ErrorAction SilentlyContinue

# 4. GRADLE_USER_HOME'u farklı dizine taşı (Defender bypass)
$env:GRADLE_USER_HOME = "C:\g"

# 5. Temiz build
flutter clean; flutter run -d emulator-5554
```

**Kalıcı Çözüm** (birini seç):
1. Windows Defender → Virus Koruması → Hariç Tutmalar → `C:\Users\<user>\.gradle` dizinini ekle
2. Sistem env variable: `GRADLE_USER_HOME=C:\g` (Sistem Ayarları → Ortam Değişkenleri)
3. Android Studio'dan build yap (Studio kendi daemon'unu yönetiyor, çakışma yok)

**Denenen ama çalışmayan çözümler**:
- Sadece cache silmek (yeterli değil)
- Sadece Gradle versiyonu yükseltmek (yeterli değil)
- Sadece daemon=false (yeterli değil)
- Tüm kombinasyonlar ancak GRADLE_USER_HOME değişmeden (yeterli değil)

### Emülatör Yönetimi

**Mevcut AVD'ler**: `Pixel_9` (API 37), `Pixel_9a` (API 37)

**Pixel_9 güncel bellek ayarı (29 Mayıs 2026)**:
```ini
hw.ramSize=4096
vm.heapSize=512
```
- Önceki `hw.ramSize=2048` ayarında uygulama açıldıktan kısa süre sonra launcher'a dönüyordu.
- `dumpsys activity exit-info com.aozka.qrscannerapp` root cause'u `reason=3 (LOW_MEMORY)` olarak doğruladı.
- RAM artırıldıktan sonra cihaz içinde `MemTotal: 4008504 kB` görüldü ve uygulama foreground'da stabil kaldı.

**Emülatör başlatma** (CLI):
```powershell
# Yol: C:\Users\aozka\AppData\Local\Android\Sdk\emulator\emulator.exe
Start-Process "C:\Users\aozka\AppData\Local\Android\Sdk\emulator\emulator.exe" `
  -ArgumentList "-avd","Pixel_9","-no-snapshot","-gpu","auto"
Start-Sleep -Seconds 60  # Boot bekleme süresi
flutter devices  # emulator-5554 görünmeli
```

**Bilinen emülatör sorunları**:
- `flutter emulators --launch` bazen başarısız — doğrudan SDK emülatörü kullan
- Uzun build sırasında emülatör timeout olup kapanabiliyor → önce build, sonra install:
  ```powershell
  flutter build apk --debug  # Önce APK'yı derle
  # ... emülatörü başlat ...
  flutter run -d emulator-5554 --use-application-binary build\app\outputs\flutter-apk\app-debug.apk
  ```
- Debug bağlantısı `Lost connection to device` ile kopabilir — uygulama çalışmaya devam eder
- **adb** PATH'te yok → Flutter komutları üzerinden erişim sağlanır
- Android 37 Google Play / 16KB image düşük RAM'de sistem servislerini de öldürebiliyor; launcher'a dönüş görülürse önce AVD RAM ve `exit-info` kontrol edilmeli.

**En stabil build akışı**:
1. Android Studio'yu kapat
2. Emülatörü SDK'dan başlat (60sn boot bekle)
3. `$env:GRADLE_USER_HOME = "C:\g"`
4. `flutter run -d emulator-5554`
5. Veya: Android Studio aç → Run butonuyla çalıştır (en stabil)

### Build/Run Debug Notları (29 Mayıs 2026)
- `flutter build apk --debug` uzun süre sessiz kalırsa doğrudan bekleme; çıktıyı log dosyasına yönlendir ve `build\app\outputs\flutter-apk\app-debug.apk` timestamp'ini takip et.
- Abortlardan kalmış `cmd.exe` süreçleri Gradle/Flutter komutlarını kilitleyebilir veya CPU tüketebilir. Örnek temizlenen stale PID'ler: `27636`, `38212`, `38772`.
- Build başarıyla üretildiğinde kurulum doğrulaması:
  ```powershell
  adb install -r build\app\outputs\flutter-apk\app-debug.apk
  adb shell dumpsys package com.aozka.qrscannerapp | Select-String 'versionCode|versionName|targetSdk'
  ```
- Son doğrulamada Android package bilgisi `versionCode=4`, `versionName=1.2.3`, `targetSdk=36` oldu.
- `dart analyze` sandbox içinde `CreateFile failed 5 / Erişim engellendi` ile başarısız olabilir; `dartaotruntime.exe` analyzer server başlatılamadığı için escalated çalıştırmak gerekir.
- Major dependency update sonrası `path_provider_android 2.3.x` `jni`/`jni_flutter` metadata getirir. Splash'te kalma ve `Failed to load dynamic library ... libdartjni.so` görülürse APK içinde `lib/x86_64/libdartjni.so` var mı kontrol et. Son doğrulamada `flutter pub get` sonrası `lib/x86_64/libdartjni.so` APK'ye girdi ve logcat `Load ... libdartjni.so ... ok` gösterdi.
- Son doğrulama komutları:
  ```powershell
  dart pub upgrade
  dart analyze
  flutter build apk --debug --no-pub
  adb install -r build\app\outputs\flutter-apk\app-debug.apk
  adb shell am start -W -n com.aozka.qrscannerapp/.MainActivity
  adb shell dumpsys activity exit-info com.aozka.qrscannerapp
  ```

### Dependency Güncelleme Durumu (29 Mayıs 2026)
- `dart pub upgrade --major-versions` çalıştırıldı ve güncellenebilir direct dependency constraint'leri major dahil yükseltildi.
- Direct dependency tarafı `dart pub outdated` sonucunda tamamen güncel: `direct dependencies: all up-to-date`.
- Yükseltilen direct constraint'ler: `google_fonts ^8.1.0`, `share_plus ^13.1.0`, `google_mobile_ads ^8.0.0`, `flutter_secure_storage ^10.3.1`, `device_info_plus ^13.1.0`, `package_info_plus ^10.1.0`.
- Öne çıkan lockfile güncellemeleri: `firebase_core 4.9.0`, `firebase_analytics 12.4.1`, `mobile_scanner 7.2.0`, `pretty_qr_code 3.6.0`, `path_provider_android 2.3.1`, `jni 1.0.0`, `jni_flutter 1.0.1`, `webview_flutter_android 4.12.0`.
- `build_runner 2.15.0` latest görünüyor ancak resolvable değil. Dry-run çıktısı: `build_runner >=2.9.0` `build ^4.0.0` ister; `hive_generator >=1.0.1` `build ^2.0.0` ister. Bu nedenle mevcut Hive generator graph'ında `build_runner` `2.4.13` kalmalı.
- `build_resolvers` ve `build_runner_core` discontinued olarak listeleniyor; bunlar current dev dependency graph'ının transitive parçaları ve doğrudan repo constraint'i değil.
- `flutter_secure_storage 10.3.1` için `DatabaseService` artık `AndroidOptions()` kullanıyor. Eski local Android datasında plugin migration logları görülebilir (`Algorithm changed detected`, `Key mismatch`), ancak son emülatör doğrulamasında migration tamamlandı ve crash olmadı.

## Teknik Kısıtlamalar
1. **Hive TypeId sabit**: 0=ScannedQR, 1=GeneratedQR, 2=QRType — değiştirilemez
2. **AdMob iOS**: iOS app ID'si henüz production'da test edilmedi
3. **Splash screen rengi**: `#101922` (AppColors.backgroundDark)
4. **Android package**: `com.aozka.qrscannerapp`
5. **iOS bundle**: `com.qrscanner.qrScannerApp`
6. **Firebase API key kısıtlamaları**: Google Cloud Console'da yapılandırılmalı (SECURITY_NOTES.md)
7. **pretty_qr_code**: Eye ve data module ayrı customize edilemez — tek `PrettyQrSmoothSymbol` ile birleşik
8. **Windows Gradle**: CLI ve Android Studio aynı anda build yapamaz — daemon çakışması
9. **Android versiyon kaynağı**: `android/app/build.gradle.kts` Flutter DSL değerlerini kullanmalı (`flutter.versionCode`, `flutter.versionName`); hardcoded `1.0/1` tekrar eklenmemeli.
10. **Native plugin metadata**: Dependency upgrade sonrası `flutter pub get` çalıştırmadan Android debug APK build edilmemeli; özellikle `jni` gibi native asset taşıyan pluginlerde APK eksik library ile üretilebilir.

## Test Yapısı
- `test/widget_test.dart` — MainScreen bottom nav 4 item testi
- `integration_test/app_test.dart` — Uygulama hatasız başlama testi
- Test coverage düşük — genişletilmeli
- **Emülatörde test**: Pixel 9 (API 37, Android 17) üzerinde başarıyla çalıştırıldı (Mayıs 2026)

## Assets
- `assets/images/` — `.gitkeep` (boş, placeholder)
- `assets/logos/` — App icon, splash logo, 8 sosyal medya logosu
  - `app_icon.png` (137KB), `splash_logo.png` (37KB)
  - Instagram, Facebook, Twitter, LinkedIn, YouTube, TikTok, WhatsApp, Telegram PNG'leri

## Güvenlik Notları
- Firebase API anahtarları `firebase_options.dart` içinde (public repo'da görünür)
- Google Cloud Console'da platform kısıtlamaları uygulanmalı
- Hive DB şifreleme anahtarı `flutter_secure_storage` ile korunur
- `.env`, `*.jks`, `*.keystore` gitignore'da
