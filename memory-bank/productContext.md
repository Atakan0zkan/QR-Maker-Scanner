# Product Context - QR Scanner & Generator

## Neden Bu Proje Var?
Kullanıcılar günlük hayatta sıkça QR kod taramak ve oluşturmak zorunda kalıyor. Mevcut çözümler genellikle reklam ağırlıklı, yavaş veya gizlilik konusunda sorunlu. Bu uygulama, **hızlı**, **güvenli** ve **gizlilik odaklı** bir alternatif sunuyor.

## Çözdüğü Problemler
1. **Gizlilik**: QR kod içerikleri cihazda kalır, sunucuya gönderilmez
2. **Hız**: ~2s uygulama başlatma, <1s QR tarama
3. **Çok Dilli**: 16+ dil ile küresel erişilebilirlik
4. **Çoklu QR Türü**: 9 farklı QR türü tek uygulamada
5. **Özelleştirme**: Renkli, kişiselleştirilmiş QR kodlar

## Nasıl Çalışmalı?

### Ana Akışlar
1. **Tarama Akışı**: Uygulama aç → Scanner sekmesi → Kamerayı QR'a tut → Otomatik algıla → Sonucu göster → Geçmişe kaydet
2. **Oluşturma Akışı**: Create sekmesi → QR türü seç → Bilgileri gir → Renk/stil özelleştir → QR oluştur → Paylaş/Kaydet
3. **Geçmiş Akışı**: History sekmesi → Taranan/Oluşturulan → Detay → Paylaş/Sil

### Navigasyon
- Bottom Navigation Bar ile 4 ana sekme: Scanner, Create, History, Settings
- Settings'den: Tema, Dil, Tarayıcı ayarları, Bug Report, Hakkında

## Kullanıcı Deneyimi Hedefleri
- **Anında İlk Kullanım**: Kayıt/giriş gerekmez
- **Minimal İzin**: Sadece kamera ve depolama izni
- **Offline Çalışma**: İnternet olmadan tam özellikli (%100 offline-first)
- **Erişilebilirlik**: RTL dil desteği (Arapça), büyük yazı boyutları
- **Kolay Bug Bildirimi**: Uygulama içinden screenshot + açıklama ile hata bildirimi

## Gelir Modeli
- **AdMob Banner**: Alt kısımda banner reklam
- **Interstitial**: QR oluşturma sonrası tam ekran reklam
- Uygulamanın temel özellikleri ücretsiz (freemium değil, tamamen ücretsiz + reklam destekli)
