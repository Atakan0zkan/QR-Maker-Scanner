# Changelog - QR Scanner App

## [1.1.0] - 2025-10-14

### 🆕 Yeni Özellikler

#### QR Kod Paylaşma
- QR kodlarını resim olarak paylaşma (PNG, yüksek çözünürlük)
- QR içeriğini metin olarak paylaşma
- WhatsApp, Telegram, Email, sosyal medya entegrasyonu
- Create ekranından ve Detail ekranından paylaşma

#### Google Maps Entegrasyonu
- Konum QR kodları için kullanıcı dostu arama
- "Galata Kulesi, İstanbul" gibi konum adları ile arama
- Google Maps'te konum seçme ve URL kopyalama
- Koordinat girişi (opsiyonel, gelişmiş kullanıcılar için)
- Otomatik Google Maps linki oluşturma

#### Genişletilmiş Dil Desteği
- 🇸🇦 Arapça (ar)
- 🇨🇳 Çince (zh)
- 🇯🇵 Japonca (ja)
- **Toplam:** 10 dil desteği

#### UX İyileştirmeleri
- Kişi formundan "Şirket" alanı kaldırıldı (daha basit form)
- Konum QR oluşturma daha kullanıcı dostu
- Paylaşma butonları daha görünür

### 🐛 Düzeltmeler

- Default dil İngilizce olarak ayarlandı
- Scanner çoklu ses problemi çözüldü
- Gereksiz "Bildirimler" butonu kaldırıldı
- Otomatik dil algılama iyileştirildi

### 🔧 Teknik Değişiklikler

#### Yeni Dosyalar
- `lib/l10n/app_ar.arb` - Arapça çeviriler
- `lib/l10n/app_zh.arb` - Çince çeviriler
- `lib/l10n/app_ja.arb` - Japonca çeviriler
- `CHANGELOG.md` - Versiyon geçmişi

#### Güncellenen Dosyalar
- `lib/screens/create_screen.dart`
  - QR paylaşma fonksiyonu eklendi
  - Google Maps entegrasyonu
  - RepaintBoundary ile QR resim export
- `lib/screens/qr_detail_screen.dart`
  - Share.share() entegrasyonu
  - QR içerik paylaşma
- `lib/services/qr_helper.dart`
  - `formatContactQR()` - company parametresi kaldırıldı
- `lib/providers/locale_provider.dart`
  - 3 yeni dil eklendi (ar, zh, ja)
- `lib/main.dart`
  - supportedLocales güncellendi

#### Bağımlılıklar
- `share_plus` - QR paylaşma için kullanılıyor
- `path_provider` - Geçici dosya oluşturma için
- `url_launcher` - Google Maps açma için

### 📊 İstatistikler

- **Toplam Dil:** 7 → 10
- **Yeni Özellik:** 4
- **Düzeltilen Bug:** 4
- **Kaldırılan Özellik:** 2 (Şirket alanı, Manuel dil seçimi)

---

## [1.0.0] - 2025-10-10

### 🎉 İlk Sürüm

#### Temel Özellikler
- QR Kod Tarama (mobile_scanner)
- QR Kod Oluşturma (9 tür)
- Geçmiş Yönetimi (Hive)
- 7 Dil Desteği (en, tr, es, de, fr, it, el)
- Tema Desteği (Açık/Koyu/Sistem)
- AdMob Entegrasyonu

#### QR Kod Türleri
1. URL
2. Metin
3. WiFi
4. Kişi (vCard)
5. E-posta
6. SMS
7. Telefon
8. Konum (geo:)
9. Sosyal Medya

#### Ekranlar
- Ana Ekran (Bottom Navigation)
- Scanner Ekranı
- Create Ekranı
- History Ekranı (Taranan/Oluşturulan)
- Settings Ekranı
- QR Detail Ekranı

---

## Gelecek Sürümler

### [1.2.0] - Planlanan
- QR Kod Düzenleme
- Favori QR Kodlar
- QR Kod Şablonları
- Tarama Geçmişi Filtreleme
- Toplu İşlemler

### [2.0.0] - Planlanan
- QR Kod İstatistikleri
- URL Güvenlik Kontrolü
- Özel QR Kod Tasarımları
- Tema Paketleri
- Widget Desteği

---

**Notlar:**
- Semantic versioning kullanılıyor (MAJOR.MINOR.PATCH)
- Her sürüm için detaylı test yapılıyor
- Deprecated uyarılar takip ediliyor
- Kullanıcı geri bildirimleri öncelikli

**Son Güncelleme:** 14 Ekim 2025, 14:42
