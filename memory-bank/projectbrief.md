# Project Brief - QR Scanner & Generator

## Proje Adı
QR Scanner & Generator (QR-Maker-Scanner)

## Geliştirici
**Atakan Özkan** - [@Atakan0zkan](https://github.com/Atakan0zkan)

## Proje Özeti
Hızlı, güvenilir ve kullanıcı dostu QR kod tarayıcı ve oluşturucu mobil uygulama. Flutter ile geliştirilmiş, cross-platform (Android & iOS) destekli, production-ready bir uygulama.

## Temel Gereksinimler

### Fonksiyonel Gereksinimler
1. **QR Kod Tarama** - Kamera ile anlık QR/barkod tarama, toplu tarama modu
2. **QR Kod Oluşturma** - 9 farklı türde QR kod oluşturma (URL, WiFi, Kişi, Email, SMS, Telefon, Konum, Sosyal Medya, Metin)
3. **Özelleştirme** - Renk, şekil, gradient, logo ile QR kod kişiselleştirme
4. **Geçmiş** - Taranan ve oluşturulan kodların otomatik kayıt ve yönetimi
5. **Paylaşım** - QR kodlarını resim/metin olarak paylaşma
6. **Çoklu Dil** - 16+ dil desteği (EN, TR, ES, DE, FR, IT, EL, AR, ZH, JA, HI, PT, KO, RU, PL, UK, NL)
7. **Tema** - Koyu/Açık tema desteği

### Teknik Gereksinimler
- Production-ready güvenlik (şifreli yerel DB, env vars)
- Firebase Analytics entegrasyonu
- AdMob reklam entegrasyonu
- Codemagic CI/CD pipeline
- GDPR/COPPA uyumlu veri politikası
- Bug reporting sistemi (uygulama içi)

## Kapsam Dışı (Henüz)
- Cloud backup
- QR kod şifreleme/şifre çözme
- Batch QR oluşturma
- QR kod şablonları
- Widget desteği (Home screen)

## Platform Hedefleri
- **Android**: Google Play Store (Package: `com.aozka.qrscannerapp`)
- **iOS**: App Store (Bundle ID: `com.qrscanner.qrScannerApp`, App ID: `6755507752`)

## Versiyon
- pubspec.yaml: `1.0.0+1`
- CHANGELOG son sürüm: `1.2.3` (2025-10-21)
- README'de: `1.0.0`
