# QR Scanner & Generator App - Project Plan

**Proje Başlangıç Tarihi:** 10 Ekim 2025  
**Platform:** Flutter  
**Test Ortamı:** Android Studio  
**Durum:** 🚧 Geliştirme Aşamasında

---

## 📋 Proje Özeti

Kullanıcı dostu, hızlı ve sağlam bir QR kod tarayıcı ve oluşturucu mobil uygulama.

### Temel Özellikler
- ✅ QR kod tarama (kamera ile)
- ✅ QR kod oluşturma (çoklu format)
- ✅ Geçmiş kayıtları (Hive DB)
- ✅ Çoklu dil desteği (7 dil)
- ✅ AdMob banner reklamlar
- ✅ Export/Import (PNG, PDF, Paylaş)

---

## 🎯 Desteklenen QR Kod Türleri

### Tarama & Oluşturma
1. **URL** - Web sitesi linkleri
2. **Metin** - Düz metin
3. **WiFi** - SSID, şifre, güvenlik türü
4. **Contact (vCard)** - İsim, telefon, e-posta
5. **E-posta** - mailto: formatı
6. **SMS** - Telefon numarası + mesaj
7. **Telefon** - Arama numarası
8. **Konum** - GPS koordinatları (geo:)
9. **Sosyal Medya** - Instagram, LinkedIn, TikTok, vb.

---

## 🎨 Ekranlar

### 1. Ana Ekran (Scanner)
- Kamera preview
- Tarama animasyonu (scanner line)
- Alt navigation bar
- Banner reklam (navigation bar üstünde)

### 2. QR Kod Oluşturma
- Tür seçici (dropdown)
- Dinamik form alanları
- Oluştur butonu
- Preview ve kaydetme

### 3. Geçmiş
- İki sekme: "Taranan" ve "Oluşturulan"
- Liste görünümü (tip ikonu, tarih, içerik)
- Detay görüntüleme
- Silme ve paylaşma

### 4. Ayarlar
- Dil seçimi
- Tema (Light/Dark)
- Bildirimler
- Gizlilik politikası
- Hizmet şartları
- Uygulama sürümü

---

## 🛠️ Teknoloji Stack

### Core
- **Flutter SDK:** En güncel stable versiyon
- **Dart:** 3.x

### Paketler
- `qr_code_scanner` veya `mobile_scanner` - QR tarama
- `qr_flutter` - QR kod oluşturma
- `hive` + `hive_flutter` - Lokal veritabanı
- `google_mobile_ads` - AdMob entegrasyonu
- `permission_handler` - İzin yönetimi
- `url_launcher` - URL/telefon/mail açma
- `share_plus` - Paylaşım
- `path_provider` - Dosya yolu
- `image_gallery_saver` - Galeriye kaydetme
- `pdf` - PDF oluşturma
- `flutter_localizations` - Çoklu dil
- `intl` - Tarih/saat formatlama
- `provider` veya `riverpod` - State management

---

## 🌍 Dil Desteği

1. 🇹🇷 Türkçe (Varsayılan)
2. 🇬🇧 İngilizce
3. 🇪🇸 İspanyolca
4. 🇩🇪 Almanca
5. 🇫🇷 Fransızca
6. 🇮🇹 İtalyanca
7. 🇬🇷 Yunanca

---

## 💰 Reklam Stratejisi

### Banner Reklamlar
- **Konum:** Ana ekranda, navigation bar'ın hemen üstünde
- **Boyut:** Standart banner (320x50) veya adaptive banner
- **Platform:** Google AdMob
- **Premium:** Yok (tüm özellikler ücretsiz)

---

## 🔐 İzinler

### Android (AndroidManifest.xml)
```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
```

### iOS (Info.plist)
```xml
<key>NSCameraUsageDescription</key>
<string>QR kod taramak için kamera erişimi gereklidir</string>
<key>NSPhotoLibraryAddUsageDescription</key>
<string>QR kodları galeriye kaydetmek için izin gereklidir</string>
```

### İzin Yönetimi
- Kamera izni reddedilirse → Custom popup göster
- Popup içeriği: "Uygulama kamera izni olmadan çalışamaz. Lütfen ayarlardan izin verin."
- Butonlar: "Ayarlara Git" / "İptal" (uygulamadan çık)

---

## 📊 Veritabanı Yapısı (Hive)

### ScannedQR Model
```dart
@HiveType(typeId: 0)
class ScannedQR {
  @HiveField(0) String id;
  @HiveField(1) String content;
  @HiveField(2) QRType type;
  @HiveField(3) DateTime scannedAt;
  @HiveField(4) Map<String, dynamic>? metadata;
}
```

### GeneratedQR Model
```dart
@HiveType(typeId: 1)
class GeneratedQR {
  @HiveField(0) String id;
  @HiveField(1) String content;
  @HiveField(2) QRType type;
  @HiveField(3) DateTime createdAt;
  @HiveField(4) String? title;
  @HiveField(5) Uint8List? qrImage;
}
```

