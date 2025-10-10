# QR Scanner & Generator

Kullanıcı dostu, hızlı ve sağlam bir QR kod tarayıcı ve oluşturucu mobil uygulama.

## 🚀 Özellikler

- ✅ **QR Kod Tarama** - Kamera ile hızlı QR kod tarama
- ✅ **QR Kod Oluşturma** - 9 farklı türde QR kod oluşturma
- ✅ **Geçmiş** - Taranan ve oluşturulan QR kodları kaydetme
- ✅ **Çoklu Dil** - 7 dil desteği (TR, EN, ES, DE, FR, IT, EL)
- ✅ **Tema** - Açık/Koyu/Sistem teması
- ✅ **AdMob** - Banner reklam entegrasyonu

## 📱 Desteklenen QR Kod Türleri

1. **URL** - Web sitesi linkleri
2. **Metin** - Düz metin
3. **WiFi** - SSID, şifre, güvenlik türü
4. **Kişi (vCard)** - İsim, telefon, e-posta
5. **E-posta** - mailto: formatı
6. **SMS** - Telefon numarası + mesaj
7. **Telefon** - Arama numarası
8. **Konum** - GPS koordinatları
9. **Sosyal Medya** - Instagram, LinkedIn, TikTok, vb.

## 🛠️ Kurulum

### 1. Bağımlılıkları Yükle

```bash
flutter pub get
```

### 2. Code Generation (Hive için)

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Localization Oluştur

```bash
flutter gen-l10n
```

### 4. Uygulamayı Çalıştır

```bash
flutter run
```

## 📦 Kullanılan Paketler

- `mobile_scanner` - QR kod tarama
- `qr_flutter` - QR kod oluşturma
- `hive` & `hive_flutter` - Lokal veritabanı
- `google_mobile_ads` - Reklam entegrasyonu
- `provider` - State management
- `permission_handler` - İzin yönetimi
- `url_launcher` - URL/telefon/mail açma
- `share_plus` - Paylaşım
- `intl` - Tarih/saat formatlama

## 🎨 Tasarım

- **Renk Paleti**: Primary #137FEC (Mavi)
- **Font**: Inter (400, 500, 600, 700, 900)
- **Tema**: Material Design 3

## 📝 Notlar

- **AdMob Test ID'leri**: Geliştirme sırasında test ID'leri kullanılmaktadır. Production için `lib/services/ad_service.dart` dosyasındaki ID'leri değiştirin.
- **Kamera İzni**: İlk açılışta izin istenir, reddedilirse popup gösterilir.
- **WiFi Bağlantı**: Android 10+ ve iOS 13+ için otomatik bağlantı kısıtlamaları var.

## 📄 Lisans

Bu proje özel bir projedir.

## 👨‍💻 Geliştirici

Cascade AI tarafından geliştirilmiştir.
