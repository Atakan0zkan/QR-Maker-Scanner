# 📱 QR Scanner

[![Flutter](https://img.shields.io/badge/Flutter-3.9+-02569B?logo=flutter)](https://flutter.dev)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-blue)](https://github.com/Atakan0zkan/QR-Maker-Scanner)
[![Version](https://img.shields.io/badge/Version-1.2.2-green)](https://github.com/Atakan0zkan/QR-Maker-Scanner/releases)
[![License](https://img.shields.io/badge/License-MIT-yellow)](LICENSE)

Hızlı, güvenilir ve kullanıcı dostu QR kod tarayıcı ve oluşturucu.

## ✨ Özellikler

- 🔍 **Anında QR tarama** - Toplu tarama modu ile birden fazla QR okuyabilirsiniz
- 🎨 **9 QR türü** - URL, WiFi, Kişi, Email, SMS, Telefon, Konum, Sosyal Medya, Metin
- 🌈 **Renkli QR kodlar** - 10 farklı renk seçeneği ile özelleştirme
- 💾 **Geçmiş yönetimi** - Taranan ve oluşturulan kodlar otomatik kaydedilir
- 🌍 **10 dil desteği** - EN, TR, ES, DE, FR, IT, EL, AR, ZH, JA
- 🌓 **Koyu/Açık tema** - Varsayılan koyu tema
- 🔒 **%100 Offline** - İnternet gerektirmez, veriler cihazda saklanır

## 🚀 Kurulum

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter gen-l10n
flutter run
```

## 📦 Teknolojiler

- **QR:** `mobile_scanner` ^7.1.2, `qr_flutter` ^4.1.0
- **Database:** `hive` ^2.2.3 + `hive_flutter` ^1.1.0
- **State:** `provider` ^6.1.2
- **Ads:** `google_mobile_ads` ^6.0.0
- **Utils:** `url_launcher`, `share_plus`, `permission_handler`, `intl`

## 🏗️ Build

```bash
# Android
flutter build apk --release           # APK
flutter build appbundle --release     # App Bundle (Google Play)

# iOS
flutter build ipa --release           # IPA (App Store)
```

## 📄 Lisans

MIT License - detaylar için [LICENSE](LICENSE) dosyasına bakın.

## 🔐 Güvenlik

Güvenlik açığı bulursanız [SECURITY.md](SECURITY.md) dosyasındaki talimatları takip edin.

## 👨‍💻 Geliştirici

**Atakan Özkan** - [@Atakan0zkan](https://github.com/Atakan0zkan)

---

⭐ Projeyi beğendiyseniz yıldız vermeyi unutmayın!
