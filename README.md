# 📱 QR Scanner - Fast & Reliable

<div align="center">

**Hızlı, güvenilir ve kullanıcı dostu QR kod tarayıcı ve oluşturucu**

[![Flutter](https://img.shields.io/badge/Flutter-3.24.0-02569B?logo=flutter)](https://flutter.dev)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-blue)](https://github.com/Atakan0zkan/QR-Maker-Scanner)
[![Version](https://img.shields.io/badge/Version-1.2.2-green)](https://github.com/Atakan0zkan/QR-Maker-Scanner/releases)
[![License](https://img.shields.io/badge/License-MIT-yellow)](LICENSE)

</div>

---

## ✨ Özellikler

### 🔍 QR Kod Tarama
- ⚡ Anında QR kod tanıma
- 📦 **Toplu tarama modu** - Birden fazla QR kodu arka arkaya tara
- 🎯 Tüm QR kod türlerini destekler
- 📱 Otomatik kamera izni yönetimi

### ✏️ QR Kod Oluşturma
- 🌐 **9 farklı QR kod türü**
- 🎨 **Renkli QR kodlar** - 10 renk seçeneği
- 🖌️ Özelleştirilebilir tasarım
- 💾 Otomatik kaydetme
- 📤 Resim ve metin olarak paylaşma

### 💾 Geçmiş Yönetimi
- 📋 Taranan ve oluşturulan kodlar
- ☑️ **Toplu silme ve düzenleme**
- 🔍 Arama ve filtreleme
- 📊 Detaylı görüntüleme

### 🎨 Modern Tasarım
- 🌓 **Koyu/Açık tema** (Koyu tema varsayılan)
- 🌍 **10 dil desteği** (Eksiksiz çeviriler)
- 📱 Responsive tasarım
- ♿ Erişilebilirlik desteği
- 🎨 **Renkli QR kodlar** (10 renk paleti)

### 🔒 Güvenlik & Gizlilik
- 🔌 **%100 Çevrimdışı çalışır** (İnternet gerektirmez)
- 🔐 Veri gizliliği (Tüm veriler cihazda)
- ✅ Minimal izin yönetimi (Sadece kamera)
- 🛡️ Güvenli veri saklama (Hive encryption)
- 🚫 Reklam tracking yok

## 📱 Desteklenen QR Türleri

| Tür | Açıklama |
|-----|----------|
| 🌐 URL | Web siteleri ve linkler |
| 📝 Metin | Düz metin içeriği |
| 📶 WiFi | WiFi ağ bilgileri |
| 👤 Kişi | vCard format kişi bilgileri |
| 📧 E-posta | Email adresleri |
| 💬 SMS | SMS mesajları |
| 📞 Telefon | Telefon numaraları |
| 📍 Konum | Google/Apple Maps konumları |
| 🔗 Sosyal Medya | Sosyal medya profilleri |

## 🛠️ Kurulum

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter gen-l10n
flutter run
```

## 📦 Teknolojiler

| Kategori | Paket | Versiyon |
|----------|-------|----------|
| 📷 QR Tarama | `mobile_scanner` | ^7.1.2 |
| 🎨 QR Oluşturma | `qr_flutter` | ^4.1.0 |
| 💾 Veritabanı | `hive` | ^2.2.3 |
| 📱 Reklam | `google_mobile_ads` | ^6.0.0 |
| 🔄 State Management | `provider` | ^6.1.2 |
| 🌐 URL Launcher | `url_launcher` | ^6.3.1 |
| 📤 Paylaşım | `share_plus` | ^12.0.0 |
| 🌍 Çoklu Dil | `flutter_localizations` | SDK |

## 🚀 Deployment

### Android
```bash
# APK (Direkt kurulum)
flutter build apk --release

# App Bundle (Google Play)
flutter build appbundle --release
```

### iOS
```bash
# IPA (App Store/TestFlight)
flutter build ipa --release
```

### CI/CD (Codemagic)
```bash
# Otomatik build ve deploy
# Detaylar: CODEMAGIC_SETUP.md
```

## 🌍 Desteklenen Diller

🇬🇧 English • 🇹🇷 Türkçe • 🇪🇸 Español • 🇩🇪 Deutsch • 🇫🇷 Français • 🇮🇹 Italiano • 🇬🇷 Ελληνικά • 🇸🇦 العربية • 🇨🇳 中文 • 🇯🇵 日本語

## 📚 Dokümantasyon

| Dosya | Açıklama |
|-------|----------|
| [CHANGELOG.md](CHANGELOG.md) | Versiyon geçmişi ve güncellemeler |
| [SECURITY.md](SECURITY.md) | Güvenlik politikası ve raporlama |
| [LICENSE](LICENSE) | MIT Lisans detayları |
| [ADMOB_PRODUCTION_NOTES.md](ADMOB_PRODUCTION_NOTES.md) | AdMob production rehberi |
| [QR_COLOR_FEATURE.md](QR_COLOR_FEATURE.md) | Renkli QR kod özelliği |
| [UI_UX_IMPROVEMENTS_v1.2.2.md](UI_UX_IMPROVEMENTS_v1.2.2.md) | UI/UX iyileştirmeleri |
| [PRODUCTION_CHECKLIST.md](PRODUCTION_CHECKLIST.md) | Production hazırlık listesi |

## 🔐 Güvenlik

Güvenlik bizim için önceliklidir. Detaylı bilgi için [SECURITY.md](SECURITY.md) dosyasına bakın.

**Güvenlik Özellikleri:**
- ✅ **%100 Offline:** İnternet bağlantısı gerektirmez
- ✅ **Lokal Veri:** Tüm veriler cihazınızda saklanır
- ✅ **Minimal İzinler:** Sadece kamera izni gereklidir
- ✅ **Şifreleme:** Hive database encryption
- ✅ **Gizlilik:** Hiçbir veri toplanmaz veya paylaşılmaz
- ✅ **Açık Kaynak:** Kod tamamen şeffaf

**Güvenlik Açığı Bildirimi:**
Güvenlik açığı bulursanız lütfen [SECURITY.md](SECURITY.md) dosyasındaki talimatları takip edin.

## 🤝 Katkıda Bulunma

1. Fork yapın
2. Feature branch oluşturun (`git checkout -b feature/amazing-feature`)
3. Commit yapın (`git commit -m 'Add amazing feature'`)
4. Push yapın (`git push origin feature/amazing-feature`)
5. Pull Request açın

## 📄 Lisans

Bu proje MIT lisansı altında lisanslanmıştır. Detaylar için [LICENSE](LICENSE) dosyasına bakın.

## 👨‍💻 Geliştirici

**Atakan Özkan**

- GitHub: [@Atakan0zkan](https://github.com/Atakan0zkan)
- Repository: [QR-Maker-Scanner](https://github.com/Atakan0zkan/QR-Maker-Scanner)

## 🙏 Teşekkürler

Bu proje aşağıdaki açık kaynak paketleri kullanmaktadır:
- [mobile_scanner](https://pub.dev/packages/mobile_scanner)
- [qr_flutter](https://pub.dev/packages/qr_flutter)
- [hive](https://pub.dev/packages/hive)
- [provider](https://pub.dev/packages/provider)
- Ve diğer tüm bağımlılıklar

---

<div align="center">

**⭐ Projeyi beğendiyseniz yıldız vermeyi unutmayın!**

Made with ❤️ by [Atakan Özkan](https://github.com/Atakan0zkan)

</div>
