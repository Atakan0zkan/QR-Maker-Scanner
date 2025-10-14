# QR Scanner & Generator

Kullanıcı dostu, hızlı ve güvenilir QR kod tarayıcı ve oluşturucu.

## 🚀 Özellikler

- **QR Kod Tarama** - Kamera ile anlık tarama
- **QR Kod Oluşturma** - 9 farklı türde QR kod
- **QR Kod Paylaşma** - QR kodları resim ve metin olarak paylaşma
- **Google Maps Entegrasyonu** - Konum QR kodları için kullanıcı dostu arama
- **Geçmiş** - Taranan/oluşturulan kodları kaydetme
- **Otomatik Dil** - Sistem diline göre otomatik dil seçimi (10 dil: EN, TR, ES, DE, FR, IT, EL, AR, ZH, JA)
- **Tema** - Açık/Koyu/Sistem teması
- **AdMob** - Banner reklam entegrasyonu

## 📱 Desteklenen QR Türleri

URL • Metin • WiFi • Kişi (vCard) • E-posta • SMS • Telefon • Konum (Google/Apple Maps) • Sosyal Medya

## 🛠️ Kurulum

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter gen-l10n
flutter run
```

## 📦 Ana Paketler

`mobile_scanner` • `qr_flutter` • `hive` • `google_mobile_ads` • `provider` • `url_launcher` • `share_plus`

## 📝 Önemli Notlar

- **AdMob**: Test ID kullanılıyor. Production için `AndroidManifest.xml` güncelleyin
- **Konum QR**: Google Maps entegrasyonu ile kullanıcı dostu konum arama
- **Otomatik Dil**: Uygulama, kullanıcının telefon diline göre otomatik açılır
- **Desteklenen Diller**: İngilizce, Türkçe, İspanyolca, Almanca, Fransızca, İtalyanca, Yunanca, Arapça, Çince, Japonca
- **Desteklenmeyen Diller**: İngilizce olarak gösterilir
- **QR Paylaşma**: QR kodları resim ve metin olarak paylaşılabilir
- **Deprecated Uyarılar**: 8 adet deprecated uyarı var (kritik değil), detaylar için `DEPRECATED_WARNINGS.md`

## 🔧 Build

```bash
# APK
flutter build apk --release

# App Bundle
flutter build appbundle --release
```
