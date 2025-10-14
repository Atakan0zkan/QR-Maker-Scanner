# 🔐 Android Keystore Setup

Android uygulamanı imzalamak için keystore dosyası oluşturman gerekiyor.

---

## 📝 Keystore Oluşturma

### Windows'ta
```bash
keytool -genkey -v -keystore qr-scanner-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias qr-scanner
```

### macOS/Linux'ta
```bash
keytool -genkey -v -keystore ~/qr-scanner-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias qr-scanner
```

---

## ❓ Sorular ve Cevaplar

Komut çalıştırınca şu soruları soracak:

```
Enter keystore password: [ŞİFRE GİR - EN AZ 6 KARAKTER]
Re-enter new password: [ŞİFREYİ TEKRAR GİR]

What is your first and last name?
  [Unknown]:  Ahmet Ozkan (veya şirket adın)

What is the name of your organizational unit?
  [Unknown]:  Development

What is the name of your organization?
  [Unknown]:  Your Company Name

What is the name of your City or Locality?
  [Unknown]:  Istanbul

What is the name of your State or Province?
  [Unknown]:  Istanbul

What is the two-letter country code for this unit?
  [Unknown]:  TR

Is CN=Ahmet Ozkan, OU=Development, O=Your Company Name, L=Istanbul, ST=Istanbul, C=TR correct?
  [no]:  yes

Enter key password for <qr-scanner>
	(RETURN if same as keystore password): [ENTER BAS - AYNI ŞİFRE]
```

---

## 📋 Önemli Bilgiler (KAYDET!)

Keystore oluşturduktan sonra şu bilgileri **GÜVENLİ BİR YERE KAYDET**:

```
Keystore Dosyası: qr-scanner-keystore.jks
Keystore Şifresi: [OLUŞTURDUĞUN ŞİFRE]
Key Alias: qr-scanner
Key Şifresi: [OLUŞTURDUĞUN ŞİFRE - genelde keystore ile aynı]
```

⚠️ **ÇOK ÖNEMLİ:** Bu bilgileri kaybedersen uygulamayı güncelleyemezsin!

---

## 🔧 key.properties Dosyası Oluştur

`android/key.properties` dosyası oluştur:

```properties
storePassword=KEYSTORE_ŞİFREN
keyPassword=KEY_ŞİFREN
keyAlias=qr-scanner
storeFile=../qr-scanner-keystore.jks
```

**Örnek:**
```properties
storePassword=MySecurePassword123
keyPassword=MySecurePassword123
keyAlias=qr-scanner
storeFile=../qr-scanner-keystore.jks
```

---

## 📝 .gitignore Güncelle

`key.properties` ve keystore dosyasını git'e ekleme!

`.gitignore` dosyasına ekle:
```
# Android Signing
android/key.properties
*.jks
*.keystore
```

---

## 🔧 build.gradle Güncelle

`android/app/build.gradle` dosyasını güncelle:

### 1. key.properties Yükle (android bloğundan ÖNCE)
```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}
```

### 2. signingConfigs Ekle (android bloğu içinde, buildTypes'tan ÖNCE)
```gradle
android {
    ...
    
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    
    buildTypes {
        release {
            signingConfig signingConfigs.release
            ...
        }
    }
}
```

---

## ✅ Test Et

```bash
flutter build apk --release
```

Başarılı olursa `build/app/outputs/flutter-apk/app-release.apk` oluşur.

---

## 📤 Codemagic İçin Hazırlık

### 1. Keystore Dosyasını Base64'e Çevir

**Windows (PowerShell):**
```powershell
[Convert]::ToBase64String([IO.File]::ReadAllBytes("qr-scanner-keystore.jks")) | Out-File keystore-base64.txt
```

**macOS/Linux:**
```bash
base64 -i qr-scanner-keystore.jks -o keystore-base64.txt
```

### 2. Codemagic'e Yükle

1. Codemagic Dashboard > Your App > Settings
2. **Code signing identities** > **Android**
3. **Upload keystore**
4. Keystore bilgilerini gir:
   - Keystore file: `keystore-base64.txt` içeriğini yapıştır
   - Keystore password: Keystore şifreni gir
   - Key alias: `qr-scanner`
   - Key password: Key şifreni gir

---

## 🎯 Özet

1. ✅ Keystore oluştur: `keytool -genkey ...`
2. ✅ Bilgileri kaydet (şifreler, alias)
3. ✅ `key.properties` oluştur
4. ✅ `.gitignore` güncelle
5. ✅ `build.gradle` güncelle
6. ✅ Test et: `flutter build apk --release`
7. ✅ Base64'e çevir
8. ✅ Codemagic'e yükle

---

**Sonraki Adım:** `CODEMAGIC_SETUP.md` dosyasını oku ve Codemagic'i kur! 🚀
