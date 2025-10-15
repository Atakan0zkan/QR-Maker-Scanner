# 🔐 Security Policy

## Supported Versions

| Version | Supported          | Status |
| ------- | ------------------ | ------ |
| 1.2.2   | :white_check_mark: | Current - Production Ready |
| 1.2.1   | :white_check_mark: | Supported |
| 1.2.0   | :white_check_mark: | Supported |
| 1.1.x   | :x:                | Deprecated |
| < 1.0   | :x:                | Not Supported |

## Security Features

### Data Privacy
- ✅ **%100 Offline**: Uygulama tamamen çevrimdışı çalışır, internet gerektirmez
- ✅ **No Cloud Storage**: Kullanıcı verileri bulutta saklanmaz
- ✅ **Local Database**: Hive ile güvenli yerel veri saklama (encryption)
- ✅ **No Analytics**: Kullanıcı davranışları izlenmez
- ✅ **No Tracking**: Hiçbir kullanıcı verisi toplanmaz veya paylaşılmaz

### Permissions
- ✅ **Camera Only**: Sadece QR kod tarama için kullanılır
- ✅ **Storage (Optional)**: Sadece QR kod kaydetme için kullanılır
- ✅ **Internet (Optional)**: Sadece AdMob reklamları için (opsiyonel)
- ✅ **No Location**: Konum izni ASLA istenmez
- ✅ **No Contacts**: Kişi listesine erişim yok
- ✅ **No Phone**: Telefon özelliklerine erişim yok

### Code Security
- ✅ **No Hardcoded Secrets**: API keys environment variables'da
- ✅ **Secure Storage**: Hassas veriler şifrelenir
- ✅ **Input Validation**: Tüm kullanıcı girdileri valide edilir
- ✅ **Safe URL Handling**: URL'ler güvenli şekilde açılır

## Reporting a Vulnerability

Güvenlik açığı bulursanız lütfen **hemen** bildirin:

### Bildirme Yöntemi
1. **GitHub Issues kullanmayın** (public görünür)
2. Email gönderin: [GitHub Profile](https://github.com/Atakan0zkan)
3. Veya GitHub Security Advisory kullanın: [Security Advisories](https://github.com/Atakan0zkan/QR-Maker-Scanner/security/advisories)

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
- Deprecated warnings (9 adet) - Kritik değil, çalışıyor
- Share API deprecated - Yeni versiyonda güncellenecek
- RadioListTile deprecated - Flutter SDK güncellemesinde düzelecek

### No Known Security Issues
✅ Bilinen güvenlik açığı yok (Son kontrol: 15 Ekim 2025)

## Security Updates

### v1.2.2 (Current)
- ✅ Network monitoring kaldırıldı (gereksiz)
- ✅ %100 offline çalışma garantisi
- ✅ Minimal izin yapısı
- ✅ Temiz codebase (-130 satır)

### v1.2.1
- ✅ Renkli QR kod özelliği
- ✅ Deprecated uyarıları düzeltildi
- ✅ Güvenli renk seçimi

### v1.2.0
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

### Google AdMob (Optional)
- **Purpose**: Display ads (opsiyonel, internet gerektirmez)
- **Data Collected**: Device info, ad interaction (sadece reklam görüntülenirse)
- **Privacy Policy**: [Google AdMob Privacy](https://support.google.com/admob/answer/6128543)
- **Note**: Reklam görünmese bile uygulama tam özellikli çalışır

### No Other Services
- ✅ No analytics (hiçbir analitik servisi yok)
- ✅ No crash reporting (crash raporlama yok)
- ✅ No cloud storage (bulut depolama yok)
- ✅ No user accounts (kullanıcı hesabı yok)
- ✅ No network monitoring (ağ izleme yok)

## Contact

For security concerns:
- **GitHub:** [@Atakan0zkan](https://github.com/Atakan0zkan)
- **Repository:** [QR-Maker-Scanner](https://github.com/Atakan0zkan/QR-Maker-Scanner)
- **Security Advisories:** [Report Vulnerability](https://github.com/Atakan0zkan/QR-Maker-Scanner/security/advisories)

## Additional Resources

- [Privacy Policy](https://github.com/Atakan0zkan/QR-Maker-Scanner/blob/main/PRIVACY_POLICY.md)
- [Terms of Service](https://github.com/Atakan0zkan/QR-Maker-Scanner/blob/main/TERMS_OF_SERVICE.md)
- [CHANGELOG](https://github.com/Atakan0zkan/QR-Maker-Scanner/blob/main/CHANGELOG.md)

---

**Last Updated:** October 15, 2025  
**Version:** 1.2.2  
**Status:** ✅ Production Ready
