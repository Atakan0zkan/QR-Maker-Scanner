# 📱 iOS Deployment Guide - QR Scanner App

**Versiyon:** 1.2.0+2  
**Tarih:** 14 Ekim 2025  
**Platform:** iOS 13.0+

---

## 📋 Ön Gereksinimler

### 1. Gerekli Araçlar
- ✅ macOS (Monterey veya üzeri)
- ✅ Xcode 14.0+ (App Store'dan indir)
- ✅ Flutter SDK (güncel versiyon)
- ✅ CocoaPods (`sudo gem install cocoapods`)
- ✅ Apple Developer Account ($99/yıl)

### 2. Apple Developer Hesabı
1. [developer.apple.com](https://developer.apple.com) adresine git
2. Apple ID ile giriş yap
3. Developer Program'a kayıt ol ($99/yıl)
4. Onay bekle (1-2 gün)

---

## 🔧 Proje Konfigürasyonu

### 1. Bundle Identifier Belirle

**Önerilen Format:**
```
com.yourcompany.qrscannerapp
```

**Örnek:**
```
com.aozka.qrscannerapp
```

### 2. Xcode'da Proje Ayarları

#### Adım 1: Xcode'u Aç
```bash
cd qr_scanner_app
open ios/Runner.xcworkspace
```

⚠️ **ÖNEMLİ:** `Runner.xcodeproj` değil, `Runner.xcworkspace` açın!

#### Adım 2: Signing & Capabilities
1. Xcode'da **Runner** projesini seç
2. **Signing & Capabilities** sekmesine git
3. **Team** seçimini yap (Apple Developer hesabın)
4. **Bundle Identifier** gir: `com.yourcompany.qrscannerapp`
5. **Automatically manage signing** işaretle

#### Adım 3: General Settings
- **Display Name:** QR Scanner
- **Version:** 1.2.0
- **Build:** 2
- **Deployment Target:** iOS 13.0
- **Devices:** iPhone, iPad

#### Adım 4: Capabilities Ekle
- ✅ **Camera** (zaten Info.plist'te)
- ✅ **Photo Library** (zaten Info.plist'te)

---

## 📦 Dependencies Kurulumu

### 1. Flutter Dependencies
```bash
cd qr_scanner_app
flutter pub get
```

### 2. iOS Pods
```bash
cd ios
pod install
```

Eğer hata alırsan:
```bash
pod repo update
pod install --repo-update
```

### 3. Temizlik (Gerekirse)
```bash
cd ios
rm -rf Pods Podfile.lock
pod install
```

---

## 🏗️ Build İşlemleri

### 1. Debug Build (Test)
```bash
# Simulator için
flutter build ios --debug --simulator

# Gerçek cihaz için
flutter build ios --debug
```

### 2. Release Build (Production)
```bash
flutter build ios --release
```

### 3. Archive (App Store)
1. Xcode'da **Product > Archive** seç
2. Archive tamamlanınca **Organizer** açılır
3. **Distribute App** butonuna bas

---

## 🎨 App Store Assets

### 1. App Icon (Gerekli)

**Boyutlar:**
- 1024x1024 px (App Store)
- 180x180 px (iPhone)
- 167x167 px (iPad Pro)
- 152x152 px (iPad)
- 120x120 px (iPhone)
- 87x87 px (iPhone)
- 80x80 px (iPad)
- 76x76 px (iPad)
- 60x60 px (iPhone)
- 58x58 px (iPhone)
- 40x40 px (iPad)
- 29x29 px (iPhone/iPad)
- 20x20 px (iPad)

**Konum:**
```
ios/Runner/Assets.xcassets/AppIcon.appiconset/
```

**Araç:** [appicon.co](https://appicon.co) - Tek resimden tüm boyutları oluşturur

### 2. Launch Screen (Splash)

**Konum:**
```
ios/Runner/Assets.xcassets/LaunchImage.imageset/
```

**Boyutlar:**
- 1242x2688 px (iPhone 12 Pro Max)
- 1125x2436 px (iPhone X)
- 750x1334 px (iPhone 8)

### 3. Screenshots (App Store)

**Gerekli Boyutlar:**
- **6.7" Display:** 1290x2796 px (iPhone 14 Pro Max)
- **6.5" Display:** 1242x2688 px (iPhone 11 Pro Max)
- **5.5" Display:** 1242x2208 px (iPhone 8 Plus)

**En az 3, en fazla 10 screenshot gerekli**

---

## 📝 App Store Connect

### 1. App Oluştur

1. [appstoreconnect.apple.com](https://appstoreconnect.apple.com) giriş yap
2. **My Apps** > **+** > **New App**
3. Bilgileri doldur:
   - **Platform:** iOS
   - **Name:** QR Scanner - Fast & Reliable
   - **Primary Language:** Turkish
   - **Bundle ID:** com.yourcompany.qrscannerapp
   - **SKU:** qrscannerapp-001

### 2. App Bilgileri

#### Temel Bilgiler
```
Name: QR Scanner - Fast & Reliable
Subtitle: Scan & Create QR Codes Instantly
```

#### Açıklama (Türkçe)
```
QR Scanner - Hızlı ve Güvenilir QR Kod Tarayıcı ve Oluşturucu

🔍 ÖZELLİKLER:

📱 HIZLI TARAMA
• Anında QR kod tanıma
• Toplu tarama modu
• Tüm QR kod türlerini destekler

✨ QR KOD OLUŞTURMA
• URL, Metin, WiFi, Kişi
• E-posta, SMS, Telefon
• Konum ve Sosyal Medya

💾 GEÇMİŞ YÖNETİMİ
• Taranan ve oluşturulan kodlar
• Toplu silme ve düzenleme
• Arama ve filtreleme

🎨 MODERN TASARIM
• Koyu/Açık tema
• 10 dil desteği
• Kullanıcı dostu arayüz

🔒 GÜVENLİK
• Çevrimdışı çalışır
• Veri gizliliği
• İzin yönetimi

📤 PAYLAŞIM
• PDF, PNG, SVG export
• Sosyal medya paylaşımı
• Toplu dışa aktarma

✅ ÜCRETSİZ
• Reklamsız deneyim
• Tüm özellikler açık
• Sınırsız kullanım
```

#### Keywords (Anahtar Kelimeler)
```
qr kod, qr tarayıcı, qr oluşturucu, barkod, tarayıcı, kod okuyucu, qr reader, qr scanner
```

#### Support URL
```
https://yourwebsite.com/support
```

#### Privacy Policy URL
```
https://yourwebsite.com/privacy
```

### 3. Fiyatlandırma

- **Price:** Free (Ücretsiz)
- **Availability:** All Countries

### 4. App Review Bilgileri

#### Demo Account (Gerekirse)
```
Username: demo@example.com
Password: Demo123!
```

#### Notes
```
Bu uygulama QR kod tarama ve oluşturma için tasarlanmıştır.
Tüm özellikler çevrimdışı çalışır.
Kamera izni sadece QR kod tarama için kullanılır.
```

---

## 🚀 Upload İşlemi

### 1. Xcode'dan Upload

1. **Product > Archive** ile archive oluştur
2. **Organizer** açılınca **Distribute App** seç
3. **App Store Connect** seç
4. **Upload** seç
5. Signing seçeneklerini onayla
6. **Upload** butonuna bas
7. İşlem tamamlanınca **Done**

### 2. App Store Connect'te Onay

1. [appstoreconnect.apple.com](https://appstoreconnect.apple.com) giriş yap
2. Uygulamayı seç
3. **TestFlight** sekmesinde build'i gör (5-10 dakika)
4. **App Store** sekmesine git
5. **+ Version or Platform** > **iOS**
6. Build'i seç
7. Tüm bilgileri doldur
8. **Submit for Review** butonuna bas

---

## 🧪 TestFlight (Beta Test)

### 1. Internal Testing

1. App Store Connect'te **TestFlight** sekmesi
2. **Internal Testing** > **+** > **Create Group**
3. Test kullanıcıları ekle (Apple ID ile)
4. Build'i seç ve dağıt

### 2. External Testing

1. **External Testing** > **+** > **Create Group**
2. Test kullanıcıları ekle (e-posta ile)
3. Beta App Review için gönder
4. Onaylandıktan sonra test başlar

### 3. Test Kullanıcıları

Test kullanıcıları:
1. TestFlight uygulamasını indirir (App Store)
2. Davet e-postasındaki linke tıklar
3. Uygulamayı TestFlight'tan indirir
4. Test eder ve geri bildirim gönderir

---

## ✅ Pre-Launch Checklist

### Kod Kontrolü
- [ ] `flutter analyze` hatasız
- [ ] `flutter test` başarılı
- [ ] iOS build başarılı
- [ ] Simulator'da test edildi
- [ ] Gerçek cihazda test edildi

### Xcode Ayarları
- [ ] Bundle ID doğru
- [ ] Team seçildi
- [ ] Version ve Build numarası doğru
- [ ] Deployment Target: iOS 13.0
- [ ] Signing otomatik

### Info.plist
- [ ] Camera permission açıklaması
- [ ] Photo Library permission açıklaması
- [ ] Display name doğru
- [ ] Bundle name doğru

### Assets
- [ ] App Icon tüm boyutlarda
- [ ] Launch Screen hazır
- [ ] Screenshots hazır (3+ adet)

### App Store Connect
- [ ] App oluşturuldu
- [ ] Açıklama yazıldı
- [ ] Keywords eklendi
- [ ] Screenshots yüklendi
- [ ] Privacy Policy URL
- [ ] Support URL
- [ ] Fiyatlandırma ayarlandı

---

## 🐛 Yaygın Hatalar ve Çözümler

### Hata 1: "No Podfile found"
```bash
cd ios
flutter pub get
pod install
```

### Hata 2: "Signing for Runner requires a development team"
**Çözüm:** Xcode'da Signing & Capabilities > Team seç

### Hata 3: "Module not found"
```bash
cd ios
rm -rf Pods Podfile.lock
pod install
flutter clean
flutter pub get
```

### Hata 4: "Archive failed"
**Çözüm:** 
1. Xcode'da Product > Clean Build Folder
2. Derived Data sil: Xcode > Preferences > Locations > Derived Data > Delete
3. Tekrar dene

### Hata 5: "Invalid Bundle"
**Çözüm:** Info.plist'te gerekli key'leri kontrol et

---

## 📊 Build Komutları Özeti

```bash
# 1. Dependencies
flutter pub get
cd ios && pod install && cd ..

# 2. Clean (Gerekirse)
flutter clean

# 3. Debug Build
flutter build ios --debug

# 4. Release Build
flutter build ios --release

# 5. Simulator'da Çalıştır
flutter run -d "iPhone 15 Pro"

# 6. Gerçek Cihazda Çalıştır
flutter run -d <device-id>

# 7. Device ID Bul
flutter devices
```

---

## 🔐 Code Signing

### Development Provisioning Profile
1. Apple Developer Portal > Certificates, IDs & Profiles
2. Profiles > + > iOS App Development
3. App ID seç
4. Certificate seç
5. Device seç
6. İndir ve çift tıkla

### Distribution Provisioning Profile
1. Profiles > + > App Store
2. App ID seç
3. Certificate seç
4. İndir ve çift tıkla

---

## 📱 Test Cihazları Ekleme

1. Apple Developer Portal > Devices
2. + > Register Device
3. Device Name ve UDID gir
4. Save

**UDID Bulma:**
- Xcode > Window > Devices and Simulators
- Cihazı seç, UDID'yi kopyala

---

## 🎯 App Store Review Süreci

### 1. Review Süresi
- **Ortalama:** 24-48 saat
- **İlk Gönderim:** 2-5 gün
- **Güncelleme:** 1-2 gün

### 2. Reddetme Sebepleri
- Eksik bilgi/screenshot
- Kırık özellik
- Privacy policy eksik
- Guideline ihlali

### 3. Reddetme Durumunda
1. Reddetme sebebini oku
2. Gerekli düzeltmeleri yap
3. Yeni build yükle veya bilgi güncelle
4. Tekrar gönder

---

## 📈 Post-Launch

### 1. Monitoring
- App Store Connect > Analytics
- Crash reports kontrol et
- User reviews oku

### 2. Updates
```bash
# Version güncelle
# pubspec.yaml: version: 1.2.1+3

flutter build ios --release
# Xcode'da archive ve upload
```

### 3. Marketing
- App Store Optimization (ASO)
- Social media paylaşımı
- Website'de tanıtım

---

## 🆘 Destek

### Apple Developer Support
- [developer.apple.com/support](https://developer.apple.com/support)
- Phone: 1-800-633-2152

### Flutter iOS Docs
- [docs.flutter.dev/deployment/ios](https://docs.flutter.dev/deployment/ios)

### Stack Overflow
- Tag: `flutter`, `ios`, `xcode`

---

## ✅ Özet

1. ✅ **Podfile oluşturuldu**
2. ✅ **Info.plist güncellenmiş** (izinler eklendi)
3. ✅ **Version 1.2.0+2** olarak güncellendi
4. ⏳ **Xcode'da signing yapılacak** (macOS gerekli)
5. ⏳ **App Store Connect'te app oluşturulacak**
6. ⏳ **Assets hazırlanacak** (icon, screenshots)
7. ⏳ **Build ve upload** (macOS + Xcode gerekli)

---

**Sonraki Adım:** macOS'ta Xcode ile projeyi aç ve signing ayarlarını yap! 🚀

**Not:** iOS build için macOS ve Xcode şart. Windows'ta sadece hazırlık yapılabilir.
