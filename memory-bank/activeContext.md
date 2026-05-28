# Active Context - QR Scanner & Generator

## Mevcut Durum
Uygulama **production-ready** durumda. Son değişiklikler Mayıs 2026'da yapıldı: versiyon senkronizasyonu (1.2.3), create_screen.dart gradient refactoring (4x tekrar → merkezi AppGradients), permission_dialog.dart lokalizasyonu, debugPrint → developer.log dönüşümü, Android build.gradle versiyon delegasyonu, Pixel 9 emülatör RAM düzeltmesi ve dependency major update doğrulaması. Uygulama Pixel 9 emülatörde 4 GB RAM ile başarıyla build, install ve run edildi.

## Son Yapılan Değişiklikler (Kronolojik)

### Mayıs 2026 — Bug Fix & Refactoring & Build Sorunları
1. **Versiyon Senkronizasyonu**: pubspec.yaml `1.0.0+1` → `1.2.3+4`, README badge ve metin güncellemeleri
2. **Gradient Refactoring**: 4x tekrarlanan 15 gradient tanımı `app_gradients.dart` merkezi dosyasına taşındı (~250 satır azaltma)
3. **permission_dialog.dart Lokalizasyonu**: 4 hardcoded Türkçe string → AppLocalizations (ARB key'leri zaten mevcuttu)
4. **debugPrint → developer.log**: create_screen.dart'taki son debugPrint kaldırıldı, `dart:developer` import edildi
5. **Import düzenleme**: create_screen.dart import'ları sıralandı (dart:, package:, relative)
6. **Gradle 8.12 → 8.14.1 yükseltme**: Windows `MergeInstrumentationAnalysisTransform` hatası nedeniyle
7. **gradle.properties güncelleme**: `org.gradle.daemon=false`, `org.gradle.parallel=false`, `org.gradle.caching=false` eklendi
8. **Emülatör başlatma**: Pixel 9 (API 37, Android 17) emülatörde uygulama çalıştırıldı

### 29 Mayıs 2026 — Emülatör LOW_MEMORY, Android Versiyon ve Dependency Update Fix
1. **Root cause doğrulandı**: Uygulamanın siyah ekran sonrası launcher'a dönmesi Dart/native exception değil, Android process exit-info'da `reason=3 (LOW_MEMORY)` olarak görüldü.
2. **Eski AVD ayarı**: `Pixel_9.avd/config.ini` içinde `hw.ramSize=2048`, `vm.heapSize=228` idi. Android 37 Google Play / 16KB image sistem servisleriyle birlikte bu RAM seviyesi yetersiz kaldı.
3. **Yeni AVD ayarı**: `hw.ramSize=4096`, `vm.heapSize=512` yapıldı. Cihaz içinde `MemTotal: 4008504 kB` doğrulandı.
4. **Run doğrulaması**: RAM artırıldıktan sonra uygulama 15 saniye sonra foreground'da kaldı; `pidof com.aozka.qrscannerapp` canlı PID döndürdü ve `topResumedActivity` uygulamanın `MainActivity` kaydını gösterdi.
5. **Android version fix**: `android/app/build.gradle.kts` hardcoded `versionCode=1`, `versionName="1.0"`, `compileSdk=36`, `targetSdk=36`, `ndkVersion=28.2...` değerlerinden çıkarıldı; Flutter DSL değerleri (`flutter.versionCode`, `flutter.versionName`, `flutter.compileSdkVersion`, `flutter.targetSdkVersion`, `flutter.ndkVersion`) kullanılmaya başlandı.
6. **Yeni APK doğrulaması**: Debug APK build edildi, ADB ile kuruldu; `dumpsys package` artık `versionName=1.2.3`, `versionCode=4`, `targetSdk=36` gösteriyor.
7. **Build takılma notu**: Önceki uzun beklemelerde eski abortlardan kalmış yüksek CPU'lu `cmd.exe` süreçleri vardı. `27636`, `38212`, `38772` durdurulduktan sonra build log takipli çalıştırıldı ve `build/app/outputs/flutter-apk/app-debug.apk` başarıyla üretildi.
8. **Dependency major update**: `dart pub upgrade --major-versions` ile güncellenebilir direct dependency constraint'leri yükseltildi: `google_fonts ^8.1.0`, `share_plus ^13.1.0`, `google_mobile_ads ^8.0.0`, `flutter_secure_storage ^10.3.1`, `device_info_plus ^13.1.0`, `package_info_plus ^10.1.0`.
9. **Outdated doğrulaması**: `dart pub outdated` sonucu direct dependency'lerin tamamı güncel. Kalan `build_runner 2.4.13 -> 2.15.0` güncellemesi çözülemiyor; sebep: `build_runner >=2.9.0` `build ^4.0.0` isterken `hive_generator ^2.0.1` `build ^2.0.0` istiyor. Transitive paketlerde görünen yeni sürümler de current constraint graph içinde resolvable değil.
10. **Secure storage migration**: `flutter_secure_storage 10.3.1` ile deprecated `encryptedSharedPreferences: true` parametresi kaldırıldı ve `AndroidOptions()` kullanıldı. Eski emülatör datasında plugin migration sırasında `Algorithm changed detected` / `Key mismatch` logları görülebilir; log devamında migration tamamlanıyor ve crash üretmiyor.
11. **JNI packaging fix**: Major update sonrası ilk build'de `path_provider_android 2.3.1` üzerinden gelen `jni` native library (`libdartjni.so`) APK'ye girmediği için app splash'te kalmıştı. `flutter pub get` ile Flutter plugin metadata yenilendi, yeniden build edilen APK içinde `lib/x86_64/libdartjni.so` doğrulandı ve logcat `Load ... libdartjni.so ... ok` gösterdi.
12. **Analyze doğrulaması**: Sandbox içinde analyzer `CreateFile failed 5 / Erişim engellendi` verdiği için `dart analyze` escalated çalıştırıldı; sonuç `No issues found!`.
13. **Final run doğrulaması**: Güncellenmiş lockfile ile `flutter build apk --debug --no-pub` başarılı oldu; APK ADB ile kuruldu, uygulama foreground'da kaldı, `mCurrentFocus` MainActivity gösterdi, `Displayed/Fully drawn` logları geldi ve kamera tarayıcı ekranı açıldı.

### Mart 2026 — Paket & Dil Güncellemesi
1. **Paket Güncellemeleri**: Tüm bağımlılıklar güncel versiyonlara yükseltildi
2. **Dil Desteği**: 10 dilden 17 dile genişletildi (Hi, Pt, Ko, Ru, Pl, Uk, Nl eklendi + El geri eklendi)
3. **Provider Güvenlik**: `QRProvider` ve `SettingsProvider`'a `_disposed` + `_notifySafe()` pattern eklendi — 4 provider'da tutarlı
4. **SECURITY.md**: Tarih ve durum güncellendi
5. **Hive DB Şifreleme**: AES-256 şifreleme + flutter_secure_storage ile anahtar yönetimi

### Ekim 2025 — v1.2.3 (CHANGELOG son sürüm)
- 31+ bug fix, 25+ print() → developer.log() dönüşümü
- BuildContext async gap düzeltmesi
- Bug reporting sistemi eklendi
- One-Time QR özelliği kaldırıldı
- Flutter analyze 0 issue

## Aktif Kararlar ve Dikkat Noktaları

### ✅ Tamamlanan Düzeltmeler
- ~~Versiyon tutarsızlığı~~ → Tüm dosyalar `1.2.3` olarak senkronize edildi
- ~~create_screen.dart gradient 4x tekrar~~ → Merkezi `app_gradients.dart` dosyası oluşturuldu
- ~~permission_dialog.dart hardcoded Türkçe~~ → `AppLocalizations` ile lokalize edildi
- ~~debugPrint kullanımı~~ → `developer.log()` ile değiştirildi
- ~~Gradle 8.12 Windows file locking~~ → Gradle 8.14.1 + no-daemon ayarları ile çözüldü
- ~~Android APK versiyonunun 1.0 kalması~~ → `build.gradle.kts` Flutter DSL versiyon değerlerine bağlandı
- ~~Pixel 9 emülatörde siyah ekran/launcher'a dönüş~~ → AVD RAM 2 GB'dan 4 GB'a çıkarıldı; LOW_MEMORY ortadan kalktı
- ~~Güncel direct dependency migration~~ → Güncellenebilir direct paketler major dahil yükseltildi; `dart pub outdated` direct dependencies için temiz
- ~~`libdartjni.so` splash'te kalma sorunu~~ → `flutter pub get` sonrası plugin metadata yenilendi ve debug APK içinde x86_64 `libdartjni.so` paketlendi

### ⚠️ Windows Gradle/Build Ortam Sorunları (Detaylı)
Bu session'da ciddi build sorunları yaşandı ve çözüldü:

**Problem**: `MergeInstrumentationAnalysisTransform` hatası — Gradle transform cache'inde dosya rename işlemleri başarısız oluyor.
```
Could not move temporary workspace (...-uuid) to immutable location (...)
```

**Root Cause**: Windows Defender real-time taraması `.gradle/caches/` dizinindeki dosyaları kilitleliyor. Gradle transform'lar sırasında rename işlemi bloke ediliyor.

**Denenen Çözümler (Kronolojik)**:
1. ❌ `kotlin-dsl/scripts` klasörünü silmek — yeterli değil
2. ❌ Tüm `.gradle/caches/8.12` silmek — yeterli değil
3. ❌ Tüm `.gradle/caches` + `.gradle/daemon` silmek — yeterli değil
4. ❌ Gradle 8.12 → 8.14.1 yükseltme — tek başına yeterli değil
5. ❌ Windows Defender exclusion ekleme (UAC prompt onaylanmadığı için çalışmadı)
6. ❌ `org.gradle.daemon=false` + `parallel=false` + `caching=false` — tek başına yeterli değil
7. ✅ **`GRADLE_USER_HOME=C:\g`** — farklı dizine taşımak sorunu çözdü
8. ✅ **Android Studio kapatılması** — Studio'nun kendi Gradle daemon'u dosyaları kilitliyordu

**Çalışan Çözüm (İleride Referans)**:
```powershell
# 1. Android Studio'yu kapat
Stop-Process -Name "studio64" -Force
# 2. Java/Gradle daemon'ları durdur
Stop-Process -Name "java" -Force
# 3. GRADLE_USER_HOME'u farklı dizine taşı
$env:GRADLE_USER_HOME = "C:\g"
# 4. Temiz build
flutter clean; flutter run -d emulator-5554
```

**Kalıcı Çözüm Seçenekleri**:
- Windows Defender → Ayarlar → Virus Koruması → `.gradle` dizinini exclude et
- Veya `GRADLE_USER_HOME` env variable'ını kalıcı olarak `C:\g` yapma
- Veya Android Studio'dan build yap (Studio kendi daemon'unu yönetiyor)

