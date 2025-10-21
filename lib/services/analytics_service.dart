import 'package:hive/hive.dart';
import '../models/analytics_event.dart';

class AnalyticsService {
  static const String _boxName = 'analytics_events';
  static Box<AnalyticsEvent>? _box;

  static Future<void> init() async {
    try {
      // Register adapter
      if (!Hive.isAdapterRegistered(3)) {
        Hive.registerAdapter(AnalyticsEventAdapter());
      }
      _box = await Hive.openBox<AnalyticsEvent>(_boxName);
    } catch (e) {
      print('Analytics init error: $e');
    }
  }

  // Event tracking
  static Future<void> logEvent(String eventName, [Map<String, dynamic>? properties]) async {
    try {
      if (_box == null) return;
      
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

  static Map<String, dynamic> getStatistics() {
    final events = _box?.values.toList() ?? [];
    if (events.isEmpty) {
      return {
        'total_events': 0,
        'event_types': 0,
        'first_event': null,
        'last_event': null,
      };
    }

    final counts = getEventCounts();
    final sortedEvents = events..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    return {
      'total_events': events.length,
      'event_types': counts.length,
      'most_common': counts.entries.reduce((a, b) => a.value > b.value ? a : b).key,
      'first_event': sortedEvents.first.timestamp,
      'last_event': sortedEvents.last.timestamp,
      'event_counts': counts,
    };
  }

  // Temizleme
  static Future<void> clearOldEvents({int daysToKeep = 30}) async {
    try {
      final cutoffDate = DateTime.now().subtract(Duration(days: daysToKeep));
      final eventsToDelete = _box?.values
          .where((event) => event.timestamp.isBefore(cutoffDate))
          .toList() ?? [];
      
      for (var event in eventsToDelete) {
        await event.delete();
      }
    } catch (e) {
      print('Analytics cleanup error: $e');
    }
  }

  static Future<void> clearAllEvents() async {
    try {
      await _box?.clear();
    } catch (e) {
      print('Analytics clear error: $e');
    }
  }
}
