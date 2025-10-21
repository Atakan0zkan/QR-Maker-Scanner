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