### ⚠️ Emülatör Bağlantı Sorunları
- Emülatör uzun build sırasında timeout olup kapanabiliyor
- `flutter emulators --launch Pixel_9` bazen başarısız oluyor
- **Çalışan yol**: SDK emülatörünü doğrudan başlat:
  ```powershell
  Start-Process "C:\Users\aozka\AppData\Local\Android\Sdk\emulator\emulator.exe" -ArgumentList "-avd","Pixel_9","-no-snapshot","-gpu","auto"
  Start-Sleep -Seconds 60  # Boot bekle
  flutter run -d emulator-5554 --use-application-binary build\app\outputs\flutter-apk\app-debug.apk
  ```
- Debug bağlantısı `Lost connection to device` ile kopabiliyor — uygulama çalışmaya devam eder
- Fiziksel cihaz bağlamak en stabil yöntem
- **LOW_MEMORY / launcher'a dönüş**: Pixel 9 Android 37 Play Store image 2 GB RAM ile uygulamayı foreground'dayken öldürebilir. `dumpsys activity exit-info com.aozka.qrscannerapp` içinde `reason=LOW_MEMORY` görünür. Çözüm: `C:\Users\aozka\.android\avd\Pixel_9.avd\config.ini` dosyasında `hw.ramSize=4096`, `vm.heapSize=512` kullan.
- **Analyzer sandbox notu**: `dart analyze` sandbox içinde `CreateFile failed 5 / Erişim engellendi` verebilir; analyzer server process'i için escalated çalıştırmak gerekir.
- **JNI/native asset notu**: `path_provider_android 2.3.x` `jni`/`jni_flutter` metadata kullanıyor. Major dependency update sonrası splash'te kalma veya `Failed to load dynamic library ... libdartjni.so` görülürse önce `flutter pub get`, sonra APK içinde `tar -tf build\app\outputs\flutter-apk\app-debug.apk | Select-String libdartjni` kontrol edilmeli.

