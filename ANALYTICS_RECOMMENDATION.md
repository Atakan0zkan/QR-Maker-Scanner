# 📊 Analytics Önerisi - Hafif ve Hızlı

## 🎯 Önerilen Çözüm: Hive-Based Local Analytics

QR Scanner uygulaması için **Hive tabanlı lokal analytics** öneriyorum. Bu yaklaşım:

✅ **Hafif** - Ek paket gerektirmez (zaten Hive kullanıyorsunuz)
✅ **Hızlı** - Network request yok, tamamen lokal
✅ **Gizlilik Dostu** - Veriler cihazda kalır, privacy first
✅ **Offline** - İnternet bağlantısı gerektirmez

## 📦 İmplementasyon

### 1. Analytics Model (lib/models/analytics_event.dart)

```dart
import 'package:hive/hive.dart';

part 'analytics_event.g.dart';

@HiveType(typeId: 3)
class AnalyticsEvent extends HiveObject {
  @HiveField(0)
  late String eventName;

  @HiveField(1)
  late DateTime timestamp;

  @HiveField(2)
  Map<String, dynamic>? properties;

  AnalyticsEvent({
    required this.eventName,
    required this.timestamp,
    this.properties,
  });
}
```

### 2. Analytics Service (lib/services/analytics_service.dart)

```dart
import 'package:hive/hive.dart';
import '../models/analytics_event.dart';

class AnalyticsService {
  static const String _boxName = 'analytics_events';
  static Box<AnalyticsEvent>? _box;

  static Future<void> init() async {
    Hive.registerAdapter(AnalyticsEventAdapter());
    _box = await Hive.openBox<AnalyticsEvent>(_boxName);
  }

  // Event tracking
  static Future<void> logEvent(String eventName, [Map<String, dynamic>? properties]) async {
    try {
      final event = AnalyticsEvent(
        eventName: eventName,
        timestamp: DateTime.now(),
        properties: properties,
      );
      await _box?.add(event);
      
      // Auto cleanup: sadece son 1000 event'i tut
      if ((_box?.length ?? 0) > 1000) {
        await _box?.deleteAt(0);
      }
    } catch (e) {
      print('Analytics error: $e');
    }
  }

  // İstatistikler
  static Map<String, int> getEventCounts() {
    final events = _box?.values.toList() ?? [];
    final counts = <String, int>{};
    for (var event in events) {
      counts[event.eventName] = (counts[event.eventName] ?? 0) + 1;
    }
    return counts;
  }

  static int getTotalEvents() => _box?.length ?? 0;

  static List<AnalyticsEvent> getRecentEvents({int limit = 50}) {
    final events = _box?.values.toList() ?? [];
    return events.reversed.take(limit).toList();
  }

  // Temizleme
  static Future<void> clearOldEvents({int daysToKeep = 30}) async {
    final cutoffDate = DateTime.now().subtract(Duration(days: daysToKeep));
    final eventsToDelete = _box?.values
        .where((event) => event.timestamp.isBefore(cutoffDate))
        .toList() ?? [];
    
    for (var event in eventsToDelete) {
      await event.delete();
    }
  }
}
```

### 3. Kullanım Örnekleri

```dart
// QR tarama
await AnalyticsService.logEvent('qr_scanned', {
  'type': qrType.toString(),
  'is_barcode': isBarcode,
});

// QR oluşturma
await AnalyticsService.logEvent('qr_generated', {
  'type': qrType.toString(),
  'has_color': qrForegroundColor != Colors.black,
});

// Tema değiştirme
await AnalyticsService.logEvent('theme_changed', {
  'theme': themeMode.toString(),
});

// Dil değiştirme
await AnalyticsService.logEvent('language_changed', {
  'language': locale.languageCode,
});
```

### 4. Settings'te İstatistikler Gösterme

```dart
// lib/screens/settings_screen.dart içinde
_buildSection(
  context,
  title: 'İstatistikler',
  children: [
    _buildSettingTile(
      context,
      icon: Icons.analytics_outlined,
      title: 'Kullanım İstatistikleri',
      subtitle: 'Toplam ${AnalyticsService.getTotalEvents()} event',
      onTap: () => _showAnalyticsDialog(context),
    ),
  ],
)
```

## 📈 Takip Edilebilecek Metrikler

### Temel Event'ler
- `app_opened` - Uygulama açıldı
- `qr_scanned` - QR tarandı (type, is_barcode)
- `qr_generated` - QR oluşturuldu (type, has_color, has_logo)
- `qr_shared` - QR paylaşıldı
- `qr_saved` - QR kaydedildi
- `theme_changed` - Tema değiştirildi
- `language_changed` - Dil değiştirildi

### İleri Seviye (Opsiyonel)
- `scan_duration` - Tarama süresi
- `feature_used` - Hangi özellik kullanıldı
- `error_occurred` - Hata oluştu (error_type)

## 🚀 Avantajlar

1. **Gizlilik** - Veriler cihazda kalır, 3. parti servise gönderilmez
2. **Hız** - Network overhead yok
3. **Maliyet** - Ücretsiz, ek servis maliyeti yok
4. **Basitlik** - Kolay implement, zaten Hive kullanıyorsunuz
5. **GDPR Uyumlu** - Kişisel veri toplanmaz

## ⚠️ Alternatif (İleri Seviye)

Eğer gelecekte cloud analytics istersen:
- **Sentry** - Error tracking ve performance monitoring
- **Mixpanel** - User analytics (ücretsiz tier var)
- **Posthog** - Open source, self-hosted analytics

Ancak başlangıç için Hive-based yeterli ve gizlilik dostu!

## 💡 Sonuç

Hafif, hızlı, gizlilik dostu analytics için **Hive-based local analytics** en iyi seçim. Implement kolay, maliyet yok ve GDPR uyumlu!
