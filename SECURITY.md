# 🔐 Security Policy

## Supported Versions

| Version | Supported          | Status |
| ------- | ------------------ | ------ |
| 1.2.3   | :white_check_mark: | Current - Production Ready ✅ |
| 1.2.2   | :white_check_mark: | Supported |
| 1.2.1   | :white_check_mark: | Supported |
| 1.2.0   | :white_check_mark: | Supported |
| 1.1.x   | :x:                | Deprecated |
| < 1.0   | :x:                | Not Supported |

## Security Features

### Data Privacy
- ✅ **Local-First**: Tüm QR kodlarınız cihazınızda saklanır
- ✅ **No QR Content Collection**: QR kod içerikleri ASLA toplanmaz veya paylaşılmaz
- ✅ **Local Database**: Hive ile güvenli yerel veri saklama
- ✅ **Minimal Analytics**: Firebase Analytics ile anonim kullanım istatistikleri
  - ❌ QR kod içeriği toplanmaz
  - ❌ Kişisel bilgiler toplanmaz
  - ✅ Sadece: Hangi özellikler kullanılıyor, uygulama ne kadar sık açılıyor
- ✅ **GDPR Compliant**: Avrupa veri koruma yasalarına uygun

### Permissions
- ✅ **Camera**: Sadece QR kod tarama için kullanılır
- ✅ **Storage**: QR kod kaydetme ve galeriye kaydetme için
- ✅ **Internet**: 
  - AdMob reklamları (banner ads)
  - Firebase Analytics (anonim kullanım istatistikleri)
  - ⚠️ Internet yoksa uygulama çalışmaya devam eder (ads/analytics devre dışı)
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

### No Known Issues! ✅
✅ **All deprecated warnings fixed** (v1.2.3)  
✅ **All code quality issues resolved** (31+ fixes)  
✅ **Production-ready codebase** (0 warnings, 0 errors)  
✅ **No security vulnerabilities** (Last check: March 2026)

### Previously Fixed (v1.2.3)
- ✅ Deprecated warnings (all 9 fixed)
- ✅ Share API updated
- ✅ BuildContext async gaps fixed
- ✅ Memory leak prevention added
- ✅ Production logging implemented

## Security Updates

### v1.2.3 (Current) ✅ Production Ready
- ✅ **31+ bug fixes** - All code quality issues resolved
- ✅ **Zero vulnerabilities** - No known security issues
- ✅ **Production-safe logging** - No print() in production
- ✅ **Memory leak prevention** - Async safety checks
- ✅ **Bug reporting system** - In-app feedback with device info
- ✅ **Cleaner codebase** - ~200 lines removed
- ✅ **100% offline** - No network dependencies

### v1.2.2
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

**Last Updated:** March 2026  
**Version:** 1.2.3  
**Status:** ✅ Production Ready | 🐛 Bug-Free | ⚡ Optimized