## Önemli Patterns ve Kurallar

### Kod Yazarken Dikkat Edilecekler
1. **print() kullanma** → `developer.log()` kullan, `kDebugMode` kontrolü ekle
2. **Provider'da dispose kontrolü** → `_notifySafe()` helper kullan
3. **Async BuildContext** → await sonrası `if (!mounted) return;` ekle
4. **Hive TypeId** → Mevcut TypeId'leri DEĞİŞTİRME (0, 1, 2 sabit)
5. **Relative imports** → `prefer_relative_imports` lint aktif
6. **Const constructors** → `prefer_const_constructors` lint aktif
7. **Gradient ekleme** → `app_gradients.dart`'a ekle, `create_screen.dart`'a EKLEME

### Servis Ekleme Kuralı
- Tüm servisler static class olarak yazılır (singleton pattern)
- Kritik servisler `main.dart`'ta `Future.wait` ile paralel başlatılır
- Non-kritik servisler `.ignore()` ile lazy başlatılır

### Build Kuralları (Windows)
- **Android Studio açıkken CLI'dan `flutter run` yapma** — Gradle daemon çakışması
- **Build öncesi** Android Studio'yu kapat veya `GRADLE_USER_HOME` farklı dizine ayarla
- **İlk build uzun sürer** (~5-8 dk) — Gradle cache sıfırdan indiriliyor
- **Sonraki build'ler hızlı** (~30s) — cache mevcut

