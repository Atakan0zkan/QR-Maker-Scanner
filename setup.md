# QR Scanner App - Kurulum Adımları

Bu dosya, projeyi çalıştırmak için gereken tüm adımları içerir.

## 📋 Gereksinimler

- Flutter SDK (3.35.5 veya üzeri)
- Android Studio (Android geliştirme için)
- Dart SDK (3.9.2 veya üzeri)

## 🚀 Kurulum Adımları

### 1. Bağımlılıkları Yükle

```bash
cd qr_scanner_app
flutter pub get
```

Bu komut tüm gerekli paketleri indirecektir.

### 2. Code Generation (Hive Modelleri için)

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Bu komut Hive için gerekli `.g.dart` dosyalarını oluşturacaktır:
- `lib/models/qr_type.g.dart`
- `lib/models/scanned_qr.g.dart`
- `lib/models/generated_qr.g.dart`

### 3. Localization Dosyalarını Oluştur

```bash
flutter gen-l10n
```

Bu komut `lib/l10n/` klasöründeki `.arb` dosyalarından localization kodlarını oluşturacaktır.

### 4. Uygulamayı Çalıştır

```bash
flutter run
```

veya Android Studio'da:
- Cihaz/Emulator seçin
- Run butonuna basın (Shift+F10)

## 🔧 Olası Sorunlar ve Çözümler

### Sorun 1: "Target of URI doesn't exist" Hataları

**Çözüm:** Önce `flutter pub get` komutunu çalıştırın.

### Sorun 2: Hive `.g.dart` Dosyaları Bulunamıyor

**Çözüm:** 
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Sorun 3: Localization Hataları

**Çözüm:**
```bash
flutter gen-l10n
```

### Sorun 4: Kamera İzni Çalışmıyor

**Çözüm:** 
- Android: `AndroidManifest.xml` dosyasında kamera izni eklendiğinden emin olun
- Fiziksel cihazda test edin (emulator kamerası sorunlu olabilir)

### Sorun 5: AdMob Reklamlar Görünmüyor

**Çözüm:**
- Test ID'leri kullanıldığından emin olun
- İnternet bağlantısını kontrol edin
- Fiziksel cihazda test edin

## 📱 Test Etme

### Android Emulator'da Test

```bash
flutter run
```

### Fiziksel Cihazda Test

1. USB Debugging'i açın
2. Cihazı bilgisayara bağlayın
3. ```bash
   flutter devices
   flutter run -d <device-id>
   ```

## 🏗️ Build Alma

### Android APK

```bash
flutter build apk --release
```

APK dosyası: `build/app/outputs/flutter-apk/app-release.apk`

### Android App Bundle (Google Play için)

```bash
flutter build appbundle --release
```

AAB dosyası: `build/app/outputs/bundle/release/app-release.aab`

## 🔑 AdMob Entegrasyonu (Production için)

1. Google AdMob'da hesap oluşturun
2. Uygulama ekleyin ve App ID alın
3. Banner Ad Unit ID oluşturun
4. Dosyaları güncelleyin:

**Android:** `android/app/src/main/AndroidManifest.xml`
```xml
<meta-data
    android:name="com.google.android.gms.ads.APPLICATION_ID"
    android:value="ca-app-pub-XXXXXXXXXXXXXXXX~YYYYYYYYYY"/>
```

**Kod:** `lib/services/ad_service.dart`
```dart
static String get bannerAdUnitId {
  if (Platform.isAndroid) {
    return 'ca-app-pub-XXXXXXXXXXXXXXXX/YYYYYYYYYY';
  } else if (Platform.isIOS) {
    return 'ca-app-pub-XXXXXXXXXXXXXXXX/YYYYYYYYYY';
  }
  throw UnsupportedError('Unsupported platform');
}
```

## 📊 Proje Yapısı

```
lib/
├── core/
│   ├── constants/
│   │   └── app_colors.dart
│   └── theme/
│       └── app_theme.dart
├── l10n/
│   ├── app_en.arb
│   ├── app_tr.arb
│   ├── app_es.arb
│   ├── app_de.arb
│   ├── app_fr.arb
│   ├── app_it.arb
│   └── app_el.arb
├── models/
│   ├── qr_type.dart
│   ├── scanned_qr.dart
│   └── generated_qr.dart
├── providers/
│   ├── theme_provider.dart
│   └── qr_provider.dart
├── screens/
│   ├── main_screen.dart
│   ├── scanner_screen.dart
│   ├── create_screen.dart
│   ├── history_screen.dart
│   ├── settings_screen.dart
│   └── qr_detail_screen.dart
├── services/
│   ├── database_service.dart
│   ├── qr_helper.dart
│   ├── permission_service.dart
│   └── ad_service.dart
├── widgets/
│   ├── scanner_overlay.dart
│   └── permission_dialog.dart
└── main.dart
```

## ✅ Kontrol Listesi

- [ ] Flutter SDK kurulu
- [ ] `flutter pub get` çalıştırıldı
- [ ] `flutter pub run build_runner build` çalıştırıldı
- [ ] `flutter gen-l10n` çalıştırıldı
- [ ] Hata yok
- [ ] Uygulama çalışıyor
- [ ] Kamera izni çalışıyor
- [ ] QR tarama çalışıyor
- [ ] QR oluşturma çalışıyor
- [ ] Geçmiş kaydediliyor
- [ ] Banner reklam görünüyor

## 🐛 Hata Raporlama

Hataları `bug-log.md` dosyasına kaydedin.

## 📞 Destek

Sorun yaşarsanız:
1. `bug-log.md` dosyasını kontrol edin
2. `flutter doctor` çalıştırın
3. `flutter clean` ve tekrar `flutter pub get` deneyin

---

**Son Güncelleme:** 10 Ekim 2025
