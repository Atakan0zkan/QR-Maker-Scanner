# Product Context - QR Scanner & Generator

## Neden Bu Proje Var?
Kullanıcılar günlük hayatta sıkça QR kod taramak ve oluşturmak zorunda kalıyor. Mevcut çözümler genellikle reklam ağırlıklı, yavaş veya gizlilik konusunda sorunlu. Bu uygulama, **hızlı**, **güvenli** ve **gizlilik odaklı** bir alternatif sunuyor.

## Çözdüğü Problemler
1. **Gizlilik**: QR kod içerikleri cihazda kalır, sunucuya gönderilmez — AES şifreli Hive DB
2. **Hız**: ~2s uygulama başlatma (paralel servis init), <1s QR tarama
3. **Çok Dilli**: 17 dil ile küresel erişilebilirlik (Arapça RTL dahil)
4. **Çoklu QR Türü**: 9 farklı QR türü tek uygulamada
5. **Özelleştirme**: Renkli, gradient'li, logolu, farklı şekilli QR kodlar
6. **Offline**: İnternet bağlantısı olmadan tam işlevsellik

## Nasıl Çalışmalı?

### Ana Akışlar
1. **Tarama Akışı**: Uygulama aç → Scanner sekmesi → Kamerayı QR'a tut → Otomatik algıla → Detay ekranı → Geçmişe otomatik kayıt
   - Alternatif: Toplu tarama modunda birden fazla kodu üst üste tara → Liste görünümünde gör
2. **Oluşturma Akışı**: Create sekmesi → QR türü seç (dropdown) → Bilgileri gir → Generate → Renk/stil/logo/gradient özelleştir → Kaydet veya Paylaş
3. **Geçmiş Akışı**: History sekmesi → Taranan/Oluşturulan tab → QR/Barkod toggle → Detay → Paylaş/Kopyala/Sil
4. **Ayarlar Akışı**: Settings sekmesi → Dil değiştir, Titreşim aç/kapa, Gizlilik Politikası, Kullanım Şartları, Bug Report, Versiyon bilgisi

### Navigasyon Yapısı
- **Bottom Navigation Bar** ile 4 ana sekme:
  1. **Scanner** — QR/barkod tarama (flaş, toplu tarama modu)
  2. **Create** — 9 türde QR oluşturma + özelleştirme
  3. **History** — Taranan/Oluşturulan geçmiş (tab view) + QR/Barkod toggle
  4. **Settings** — Dil, Tarayıcı ayarları, Gizlilik, Hakkında, Bug Report

### Detay Ekranları
- **QR Detail Screen** — QR önizleme, içerik gösterimi, türe özel aksiyonlar (URL aç, WiFi ayarlarına git, arama yap, SMS gönder, haritada aç vb.)
- **Privacy Policy Screen** — 8 bölümlük gizlilik politikası (lokalize)
- **Terms of Service Screen** — 12 bölümlük kullanım şartları (lokalize)

## Kullanıcı Deneyimi Hedefleri
- **Anında İlk Kullanım**: Kayıt/giriş gerekmez
- **Minimal İzin**: Sadece kamera izni (zorunlu), depolama izni (opsiyonel)
- **Offline Çalışma**: İnternet olmadan tam özellikli (%100 offline-first)
- **Erişilebilirlik**: RTL dil desteği (Arapça), büyük yazı boyutları, Material 3 tasarım
- **Kolay Bug Bildirimi**: Uygulama içinden screenshot + açıklama ile hata bildirimi
- **Haptic Feedback**: Tarama sırasında opsiyonel titreşim geri bildirimi

## Gelir Modeli
- **Interstitial Ads**: QR oluşturma sonrası tam ekran reklam (AdMob)
  - Debug modda test ID'leri kullanılır
  - Production'da gerçek ID'ler aktif
- Uygulamanın tüm özellikleri ücretsiz (reklam destekli, freemium değil)
- Reklam yüklenmese bile uygulama tam işlevsel çalışır

## Geliştirme Notları
- Windows ortamında Gradle build sorunları yaşanabilir → `techContext.md`'deki "Gradle Troubleshooting" bölümüne bak
- Emülatörde test için Pixel 9 (API 37) kullanılıyor; 4 GB RAM ayarı zorunlu pratik baseline (`hw.ramSize=4096`, `vm.heapSize=512`)
- Dependency update sonrası `flutter pub get` mutlaka çalıştırılmalı; son major update'te `jni` native library metadata yenilenmeden APK splash'te kalmıştı
- En stabil test yöntemi: fiziksel Android cihaz bağlamak
