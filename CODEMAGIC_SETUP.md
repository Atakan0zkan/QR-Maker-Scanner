# 🚀 Codemagic CI/CD Setup Guide

Codemagic ile hem iOS hem Android build'lerini otomatik alabilirsin. macOS'a ihtiyacın yok!

---

## 📋 Ön Gereksinimler

### 1. Hesaplar
- ✅ GitHub/GitLab/Bitbucket hesabı (kod repository)
- ✅ Codemagic hesabı ([codemagic.io](https://codemagic.io))
- ✅ Apple Developer Account ($99/yıl) - iOS için
- ✅ Google Play Console ($25 tek seferlik) - Android için

### 2. Dosyalar
- ✅ `codemagic.yaml` (✅ oluşturuldu)
- ⏳ Android Keystore (oluşturulacak)
- ⏳ iOS Signing Certificates (oluşturulacak)

---

## 🎯 Adım Adım Kurulum

### 1️⃣ Codemagic Hesabı Oluştur

1. [codemagic.io](https://codemagic.io) git
2. **Sign up for free** tıkla
3. GitHub/GitLab/Bitbucket ile giriş yap
4. Repository'ne erişim izni ver

**Ücretsiz Plan:**
- 500 build dakikası/ay
- Tüm özellikler açık
- Yeterli başlangıç için

---

### 2️⃣ Projeyi Ekle

1. Codemagic Dashboard > **Add application**
2. Repository seç: `qr_scanner_app`
3. **Set up build** tıkla
4. **Flutter App** seç
5. **codemagic.yaml** seç (otomatik algılanır)

---

### 3️⃣ Android Keystore Hazırla

#### A. Keystore Oluştur

```bash
keytool -genkey -v -keystore qr-scanner-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias qr-scanner
```

Detaylı talimatlar: `ANDROID_KEYSTORE_SETUP.md`

#### B. Base64'e Çevir

**Windows (PowerShell):**
```powershell
[Convert]::ToBase64String([IO.File]::ReadAllBytes("qr-scanner-keystore.jks")) | Out-File keystore-base64.txt
```

**macOS/Linux:**
```bash
base64 -i qr-scanner-keystore.jks -o keystore-base64.txt
```

#### C. Codemagic'e Yükle

1. Codemagic > Your App > **Settings**
2. **Code signing identities** > **Android**
3. **Upload keystore** tıkla
4. Bilgileri gir:
   - **Keystore**: `keystore-base64.txt` içeriğini yapıştır
   - **Keystore password**: Keystore şifreni gir
   - **Key alias**: `qr-scanner`
   - **Key password**: Key şifreni gir
   - **Reference name**: `qr_scanner_keystore`

---

### 4️⃣ iOS Signing Hazırla

#### A. Apple Developer Portal

1. [developer.apple.com](https://developer.apple.com) giriş yap
2. **Certificates, IDs & Profiles** git

#### B. App ID Oluştur

1. **Identifiers** > **+**
2. **App IDs** seç
3. **Description**: QR Scanner
4. **Bundle ID**: `com.aozka.qrscannerapp` (Explicit)
5. **Capabilities**: Camera, Photo Library
6. **Register**

#### C. Codemagic ile Otomatik Signing (Önerilen)

1. Codemagic > Your App > **Settings**
2. **Code signing identities** > **iOS**
3. **Automatic code signing** seç
4. **Connect Apple Developer Portal**
5. Apple ID ve App-Specific Password gir
6. Bundle ID seç: `com.aozka.qrscannerapp`
7. **Fetch signing files** tıkla

Codemagic otomatik olarak:
- Certificate oluşturur
- Provisioning Profile oluşturur
- Her build'de günceller

---

### 5️⃣ Google Play Console Setup (Opsiyonel)

#### A. Service Account Oluştur

1. [console.cloud.google.com](https://console.cloud.google.com)
2. Yeni proje oluştur: "QR Scanner"
3. **APIs & Services** > **Credentials**
4. **Create Credentials** > **Service Account**
5. İsim: `codemagic-publisher`
6. **Create and Continue**
7. Role: **Service Account User**
8. **Done**

#### B. JSON Key İndir

1. Service Account'a tıkla
2. **Keys** sekmesi > **Add Key** > **Create new key**
3. **JSON** seç
4. İndir (örn: `service-account.json`)

#### C. Google Play Console'da İzin Ver

1. [play.google.com/console](https://play.google.com/console)
2. **Setup** > **API access**
3. Service Account'u bul
4. **Grant access**
5. İzinler:
   - **Releases**: View, Create, Edit
   - **App access**: View
6. **Invite user**

#### D. Codemagic'e Ekle

1. Codemagic > Your App > **Settings**
2. **Environment variables** > **Add variable**
3. **Variable name**: `GCLOUD_SERVICE_ACCOUNT_CREDENTIALS`
4. **Variable value**: `service-account.json` içeriğini yapıştır
5. **Secure** işaretle
6. **Add**

---

### 6️⃣ App Store Connect Setup (Opsiyonel)

#### A. App-Specific Password Oluştur

1. [appleid.apple.com](https://appleid.apple.com) giriş yap
2. **Security** > **App-Specific Passwords**
3. **Generate Password**
4. İsim: `Codemagic`
5. Password'u kopyala (bir daha gösterilmez!)

#### B. Codemagic'e Ekle

1. Codemagic > Your App > **Settings**
2. **Integrations** > **App Store Connect**
3. **Enable App Store Connect integration**
4. Apple ID: developer@example.com
5. App-Specific Password: [KOPYALADIĞIN PASSWORD]
6. **Save**

#### C. App Store Connect'te App Oluştur

1. [appstoreconnect.apple.com](https://appstoreconnect.apple.com)
2. **My Apps** > **+** > **New App**
3. **Platform**: iOS
4. **Name**: QR Scanner
5. **Primary Language**: Turkish
6. **Bundle ID**: com.aozka.qrscannerapp
7. **SKU**: qrscannerapp-001
8. **Create**

---

### 7️⃣ Environment Variables

Codemagic > Your App > **Settings** > **Environment variables**

#### Android Variables
```
PACKAGE_NAME = com.aozka.qrscannerapp
```

#### iOS Variables
```
APP_ID = [APP_STORE_CONNECT_APP_ID]
BUNDLE_ID = com.aozka.qrscannerapp
```

#### Email Notifications
```
EMAIL = your-email@example.com
```

---

### 8️⃣ codemagic.yaml Güncelle

Proje root'unda `codemagic.yaml` dosyası var. Güncelle:

```yaml
# Email adresini değiştir
email:
  recipients:
    - your-email@example.com  # ← BURAYA KENDİ EMAİLİNİ YAZ

# iOS App ID'yi değiştir
vars:
  APP_ID: 1234567890  # ← APP STORE CONNECT'TEN AL
```

---

### 9️⃣ Git Push

```bash
git add .
git commit -m "Add Codemagic CI/CD configuration"
git push origin main
```

---

### 🔟 İlk Build'i Başlat

1. Codemagic Dashboard > Your App
2. **Start new build** tıkla
3. **Workflow** seç:
   - `android-workflow` - Sadece Android
   - `ios-workflow` - Sadece iOS
   - `all-platforms-workflow` - Her ikisi
4. **Branch** seç: `main`
5. **Start new build**

Build süresi: ~15-30 dakika (ilk build daha uzun)

---

## 📊 Workflow'lar

### 1. android-workflow
- Sadece Android build
- APK ve AAB oluşturur
- Google Play'e yükler (internal track)

### 2. ios-workflow
- Sadece iOS build
- IPA oluşturur
- TestFlight'a yükler

### 3. all-platforms-workflow
- Hem Android hem iOS
- Her ikisini de yükler
- Otomatik trigger:
  - `main` branch'e push
  - `release/*` branch'e push
  - `v*` tag oluşturma

---

## 🎨 Build Artifacts

Build tamamlandığında şunları indirebilirsin:

### Android
- `app-release.apk` - Direkt kurulabilir
- `app-release.aab` - Google Play için
- `mapping.txt` - ProGuard mapping

### iOS
- `Runner.ipa` - App Store/TestFlight için

---

## 🔔 Bildirimler

### Email
Her build'de email alırsın:
- ✅ Build başarılı
- ❌ Build başarısız
- 📦 Artifact linkleri

### Slack (Opsiyonel)
1. Codemagic > Settings > **Integrations**
2. **Slack** > **Enable**
3. Webhook URL ekle

---

## 🐛 Yaygın Hatalar

### "Keystore not found"
**Çözüm:** Codemagic'te keystore'u doğru yükledin mi kontrol et.

### "iOS signing failed"
**Çözüm:** 
1. Apple Developer Portal'da Bundle ID doğru mu?
2. Codemagic'te Apple ID ve password doğru mu?
3. **Fetch signing files** tekrar dene

### "Build timeout"
**Çözüm:** 
1. `max_build_duration` artır (60 → 90)
2. Gereksiz dependency'leri kaldır

### "Flutter version mismatch"
**Çözüm:** `codemagic.yaml`'da Flutter version belirt:
```yaml
environment:
  flutter: 3.24.0  # Spesifik version
```

---

## 📈 Build Optimizasyonu

### Cache Kullan
```yaml
cache:
  cache_paths:
    - $HOME/.gradle/caches
    - $HOME/Library/Caches/CocoaPods
```

### Paralel Build
```yaml
instance_type: mac_pro  # Daha hızlı (ücretli)
```

### Conditional Build
```yaml
when:
  changeset:
    includes:
      - 'lib/**'
      - 'android/**'
      - 'ios/**'
    excludes:
      - '**/*.md'
```

---

## 🎯 Production Checklist

### Android
- [ ] Keystore oluşturuldu
- [ ] Codemagic'e yüklendi
- [ ] Google Play Console service account
- [ ] `codemagic.yaml` güncellendi
- [ ] Test build başarılı

### iOS
- [ ] Apple Developer Account ($99)
- [ ] Bundle ID oluşturuldu
- [ ] Codemagic automatic signing
- [ ] App Store Connect app oluşturuldu
- [ ] App-Specific Password
- [ ] Test build başarılı

### Genel
- [ ] `codemagic.yaml` commit edildi
- [ ] Email adresi güncellendi
- [ ] Environment variables eklendi
- [ ] Git push yapıldı
- [ ] İlk build başarılı

---

## 📚 Kaynaklar

### Dokümantasyon
- [Codemagic Docs](https://docs.codemagic.io/)
- [Flutter CI/CD](https://docs.flutter.dev/deployment/cd)
- [ANDROID_KEYSTORE_SETUP.md](./ANDROID_KEYSTORE_SETUP.md)

### Video Tutorials
- [Codemagic Flutter Setup](https://www.youtube.com/watch?v=...)
- [iOS Signing with Codemagic](https://www.youtube.com/watch?v=...)

### Support
- [Codemagic Slack](https://codemagic.slack.com)
- [Codemagic Support](https://codemagic.io/support)

---

## 💰 Pricing

### Free Plan
- 500 build dakikası/ay
- Tüm özellikler
- Unlimited apps
- **Yeterli başlangıç için!**

### Pro Plan ($99/ay)
- 2000 build dakikası/ay
- Daha hızlı makineler
- Priority support

### Enterprise
- Custom pricing
- Dedicated resources
- SLA

---

## 🚀 Hızlı Başlangıç Özeti

```bash
# 1. Keystore oluştur
keytool -genkey -v -keystore qr-scanner-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias qr-scanner

# 2. Base64'e çevir
[Convert]::ToBase64String([IO.File]::ReadAllBytes("qr-scanner-keystore.jks")) | Out-File keystore-base64.txt

# 3. Git push
git add .
git commit -m "Add Codemagic configuration"
git push origin main

# 4. Codemagic'te:
# - Keystore yükle
# - iOS signing kur
# - Build başlat
```

---

## ✅ Sonuç

Codemagic ile:
- ✅ macOS'a ihtiyaç yok
- ✅ Otomatik build
- ✅ Otomatik deploy
- ✅ Her platform için
- ✅ Ücretsiz başlangıç

**Sonraki Adım:** Keystore oluştur ve Codemagic'e yükle! 🚀

---

**Güncelleme:** 14 Ekim 2025  
**Versiyon:** 1.2.0+2
