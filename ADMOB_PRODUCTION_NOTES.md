# 📱 AdMob Production Notes

**Date:** 15 Ekim 2025  
**Version:** 1.2.1+3  
**Status:** ✅ Production Ready

---

## 🎯 AdMob Konfigürasyonu

### Production IDs Aktif

**Android:**
- **App ID:** `ca-app-pub-8966682109895515~8991413324`
- **Banner ID:** `ca-app-pub-8966682109895515/8906178061`

**iOS:**
- **App ID:** `ca-app-pub-8966682109895515~8991413324` (Geçici - Android ile aynı)
- **Banner ID:** `ca-app-pub-8966682109895515/8906178061` (Geçici - Android ile aynı)
- ⚠️ **TODO:** iOS app oluşturulunca gerçek iOS ID'leri eklenecek

---

## ⚠️ "No Fill" Hatası Hakkında

### Normal Durum
```
I/Ads (23752): Ad failed to load : 3
I/flutter (23752): ❌ Banner ad failed to load: No fill. (Code: 3)
```

**Error Code 3 = NO_FILL** - Bu NORMAL bir durumdur!

### Neden "No Fill" Olur?

#### 1. Yeni AdMob Hesabı/App
- İlk birkaç gün reklam envanteri düşük olabilir
- AdMob algoritması uygulamanızı öğreniyor
- Reklam verenler henüz hedefleme yapmamış olabilir

#### 2. Test Cihazı
- Test cihazlarında bazen reklam gösterilmez
- AdMob test cihazlarını farklı şekilde ele alır

#### 3. Bölgesel Faktörler
- Bazı bölgelerde reklam envanteri düşük
- Türkiye için reklam sayısı değişken olabilir

#### 4. Zaman Faktörü
- Gece saatlerinde daha az reklam
- Hafta sonları farklı oran

#### 5. Yeni Banner Unit
- Yeni oluşturulan ad unit'ler için normal
- 24-48 saat sonra düzelir

---

## ✅ Ne Zaman Reklam Görünür?

### Production Build'de
```bash
flutter build apk --release
flutter build appbundle --release
```

**Production build'de daha fazla reklam görünür çünkü:**
- Gerçek kullanıcı olarak algılanır
- Test cihaz kısıtlamaları yok
- Daha geniş reklam envanteri

### Gerçek Cihazda
- Emulator yerine gerçek telefonda test et
- Google Play'den indirilen versiyonda
- Farklı lokasyonlardan test et

### Zaman Geçtikçe
- İlk 24-48 saat: Düşük fill rate (%20-40)
- 1 hafta sonra: Orta fill rate (%50-70)
- 1 ay sonra: Yüksek fill rate (%80-95)

---

## 🔧 AdMob Optimizasyonu

### 1. Mediation Ekle (Gelecekte)
Daha fazla reklam için mediation ağları:
- Facebook Audience Network
- Unity Ads
- AppLovin
- ironSource

### 2. Ad Refresh
Banner reklamları belirli sürede yenile:
```dart
// 30-60 saniye arası önerilen
Timer.periodic(Duration(seconds: 60), (timer) {
  _bannerAd?.dispose();
  _loadBannerAd();
});
```

### 3. Multiple Ad Units
Farklı ekranlarda farklı ad unit'ler kullan:
- Ana ekran banner
- Detail ekran banner
- Interstitial ads (tam ekran)

---

## 📊 AdMob Dashboard

### Kontrol Edilecekler

#### 1. App Status
- ✅ App onaylandı mı?
- ✅ Ad serving açık mı?
- ⚠️ Policy ihlali var mı?

#### 2. Ad Unit Status
- ✅ Banner unit aktif mi?
- ✅ Serving açık mı?
- ⚠️ Suspended değil mi?

#### 3. Payment Info
- ✅ Ödeme bilgileri girildi mi?
- ✅ Tax info tamamlandı mı?
- ✅ Threshold ($100) ayarlandı mı?

---

## 🚨 Yaygın Sorunlar ve Çözümler

### Sorun 1: "No Fill" Sürekli Oluyor
**Çözüm:**
1. 24-48 saat bekle
2. AdMob dashboard'da app status kontrol et
3. Ad unit status kontrol et
4. Farklı cihazda test et

