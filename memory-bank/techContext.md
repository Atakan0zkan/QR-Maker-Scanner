# Tech Context - QR Scanner & Generator

## Teknoloji Stack

### Framework
- **Flutter** 3.38+ (Dart SDK ^3.9.2)
- Hedef platformlar: Android & iOS (web/linux/macos/windows klasörleri mevcut ama aktif değil)

### Core Bağımlılıklar

| Kategori | Paket | Versiyon | Amaç |
|----------|-------|----------|------|
| **QR Tarama** | `mobile_scanner` | ^7.1.4 | Kamera ile QR/barkod tarama |
| **QR Oluşturma** | `qr_flutter` | ^4.1.0 | Standart QR oluşturma |
| **QR Oluşturma** | `pretty_qr_code` | ^3.5.0 | Yuvarlak köşeli modern QR |
| **Veritabanı** | `hive` + `hive_flutter` | ^2.2.3 | Şifreli yerel NoSQL DB |
| **Güvenli Depolama** | `flutter_secure_storage` | ^9.2.4 | Şifreleme anahtarı saklama |
| **State** | `provider` | ^6.1.2 | State management |
| **Ayarlar** | `shared_preferences` | ^2.5.4 | Tema/dil tercihleri |
| **Reklamlar** | `google_mobile_ads` | ^6.0.0 | AdMob entegrasyonu |
| **Firebase** | `firebase_core` + `firebase_analytics` | ^4.3.0 / ^12.1.0 | Anonim analytics |
| **Lokalizasyon** | `intl` | ^0.20.2 | 16 dil desteği |
| **Geri Bildirim** | `feedback` | ^3.1.0 | Uygulama içi bug report |
| **Cihaz Bilgisi** | `device_info_plus` | ^12.3.0 | Bug report cihaz bilgisi |
| **Uygulama Bilgisi** | `package_info_plus` | ^9.0.0 | Versiyon bilgisi |
| **Paylaşım** | `share_plus` | ^12.0.0 | QR kod paylaşma |
| **URL** | `url_launcher` | ^6.3.1 | Harici URL açma |
| **İzinler** | `permission_handler` | ^12.0.1 | Kamera izni |
| **Titreşim** | `vibration` | ^3.1.5 | Taramada haptic feedback |
| **UUID** | `uuid` | ^4.5.2 | Benzersiz QR ID oluşturma |
| **Dosya** | `path_provider` | ^2.1.5 | Geçici dosya yolu |
| **Font** | `google_fonts` | ^6.3.3 | Modern tipografi |

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

### Environment Variables
- `.env` dosyası ile AdMob ID'leri yönetilir (`.env.example` mevcut)
- `.env` ASLA commit edilmez (`.gitignore`'da)
- Firebase config: `lib/firebase_options.dart` (FlutterFire CLI ile oluşturulur)

### CI/CD
- **Codemagic** ile otomatik build pipeline (`codemagic.yaml`)
  - Android: APK + AAB → Google Play (internal track, draft)
  - iOS: IPA → TestFlight (Beta Testers grubu)
  - Trigger: `main` ve `release/*` branch'lerine push, `v*` tag'leri
  - Build instance: `mac_mini_m1`

### Kod Üretimi
```bash
# Hive adapter'ları
flutter pub run build_runner build --delete-conflicting-outputs

# Lokalizasyon
flutter gen-l10n
```

### Lint Kuralları (analysis_options.yaml)
- `prefer_const_constructors`
- `prefer_const_literals_to_create_immutables`
- `prefer_final_fields`
- `use_key_in_widget_constructors`
- `prefer_relative_imports`
- `avoid_print` ✅ (production güvenliği)

## Teknik Kısıtlamalar
1. **Hive adapter sırası**: TypeId'ler sabit (0=ScannedQR, 1=GeneratedQR, 2=QRType) — değiştirilemez
2. **AdMob iOS**: iOS app ID'si henüz production'da test edilmedi
3. **Splash screen rengi**: `#101922` (AppColors.backgroundDark) ile sabitlenmiş
4. **Android package**: `com.aozka.qrscannerapp`
5. **iOS bundle**: `com.qrscanner.qrScannerApp`
6. **Firebase API key kısıtlamaları**: Google Cloud Console'da yapılandırılmalı (SECURITY_NOTES.md)

## Assets
- `assets/images/` — Uygulama görselleri
- `assets/logos/` — App icon ve splash logo
  - `app_icon.png` — Uygulama ikonu
  - `splash_logo.png` — Splash ekranı logosu