### QRType Enum
```dart
enum QRType {
  url, text, wifi, contact, email, sms, phone, location, social
}
```

---

## 🎬 QR Kod Aksiyonları

| Tür | Aksiyon |
|-----|---------|
| **URL** | Tarayıcıda aç (url_launcher) |
| **Metin** | Kopyala, Paylaş |
| **WiFi** | SSID/Şifre göster, Kopyala, WiFi ayarlarına git |
| **Contact** | Rehbere ekle (contacts_service) |
| **E-posta** | Mail uygulamasını aç (mailto:) |
| **SMS** | Mesaj uygulamasını aç (sms:) |
| **Telefon** | Arama yap veya mesaj gönder (tel:) |
| **Konum** | Haritada göster (Google Maps/Apple Maps) |
| **Sosyal** | Profil aç (deep link) |

---

## 📤 Export/Import Özellikleri

### Export
1. **Resim olarak kaydet** (PNG/JPG)
   - Galeriye direkt kaydet
   - `image_gallery_saver` paketi

2. **PDF olarak kaydet**
   - Tek veya çoklu QR kod
   - `pdf` paketi ile oluştur
   - Dosya sistemine kaydet

3. **Paylaş**
   - `share_plus` paketi
   - Sosyal medya, mail, mesaj

---

## 🎨 Tasarım Sistemi

### Renkler
```dart
primary: #137fec (Mavi)
backgroundLight: #f6f7f8
backgroundDark: #101922
```

### Tipografi
- Font: Inter (400, 500, 600, 700, 900)

### Tema
- Light mode
- Dark mode (sistem temasını takip et)

---

## 📱 Minimum Gereksinimler

- **Android:** API 21+ (Android 5.0 Lollipop)
- **iOS:** iOS 12.0+

---

## 🚀 Geliştirme Aşamaları

### Phase 1: Temel Yapı ✅
- [x] Proje oluşturma
- [ ] Bağımlılıklar
- [ ] Klasör yapısı
- [ ] Tema ve renkler

### Phase 2: Veritabanı & State Management
- [ ] Hive kurulumu
- [ ] Model sınıfları
- [ ] Repository pattern
- [ ] Provider/Riverpod setup

### Phase 3: UI Geliştirme
- [ ] Ana ekran (Scanner)
- [ ] QR oluşturma ekranı
- [ ] Geçmiş ekranı
- [ ] Ayarlar ekranı
- [ ] Navigation bar

### Phase 4: Core Özellikler
- [ ] QR tarama
- [ ] QR oluşturma (tüm tipler)
- [ ] Kamera izin yönetimi
- [ ] QR aksiyonları

### Phase 5: Ek Özellikler
- [ ] Export/Import
- [ ] Çoklu dil
- [ ] AdMob entegrasyonu

### Phase 6: Test & Polish
- [ ] Unit testler
- [ ] Widget testler
- [ ] Android test
- [ ] iOS test (opsiyonel)
- [ ] Bug fixing

---

## 📝 Notlar

- **AdMob Test ID'leri:** Geliştirme sırasında test ID'leri kullanılacak
- **Kamera İzni:** İlk açılışta izin istenir, reddedilirse popup gösterilir
- **WiFi Bağlantı:** Android 10+ ve iOS 13+ için otomatik bağlantı kısıtlamaları var
- **vCard Format:** Contact QR kodları için standart vCard 3.0 formatı kullanılacak

---

## 🔄 Güncellemeler

| Tarih | Güncelleme |
|-------|------------|
| 10.10.2025 10:31 | Proje planı oluşturuldu |
| 10.10.2025 10:46 | Tüm ekranlar ve servisler tamamlandı |
| 10.10.2025 10:47 | Android izinleri ve AdMob entegrasyonu eklendi |

## ✅ Tamamlanan Özellikler

- [x] Proje yapısı ve konfigürasyon
- [x] Çoklu dil desteği (7 dil)
- [x] Hive veritabanı modelleri
- [x] Theme provider (Açık/Koyu/Sistem)
- [x] QR Provider (State management)
- [x] Scanner ekranı (kamera + overlay animasyonu)
- [x] Create ekranı (9 QR türü)
- [x] History ekranı (Taranan/Oluşturulan)
- [x] Settings ekranı
- [x] QR Detail ekranı (Aksiyonlar)
- [x] Permission dialog
- [x] AdMob banner entegrasyonu
- [x] Android manifest izinleri

## 🔨 Yapılacaklar

- [ ] `flutter pub get` çalıştır
- [ ] `flutter pub run build_runner build --delete-conflicting-outputs` çalıştır
- [ ] `flutter gen-l10n` çalıştır
- [ ] Uygulamayı test et
- [ ] Hataları düzelt
- [ ] Export/Import özellikleri ekle (opsiyonel)

---

**Son Güncelleme:** 10 Ekim 2025, 10:47