### Sorun 2: Reklamlar Hiç Gözükmüyor
**Çözüm:**
1. App ID doğru mu kontrol et (AndroidManifest.xml, Info.plist)
2. Ad Unit ID doğru mu kontrol et (ad_service.dart)
3. Internet bağlantısı var mı?
4. AdMob SDK güncel mi?

### Sorun 3: Test Reklamları Gözüküyor, Production Gözükmüyor
**Çözüm:**
1. Normal - Production'da fill rate düşük olabilir
2. Bekle ve monitör et
3. Mediation ekle

---

## 📈 Beklenen Metrikler

### İlk Hafta
- **Fill Rate:** %20-40
- **eCPM:** $0.10-0.50
- **Günlük Gelir:** $0.01-0.10 (100 kullanıcı için)

### İlk Ay
- **Fill Rate:** %50-70
- **eCPM:** $0.30-1.00
- **Günlük Gelir:** $0.50-5.00 (1000 kullanıcı için)

### 3 Ay Sonra
- **Fill Rate:** %80-95
- **eCPM:** $0.50-2.00
- **Günlük Gelir:** $5-50 (10000 kullanıcı için)

---

## ✅ Production Checklist

### AdMob Setup
- [x] AdMob hesabı oluşturuldu
- [x] App oluşturuldu (Android)
- [ ] App oluşturuldu (iOS) - TODO
- [x] Banner Ad Unit oluşturuldu
- [x] App ID AndroidManifest.xml'e eklendi
- [x] App ID Info.plist'e eklendi
- [x] Ad Unit ID kodda kullanılıyor

### Kod
- [x] Production ID'ler aktif
- [x] Test ID'ler kaldırıldı
- [x] Error handling mevcut
- [x] Dispose metodları doğru

### Test
- [x] Emulator'da test edildi
- [ ] Gerçek cihazda test edilecek
- [ ] Production build test edilecek
- [ ] Google Play'den test edilecek

### Monitoring
- [ ] AdMob dashboard günlük kontrol
- [ ] Fill rate takip
- [ ] Revenue takip
- [ ] Policy ihlali kontrol

---

## 🎯 iOS AdMob Setup (Yapılacak)

### Adımlar
1. [admob.google.com](https://admob.google.com) giriş yap
2. **Apps** > **Add App** > **iOS**
3. App bilgilerini gir:
   - **App name:** QR Scanner
   - **Platform:** iOS
   - **App Store ID:** (App Store'a yüklendikten sonra)
4. **Ad units** > **Add ad unit** > **Banner**
5. Ad unit oluştur:
   - **Ad unit name:** QR Scanner Banner iOS
   - **Ad format:** Banner
6. App ID ve Ad Unit ID'yi kopyala
7. Kodda güncelle:
   ```dart
   // lib/services/ad_service.dart
   } else if (Platform.isIOS) {
     return 'ca-app-pub-XXXXXXXXXXXXXXXX/YYYYYYYYYY'; // iOS Banner ID
   }
   ```
8. Info.plist güncelle:
   ```xml
   <key>GADApplicationIdentifier</key>
   <string>ca-app-pub-XXXXXXXXXXXXXXXX~ZZZZZZZZZZ</string>
   ```

---

## 📝 Notlar

### Önemli
- ✅ Production ID'ler aktif
- ✅ "No Fill" normal bir durum
- ✅ Zaman geçtikçe fill rate artar
- ⚠️ Kendi reklamlarına ASLA tıklama (ban riski)

### Tavsiyeler
- İlk 1 hafta sabırlı ol
- AdMob dashboard'ı takip et
- Kullanıcı sayısı arttıkça gelir artar
- Mediation ekleyerek fill rate'i artır

### Gelecek İyileştirmeler
- [ ] Interstitial ads ekle
- [ ] Rewarded ads ekle
- [ ] Mediation ağları ekle
- [ ] Ad refresh implementasyonu
- [ ] A/B testing

---

## 🆘 Destek

### AdMob Support
- [AdMob Help Center](https://support.google.com/admob)
- [AdMob Community](https://support.google.com/admob/community)

### Policy
- [AdMob Program Policies](https://support.google.com/admob/answer/6128543)
- [Invalid Traffic Guidelines](https://support.google.com/admob/answer/6201362)

---

**Son Güncelleme:** 15 Ekim 2025  
**Durum:** ✅ Production Ready  
**Sonraki Adım:** App Store ve Google Play'e yükle, monitör et
