# Active Context - QR Scanner & Generator

## Mevcut Durum
Uygulama **production-ready** durumda. Son değişiklikler Mart 2026'da yapıldı: paket güncellemeleri, dil desteği düzeltmeleri ve provider güvenlik iyileştirmeleri.

## Son Yapılan Değişiklikler
1. **Paket Güncellemeleri** (Mart 2026): Tüm bağımlılıklar güncel versiyonlara yükseltildi
2. **Dil Desteği Düzeltmesi** (Mart 2026): Yunanca (el) supportedLocales'a geri eklendi, README dil bilgisi 10→17 güncellendi
3. **Provider Güvenlik İyileştirmesi** (Mart 2026): `QRProvider` ve `SettingsProvider`'a `_disposed` + `_notifySafe()` pattern eklendi — tüm 4 provider artık tutarlı
4. **SECURITY.md Güncelleme** (Mart 2026): Tarih bilgisi güncellendi
5. **Dil Desteği Genişletildi**: 10 dilden 17 dile çıkarıldı (Hi, Pt, Ko, Ru, Pl, Uk, Nl + El geri eklendi)
6. **Scanner Ayarları**: `SettingsProvider` ile vibrate on scan özelliği eklendi

## Aktif Kararlar ve Dikkat Noktaları

### Versiyon Tutarsızlığı ⚠️
- `pubspec.yaml`: `1.0.0+1`
- `CHANGELOG.md` son: `1.2.3`
- `SECURITY.md` son: `1.2.3`
- `README.md`: `1.0.0`
> **Not**: Versiyon numaraları kasıtlı olarak farklı tutulmuş olabilir (store release vs development history). Bir sonraki release'den önce senkronize edilmeli.

### ✅ Düzeltilen Sorunlar
- ~~README dil bilgisi güncel değil~~ → 17 dil olarak güncellendi
- ~~Yunanca supportedLocales'da eksik~~ → `main.dart` ve `locale_provider.dart`'a eklendi
- ~~QRProvider/SettingsProvider'da _disposed flag eksik~~ → Tüm 4 provider'da tutarlı pattern sağlandı

### Önemli Patterns
- Provider'larda `_disposed` flag ile güvenli dispose — **tüm 4 provider'da** tutarlı
- Tüm servisler static (singleton benzeri) yapıda
- `create_screen.dart` 68KB ile en büyük dosya — refactoring adayı

## Sonraki Adımlar (Roadmap)
- [ ] Save QR to gallery (paket uyumluluk düzeltmesi gerekli)
- [ ] QR kod şifreleme/şifre çözme
- [ ] Batch QR oluşturma
- [ ] QR kod şablonları
- [ ] Cloud backup (opsiyonel)
- [ ] Widget desteği (Home screen)
- [ ] QR kod düzenleme
- [ ] Favori QR kodlar
- [ ] Tarama geçmişi filtreleme

## Öğrenimler ve İçgörüler
- `print()` → `developer.log()` geçişi production güvenliği için kritik
- Paralel servis başlatma ile %60 daha hızlı uygulama açılışı sağlandı
- One-Time QR özelliği karmaşıklık eklediği için kaldırıldı — "basitlik > karmaşıklık"
- Network monitoring servisi gereksiz bulunup kaldırıldı — uygulama %100 offline çalışabiliyor
