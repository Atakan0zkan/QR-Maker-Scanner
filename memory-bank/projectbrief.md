# Project Brief - QR Scanner & Generator

## Proje Adı
QR Scanner & Generator (QR-Maker-Scanner)

## Repository
- **GitHub**: [Atakan0zkan/QR-Maker-Scanner](https://github.com/Atakan0zkan/QR-Maker-Scanner)
- **Lisans**: MIT License (Copyright 2025 Atakan Özkan)

## Geliştirici
**Atakan Özkan** - [@Atakan0zkan](https://github.com/Atakan0zkan)
- **Email**: atakanozkan2001@gmail.com
- **Bug Report Email**: reportbugstomebro@gmail.com

## Proje Özeti
Hızlı, güvenilir ve kullanıcı dostu QR kod tarayıcı ve oluşturucu mobil uygulama. Flutter ile geliştirilmiş, cross-platform (Android & iOS) destekli, production-ready bir uygulama. Gizlilik odaklı, offline-first mimari ile tüm veriler cihazda şifreli olarak saklanır.

## Temel Gereksinimler

### Fonksiyonel Gereksinimler
1. **QR Kod Tarama** - Kamera ile anlık QR/barkod tarama, toplu tarama modu, flaş ve titreşim kontrolü
2. **QR Kod Oluşturma** - 9 farklı türde QR kod oluşturma (URL, WiFi, Kişi, Email, SMS, Telefon, Konum, Sosyal Medya, Metin)
3. **QR Özelleştirme** - Renk (10 renk), şekil (square/circle/rounded), gradient (15 preset), logo (8 sosyal medya logosu)
4. **Geçmiş** - Taranan ve oluşturulan kodların otomatik kayıt, çoklu seçim ile silme, QR/barkod filtreleme
5. **Paylaşım** - QR kodlarını PNG resim veya metin olarak paylaşma (WhatsApp, Telegram, Email vb.)
6. **Çoklu Dil** - 17 dil desteği (EN, TR, ES, DE, FR, IT, EL, AR, ZH, JA, HI, PT, KO, RU, PL, UK, NL)
7. **Tema** - Koyu/Açık tema desteği (default: Koyu)
8. **Bug Reporting** - Uygulama içi hata bildirimi (screenshot + cihaz bilgisi + email)

### Teknik Gereksinimler
- Production-ready güvenlik (AES şifreli Hive DB, env vars)
- Firebase Analytics entegrasyonu (anonim kullanım istatistikleri)
- AdMob reklam entegrasyonu (interstitial ads)
- Codemagic CI/CD pipeline (Android + iOS)
- GDPR/COPPA uyumlu veri politikası
- Production-safe logging (developer.log, avoid_print lint)

## Kapsam Dışı (Henüz Planlanmamış)
- Cloud backup
- QR kod şifreleme/şifre çözme
- Batch QR oluşturma
- QR kod şablonları
- Widget desteği (Home screen)
- Favori QR kodlar
- QR kod düzenleme
- Tarama geçmişi filtreleme

## Platform Hedefleri
- **Android**: Google Play Store
  - Package: `com.aozka.qrscannerapp`
  - Min SDK: Flutter 3.38+ gerektiriyor
- **iOS**: App Store
  - Bundle ID: `com.qrscanner.qrScannerApp`
  - App ID: `6755507752`

## Versiyon Durumu ✅
- **Güncel Versiyon**: `1.2.3+4`
- `pubspec.yaml`: `1.2.3+4` ✅
- `CHANGELOG.md`: `1.2.3` ✅
- `README.md`: `1.2.3` ✅
- Tüm dosyalar Mayıs 2026'da senkronize edildi
- Android package doğrulaması: `versionName=1.2.3`, `versionCode=4`, `targetSdk=36` ✅

## Build Ortamı (Windows)
- **Gradle**: 8.14.1 (8.12'den yükseltildi — Windows file locking bug)
- **Emülatör**: Pixel 9 (API 37, Android 17) — `emulator-5554`
- **Pixel_9 RAM**: 4096 MB (`hw.ramSize=4096`, `vm.heapSize=512`) — 2 GB ayar LOW_MEMORY kill üretiyordu
- **Emülatör yolu**: `C:\Users\aozka\AppData\Local\Android\Sdk\emulator\emulator.exe`
- **GRADLE_USER_HOME**: CLI build için `C:\g` kullan (Windows Defender bypass)
- **Kural**: Android Studio ve CLI aynı anda build YAPAMAZ (daemon çakışması)
- **Flutter analyze**: 0 issue ✅
- **Dependency durumu**: `dart pub outdated` direct dependencies için temiz; `build_runner` latest sadece `hive_generator`/`build` major conflict nedeniyle bekliyor
- **Son başarılı build**: 29 Mayıs 2026 — Debug APK build/install edildi; Android package `versionName=1.2.3`, `versionCode=4`; APK içinde `lib/x86_64/libdartjni.so` doğrulandı; Pixel 9 4 GB RAM emülatörde uygulama scanner ekranında stabil çalıştı
