# ✅ Codemagic Setup Checklist

Tüm adımları sırayla takip et!

---

## 🎯 Hızlı Başlangıç (30 dakika)

### 1. Hesap ve Proje (5 dakika)
- [ ] [codemagic.io](https://codemagic.io) hesap oluştur
- [ ] GitHub/GitLab ile bağlan
- [ ] `qr_scanner_app` projesini ekle
- [ ] `codemagic.yaml` dosyasını tanı

### 2. Android Keystore (10 dakika)
- [ ] Keystore oluştur:
  ```bash
  keytool -genkey -v -keystore qr-scanner-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias qr-scanner
  ```
- [ ] Bilgileri kaydet:
  - Keystore şifresi: `__________`
  - Key alias: `qr-scanner`
  - Key şifresi: `__________`
- [ ] Base64'e çevir:
  ```powershell
  [Convert]::ToBase64String([IO.File]::ReadAllBytes("qr-scanner-keystore.jks")) | Out-File keystore-base64.txt
  ```
- [ ] Codemagic'e yükle:
  - Settings > Code signing > Android > Upload keystore
  - Reference name: `qr_scanner_keystore`

### 3. iOS Signing (10 dakika)
- [ ] Apple Developer Account var mı? ($99/yıl)
- [ ] [developer.apple.com](https://developer.apple.com) > Certificates, IDs & Profiles
- [ ] App ID oluştur:
  - Bundle ID: `com.aozka.qrscannerapp`
  - Capabilities: Camera, Photo Library
- [ ] Codemagic'te automatic signing:
  - Settings > Code signing > iOS > Automatic
  - Apple ID ve App-Specific Password gir
  - Fetch signing files

### 4. codemagic.yaml Güncelle (5 dakika)
- [ ] Email adresini değiştir:
  ```yaml
  email:
    recipients:
      - your-email@example.com  # ← KENDİ EMAİLİN
  ```
- [ ] Bundle ID kontrol et:
  ```yaml
  bundle_identifier: com.aozka.qrscannerapp  # ← DOĞRU MU?
  ```

### 5. Git Push ve Build (5 dakika)
- [ ] Git commit:
  ```bash
  git add .
  git commit -m "Add Codemagic CI/CD"
  git push origin main
  ```
- [ ] Codemagic'te build başlat:
  - Dashboard > Start new build
  - Workflow: `android-workflow` (ilk test için)
  - Branch: `main`
  - Start!

---

## 📋 Detaylı Checklist

### A. Ön Hazırlık
- [ ] Flutter SDK kurulu
- [ ] Git repository hazır (GitHub/GitLab/Bitbucket)
- [ ] `codemagic.yaml` dosyası commit edildi
- [ ] Apple Developer Account ($99/yıl) - iOS için
- [ ] Google Play Console ($25) - Android için

### B. Codemagic Hesap
- [ ] [codemagic.io](https://codemagic.io) kayıt
- [ ] Repository bağlantısı
- [ ] Proje eklendi
- [ ] Free plan aktif (500 dakika/ay)

### C. Android Setup
- [ ] Keystore oluşturuldu
- [ ] Keystore bilgileri kaydedildi
- [ ] Base64'e çevrildi
- [ ] Codemagic'e yüklendi
- [ ] Reference name: `qr_scanner_keystore`
- [ ] Test build başarılı

### D. iOS Setup
- [ ] Apple Developer Account aktif
- [ ] Bundle ID oluşturuldu: `com.aozka.qrscannerapp`
- [ ] App ID capabilities eklendi (Camera, Photo Library)
- [ ] App-Specific Password oluşturuldu
- [ ] Codemagic automatic signing kuruldu
- [ ] Signing files fetch edildi
- [ ] Test build başarılı

### E. Google Play Console (Opsiyonel - Otomatik Deploy)
- [ ] Google Cloud Project oluşturuldu
- [ ] Service Account oluşturuldu
- [ ] JSON key indirildi
- [ ] Google Play Console'da izin verildi
- [ ] Codemagic'e environment variable eklendi:
  - `GCLOUD_SERVICE_ACCOUNT_CREDENTIALS`

### F. App Store Connect (Opsiyonel - Otomatik Deploy)
- [ ] App Store Connect'te app oluşturuldu
- [ ] App ID alındı
- [ ] App-Specific Password oluşturuldu
- [ ] Codemagic integration kuruldu
- [ ] TestFlight beta group oluşturuldu

### G. Environment Variables
- [ ] `PACKAGE_NAME` = `com.aozka.qrscannerapp`
- [ ] `BUNDLE_ID` = `com.aozka.qrscannerapp`
- [ ] `APP_ID` = `[APP_STORE_CONNECT_APP_ID]`
- [ ] `EMAIL` = `your-email@example.com`
- [ ] `GCLOUD_SERVICE_ACCOUNT_CREDENTIALS` (opsiyonel)

### H. codemagic.yaml Konfigürasyonu
- [ ] Email adresi güncellendi
- [ ] Bundle ID doğru
- [ ] Package name doğru
- [ ] Workflow'lar seçildi:
  - [ ] `android-workflow`
  - [ ] `ios-workflow`
  - [ ] `all-platforms-workflow`
- [ ] Trigger'lar ayarlandı (branch, tag)

### I. İlk Build
- [ ] Git push yapıldı
- [ ] Codemagic'te build başlatıldı
- [ ] Android build başarılı
- [ ] iOS build başarılı
- [ ] Artifacts indirildi ve test edildi

### J. Test
- [ ] APK indirildi ve kuruldu
- [ ] IPA TestFlight'a yüklendi
- [ ] Tüm özellikler test edildi:
  - [ ] QR kod tarama
  - [ ] QR kod oluşturma
  - [ ] Toplu tarama
  - [ ] Toplu işlemler
  - [ ] Çevrimdışı mod
  - [ ] Tema değiştirme
  - [ ] Dil değiştirme

---

## 🚨 Kritik Bilgiler (KAYDET!)

### Android Keystore
```
Dosya: qr-scanner-keystore.jks
Keystore Şifresi: ________________
Key Alias: qr-scanner
Key Şifresi: ________________
```

### iOS
```
Apple ID: ________________
App-Specific Password: ________________
Bundle ID: com.aozka.qrscannerapp
Team ID: ________________
```

### Codemagic
```
Email: ________________
Password: ________________
```

---

## 📊 Build Durumu

### Android
- [ ] İlk build: ⏳ Bekliyor / ✅ Başarılı / ❌ Başarısız
- [ ] APK test: ⏳ Bekliyor / ✅ Başarılı / ❌ Başarısız
- [ ] AAB test: ⏳ Bekliyor / ✅ Başarılı / ❌ Başarısız
- [ ] Google Play upload: ⏳ Bekliyor / ✅ Başarılı / ❌ Başarısız

### iOS
- [ ] İlk build: ⏳ Bekliyor / ✅ Başarılı / ❌ Başarısız
- [ ] IPA test: ⏳ Bekliyor / ✅ Başarılı / ❌ Başarısız
- [ ] TestFlight upload: ⏳ Bekliyor / ✅ Başarılı / ❌ Başarısız
- [ ] App Store submit: ⏳ Bekliyor / ✅ Başarılı / ❌ Başarısız

---

## 🎯 Sonraki Adımlar

### Kısa Vadeli (1 hafta)
- [ ] İlk build'leri al
- [ ] Test et
- [ ] Hataları düzelt
- [ ] Otomatik deploy kur

### Orta Vadeli (1 ay)
- [ ] TestFlight beta test
- [ ] Google Play internal test
- [ ] Kullanıcı geri bildirimleri
- [ ] Güncelleme yayınla

### Uzun Vadeli (3 ay)
- [ ] App Store production
- [ ] Google Play production
- [ ] Marketing
- [ ] Kullanıcı desteği

---

## 📚 Kaynaklar

- [CODEMAGIC_SETUP.md](./CODEMAGIC_SETUP.md) - Detaylı setup rehberi
- [ANDROID_KEYSTORE_SETUP.md](./ANDROID_KEYSTORE_SETUP.md) - Keystore oluşturma
- [IOS_DEPLOYMENT_GUIDE.md](./IOS_DEPLOYMENT_GUIDE.md) - iOS deployment
- [Codemagic Docs](https://docs.codemagic.io/)

---

## ✅ Tamamlanma Durumu

**Toplam:** 0 / 50 ✅

**İlerleme:**
- Ön Hazırlık: 0 / 5
- Codemagic Hesap: 0 / 4
- Android Setup: 0 / 6
- iOS Setup: 0 / 7
- Google Play: 0 / 5
- App Store: 0 / 5
- Environment Variables: 0 / 5
- codemagic.yaml: 0 / 5
- İlk Build: 0 / 4
- Test: 0 / 4

**Başlangıç:** ___/___/2025  
**Bitiş:** ___/___/2025  
**Süre:** ___ gün

---

**Başarılar! 🚀**