## Sonraki Adımlar (Roadmap)

### Kısa Vadeli (Öncelikli)
- [x] Versiyon numarası senkronizasyonu
- [x] `create_screen.dart` refactoring (gradient tanımlarını ayır)
- [x] `permission_dialog.dart` lokalizasyonu
- [x] Direct dependency major update ve Android runtime doğrulaması
- [ ] Save QR to gallery (paket uyumluluk araştırması)
- [ ] Windows Defender `.gradle` exclusion'ı kalıcı olarak ayarla

### Orta Vadeli (v1.3.0)
- [ ] QR kod şablonları
- [ ] Favori QR kodlar
- [ ] Batch QR oluşturma
- [ ] QR kod düzenleme
- [ ] Tarama geçmişi filtreleme

### Uzun Vadeli (v2.0.0)
- [ ] QR kod şifreleme/şifre çözme
- [ ] URL güvenlik kontrolü
- [ ] QR kod istatistikleri
- [ ] Widget desteği (Home screen)
- [ ] Cloud backup (opsiyonel, gizlilik öncelikli)
- [ ] Tema paketleri

## Öğrenimler ve İçgörüler
- `print()` → `developer.log()` geçişi production güvenliği için kritik
- Paralel servis başlatma ile %60 daha hızlı uygulama açılışı sağlandı
- One-Time QR özelliği karmaşıklık eklediği için kaldırıldı — "basitlik > karmaşıklık"
- Network monitoring servisi gereksiz bulunup kaldırıldı — uygulama %100 offline çalışabiliyor
- Gradient tanımlarının 4x tekrarı merkezi `AppGradients` sınıfına taşınarak çözüldü — `GradientPreset` modeli ile DRY prensibi uygulandı
- `pretty_qr_code`'da eye ve data module ayrı customize edilemiyor — `roundFactor` ile yaklaşık çözüm
- ARB lokalizasyon anahtarları eklemeden önce kontrol et — çoğu zaten mevcut olabilir
- **Gradle Windows sorunu**: Root cause Windows Defender file locking + Android Studio daemon çakışması. `GRADLE_USER_HOME` değiştirmek en güvenilir çözüm
- **Emülatör instabilite**: API 37 emülatör debug bağlantısı kopabiliyor — fiziksel cihaz tercih edilmeli
- **CLI vs Android Studio build**: Aynı anda ikisini kullanma — daemon çakışması yaratır
- **Dependency update sonrası mutlaka Flutter metadata yenile**: `dart pub upgrade --major-versions` sonrasında `flutter pub get` çalıştırılmalı; aksi halde native plugin metadata eski kalıp debug APK içinde yeni native library'ler eksik paketlenebilir.
