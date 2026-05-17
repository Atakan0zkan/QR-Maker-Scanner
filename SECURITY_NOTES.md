# Güvenlik Notları

Bu dosya, uygulamanın güvenlik konfigürasyonları hakkında önemli bilgiler içerir.

## 1. Firebase API Anahtarları

`lib/firebase_options.dart` dosyasındaki Firebase API anahtarları FlutterFire CLI tarafından otomatik oluşturulmaktadır.

### Gerekli Kısıtlamalar (Google Cloud Console)

Firebase API anahtarlarını korumak için aşağıdaki kısıtlamaları uygulayın:

1. [Google Cloud Console](https://console.cloud.google.com/apis/credentials) adresine gidin
2. İlgili API anahtarını seçin
3. **Application Restrictions** bölümünde:

   **Android için:**
   - Android apps seçin
   - Package name: `com.aozka.qrscannerapp`
   - SHA-1 sertifika parmak izini ekleyin

   **iOS için:**
   - iOS apps seçin
   - Bundle ID: `com.qrscanner.qrScannerApp`

4. **API Restrictions** bölümünde sadece gerekli API'leri etkinleştirin:
   - Firebase Installations API
   - Firebase Cloud Messaging API
   - Firebase Analytics API

## 2. Hive Veritabanı Şifreleme

Uygulama `HiveAesCipher` kullanarak tüm yerel verileri şifreler:

- Şifreleme anahtarı `flutter_secure_storage` ile güvenli bir şekilde saklanır
- Android: EncryptedSharedPreferences kullanılır
- iOS: Keychain ile korunur

## 3. Codemagic CI/CD

E-posta bildirimleri için ortam değişkeni kullanılmaktadır:

```yaml
recipients:
  - $BUILD_NOTIFY_EMAIL
```

### Kurulum

Codemagic'te bu değişkeni ayarlamak için:
1. Codemagic Dashboard'a gidin
2. App settings → Environment variables
3. `BUILD_NOTIFY_EMAIL` değişkenini ekleyin
4. Değer: `atakanozkan2001@gmail.com`

---

**Son Güncelleme:** Ocak 2026
