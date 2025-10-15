# 🔐 Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.2.x   | :white_check_mark: |
| 1.1.x   | :x:                |
| < 1.0   | :x:                |

## Security Features

### Data Privacy
- ✅ **Offline-First**: Uygulama çevrimdışı çalışır, veriler cihazda saklanır
- ✅ **No Cloud Storage**: Kullanıcı verileri bulutta saklanmaz
- ✅ **Local Database**: Hive ile güvenli yerel veri saklama
- ✅ **No Analytics**: Kullanıcı davranışları izlenmez

### Permissions
- ✅ **Camera**: Sadece QR kod tarama için kullanılır
- ✅ **Photo Library**: Sadece QR kod kaydetme için kullanılır
- ✅ **Network**: Sadece AdMob reklamları için kullanılır
- ✅ **No Location**: Konum izni istenmez

### Code Security
- ✅ **No Hardcoded Secrets**: API keys environment variables'da
- ✅ **Secure Storage**: Hassas veriler şifrelenir
- ✅ **Input Validation**: Tüm kullanıcı girdileri valide edilir
- ✅ **Safe URL Handling**: URL'ler güvenli şekilde açılır

## Reporting a Vulnerability

Güvenlik açığı bulursanız lütfen **hemen** bildirin:

### Bildirme Yöntemi
1. **GitHub Issues kullanmayın** (public görünür)
2. Email gönderin: [security@yourcompany.com](mailto:security@yourcompany.com)
3. Veya GitHub Security Advisory kullanın

### Bildirimde Bulunması Gerekenler
- Açığın detaylı açıklaması
- Reproduce adımları
- Etkilenen versiyon
- Olası çözüm önerileri (varsa)

### Yanıt Süresi
- **24 saat** içinde ilk yanıt
- **7 gün** içinde değerlendirme
- **30 gün** içinde düzeltme (kritik açıklar için daha hızlı)

## Security Best Practices

### For Developers
```bash
# 1. Environment variables kullan
cp .env.example .env
# .env dosyasını ASLA commit etme!

# 2. Dependencies güncel tut
flutter pub outdated
flutter pub upgrade

# 3. Security audit çalıştır
flutter analyze
dart analyze

# 4. Keystore güvenli sakla
# *.jks dosyalarını ASLA commit etme!
```

### For Users
- ✅ Sadece resmi kaynaklardan indirin (Google Play, App Store)
- ✅ İzinleri kontrol edin
- ✅ Uygulamayı güncel tutun
- ✅ Şüpheli QR kodları taramayın

## Known Issues

### Non-Security Issues
- Deprecated warnings (12 adet) - Kritik değil, çalışıyor
- Share API deprecated - Yeni versiyonda güncellenecek

### No Known Security Issues
✅ Bilinen güvenlik açığı yok

## Security Updates

### v1.2.0 (Current)
- ✅ Environment variables support
- ✅ Improved permission handling
- ✅ Secure offline storage
- ✅ Input validation

### v1.1.0
- ✅ AdMob integration
- ✅ Privacy policy
- ✅ Terms of service

## Compliance

### GDPR
- ✅ No personal data collection
- ✅ No data sharing with third parties
- ✅ User data stays on device
- ✅ Right to delete (clear app data)

### COPPA
- ✅ No data collection from children
- ✅ No targeted advertising
- ✅ No location tracking

## Third-Party Services

### Google AdMob
- **Purpose**: Display ads
- **Data Collected**: Device info, ad interaction
- **Privacy Policy**: [Google AdMob Privacy](https://support.google.com/admob/answer/6128543)

### No Other Services
- ✅ No analytics
- ✅ No crash reporting
- ✅ No cloud storage
- ✅ No user accounts

## Contact

For security concerns:
- Email: security@yourcompany.com
- GitHub: [@Atakan0zkan](https://github.com/Atakan0zkan)

---

**Last Updated:** October 14, 2025  
**Version:** 1.2.0
