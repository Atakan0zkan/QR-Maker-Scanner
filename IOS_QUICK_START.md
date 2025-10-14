# 🚀 iOS Quick Start Guide

**Durum:** ✅ iOS için hazır!  
**Platform:** iOS 13.0+  
**Versiyon:** 1.2.0+2

---

## ✅ Yapılanlar

### 1. iOS Konfigürasyonu
- ✅ **Podfile** oluşturuldu
- ✅ **Info.plist** güncellendi (izinler eklendi)
- ✅ **AdMob** iOS desteği eklendi
- ✅ **Version** 1.2.0+2 olarak güncellendi

### 2. İzinler (Info.plist)
- ✅ **NSCameraUsageDescription** - QR kod tarama
- ✅ **NSPhotoLibraryUsageDescription** - Fotoğraf okuma
- ✅ **NSPhotoLibraryAddUsageDescription** - Fotoğraf kaydetme
- ✅ **NSAppTransportSecurity** - Network güvenliği
- ✅ **GADApplicationIdentifier** - AdMob App ID

### 3. AdMob
- ✅ **Android:** Production ID (`ca-app-pub-8966682109895515/8906178061`)
- ⚠️ **iOS:** Test ID (gerçek ID gerekli)
- ✅ **ad_service.dart** iOS desteği eklendi
- ✅ **main_screen.dart** iOS reklam yükleme eklendi

---

## ⏳ Yapılacaklar (macOS Gerekli)

### 1. Xcode Setup
```bash
# macOS'ta çalıştır
cd qr_scanner_app
open ios/Runner.xcworkspace
```

**Xcode'da:**
1. Runner > Signing & Capabilities
2. Team seç (Apple Developer hesabın)
3. Bundle ID gir: `com.yourcompany.qrscannerapp`
4. "Automatically manage signing" işaretle

### 2. Pod Install
```bash
# macOS'ta çalıştır
cd ios
pod install
```

### 3. Test Build
```bash
# Simulator
flutter build ios --debug --simulator

# Gerçek cihaz
flutter build ios --debug
```

### 4. AdMob iOS App Oluştur

**AdMob Console:**
1. [admob.google.com](https://admob.google.com) giriş yap
2. Apps > Add App > iOS
3. App bilgilerini doldur
4. App ID ve Ad Unit ID'leri kopyala

**Güncellenecek Dosyalar:**
```dart
// lib/services/ad_service.dart
} else if (Platform.isIOS) {
  return 'ca-app-pub-XXXXXXXXXXXXXXXX/YYYYYYYYYY'; // Gerçek ID
}
```

```xml
<!-- ios/Runner/Info.plist -->
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-XXXXXXXXXXXXXXXX~ZZZZZZZZZZ</string>
```

### 5. App Store Assets

**Gerekli:**
- App Icon (1024x1024 px)
- Launch Screen
- Screenshots (3+ adet)

**Araçlar:**
- [appicon.co](https://appicon.co) - Icon generator
- [screenshot.rocks](https://screenshot.rocks) - Screenshot frames

---

## 📝 Bundle ID Önerisi

```
com.aozka.qrscannerapp
```

veya

```
com.yourcompany.qrscannerapp
```

**Not:** Bundle ID benzersiz olmalı ve Apple Developer Portal'da kayıtlı olmalı.

---

## 🔧 Hızlı Komutlar

```bash
# Dependencies
flutter pub get
cd ios && pod install && cd ..

# Clean
flutter clean

# Build (macOS)
flutter build ios --release

# Run (macOS)
flutter run -d "iPhone 15 Pro"

# Devices
flutter devices
```

---

## 📱 Test Senaryoları

### iOS Simulator'da Test
1. Xcode'da simulator seç (iPhone 15 Pro)
2. `flutter run` çalıştır
3. Tüm özellikleri test et:
   - ✅ QR kod tarama (simulator'da kamera yok, gerçek cihaz gerekli)
   - ✅ QR kod oluşturma
   - ✅ Geçmiş görüntüleme
   - ✅ Ayarlar
   - ✅ Tema değiştirme
   - ✅ Dil değiştirme

### Gerçek iOS Cihazda Test
1. iPhone'u Mac'e bağla
2. Xcode'da cihazı seç
3. `flutter run` çalıştır
4. Kamera ile QR kod tara
5. Tüm özellikleri test et

---

## 🐛 Yaygın Hatalar

### "No Podfile found"
```bash
cd ios
flutter pub get
pod install
```

### "Signing requires a development team"
**Çözüm:** Xcode > Signing & Capabilities > Team seç

### "Module not found"
```bash
cd ios
rm -rf Pods Podfile.lock
pod install
flutter clean
flutter pub get
```

### "Archive failed"
```bash
# Xcode'da
Product > Clean Build Folder
# Derived Data sil
Xcode > Preferences > Locations > Derived Data > Delete
```

---

## 📊 Dosya Yapısı

```
ios/
├── Podfile                    ✅ Oluşturuldu
├── Runner/
│   ├── Info.plist            ✅ Güncellendi
│   ├── Assets.xcassets/
│   │   ├── AppIcon.appiconset/  ⏳ Icon eklenecek
│   │   └── LaunchImage/         ⏳ Splash eklenecek
│   └── ...
├── Runner.xcodeproj/
└── Runner.xcworkspace/       ⏳ Xcode'da açılacak
```

---

## 🎯 Sonraki Adımlar

### 1. macOS'ta (Gerekli)
1. ✅ Xcode'u aç
2. ✅ Signing ayarlarını yap
3. ✅ Pod install çalıştır
4. ✅ Test build yap

### 2. AdMob (Opsiyonel)
1. iOS app oluştur
2. App ID ve Ad Unit ID al
3. Kodda güncelle

### 3. Assets (Gerekli)
1. App Icon hazırla (1024x1024)
2. Launch Screen hazırla
3. Screenshots çek (3+)

### 4. App Store Connect
1. App oluştur
2. Metadata doldur
3. Build yükle
4. Review'a gönder

---

## 📚 Kaynaklar

### Dokümantasyon
- [IOS_DEPLOYMENT_GUIDE.md](./IOS_DEPLOYMENT_GUIDE.md) - Detaylı deployment rehberi
- [Flutter iOS Deployment](https://docs.flutter.dev/deployment/ios)
- [Apple Developer Documentation](https://developer.apple.com/documentation/)

### Araçlar
- [Xcode](https://apps.apple.com/us/app/xcode/id497799835) - App Store
- [CocoaPods](https://cocoapods.org/) - Dependency manager
- [TestFlight](https://developer.apple.com/testflight/) - Beta testing

### Topluluk
- [Flutter Discord](https://discord.gg/flutter)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter+ios)
- [Reddit r/FlutterDev](https://reddit.com/r/FlutterDev)

---

## ✅ Özet

**Windows'ta Yapılanlar:**
- ✅ Podfile oluşturuldu
- ✅ Info.plist güncellendi (izinler)
- ✅ AdMob iOS desteği eklendi
- ✅ Version güncellendi (1.2.0+2)
- ✅ Deployment guide hazırlandı

**macOS'ta Yapılacaklar:**
- ⏳ Xcode signing
- ⏳ Pod install
- ⏳ Test build
- ⏳ App Store Connect setup
- ⏳ Production build

**iOS için uygulama hazır! Sadece macOS'ta Xcode ile build yapman gerekiyor.** 🚀

---

**Not:** iOS build için **macOS ve Xcode zorunlu**. Windows'ta sadece kod hazırlığı yapılabilir.
