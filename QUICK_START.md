# 🚀 Quick Start Guide

## ✅ Tamamlanan Adımlar

- [x] Proje oluşturuldu
- [x] Tüm kod dosyaları yazıldı
- [x] `flutter pub get` çalıştırıldı
- [x] `intl` versiyon sorunu çözüldü
- [x] `image_gallery_saver` paketi kaldırıldı
- [x] `flutter gen-l10n` çalıştırıldı
- [x] `dart run build_runner build` çalışıyor...

## 📱 Uygulamayı Çalıştırma

### 1. Build Runner Tamamlanmasını Bekleyin

`dart run build_runner build --delete-conflicting-outputs` komutu tamamlanmalı.

Bu komut şu dosyaları oluşturacak:
- `lib/models/qr_type.g.dart`
- `lib/models/scanned_qr.g.dart`
- `lib/models/generated_qr.g.dart`

### 2. Uygulamayı Çalıştırın

```bash
flutter run
```

**Not:** Windows'ta Developer Mode aktif olmalı. Eğer hata alırsanız:
```bash
start ms-settings:developers
```

### 3. Android Emulator veya Fiziksel Cihaz

- **Emulator:** Android Studio'dan emulator başlatın
- **Fiziksel Cihaz:** USB Debugging açık olmalı

```bash
flutter devices  # Cihazları listele
flutter run -d <device-id>  # Belirli cihazda çalıştır
```

## 🎯 İlk Test

1. **Kamera İzni:** Uygulama açıldığında kamera izni isteyecek
2. **Scanner Ekranı:** Kamera açılacak ve tarama overlay'i görünecek
3. **Navigation:** Alt menüden diğer ekranlara geçiş yapın
4. **QR Oluştur:** Create sekmesinden QR kod oluşturun
5. **Banner Reklam:** Alt navigation bar'ın üstünde banner reklam görünmeli

## ⚠️ Bilinen Sınırlamalar

### 1. Galeri Kaydetme
`image_gallery_saver` paketi kaldırıldı. QR kodları şu şekilde paylaşılabilir:
- Screenshot alıp paylaş
- `share_plus` ile paylaş

### 2. Kamera
- Emulator kamerası sorunlu olabilir
- Fiziksel cihazda test edin

### 3. WiFi Bağlantı
- Android 10+ otomatik bağlantı desteklemiyor
- SSID ve şifre gösterilir, manuel bağlanılır

## 🐛 Sorun Giderme

### Hata: "Developer Mode required"
```bash
start ms-settings:developers
```
Developer Mode'u açın ve tekrar deneyin.

### Hata: "No devices found"
- Android emulator başlatın
- Veya fiziksel cihaz bağlayın (USB Debugging açık)

### Hata: "Gradle build failed"
```bash
flutter clean
flutter pub get
flutter run
```

### Lint Hataları
Build runner tamamlandıktan sonra düzelecek.

## 📊 Beklenen Sonuç

✅ Uygulama başarıyla çalışıyor  
✅ Kamera izni alındı  
✅ QR tarama çalışıyor  
✅ QR oluşturma çalışıyor  
✅ Geçmiş kaydediliyor  
✅ Banner reklam görünüyor  
✅ Tema değişimi çalışıyor  

## 🎉 Başarılı!

Uygulama çalışıyorsa tebrikler! Artık:
- QR kod tarayabilirsiniz
- 9 farklı türde QR oluşturabilirsiniz
- Geçmişi görüntüleyebilirsiniz
- Ayarları değiştirebilirsiniz

---

**Son Güncelleme:** 10 Ekim 2025, 10:58
