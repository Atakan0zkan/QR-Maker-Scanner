import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;

/// Firebase Analytics Service
/// ⚠️ WARNING: This collects anonymous usage data
/// Privacy Impact: YES - Tracks user behavior
class FirebaseAnalyticsService {
  static FirebaseAnalytics? _analytics;
  static FirebaseAnalyticsObserver? _observer;
  
  /// Get Firebase Analytics instance
  static FirebaseAnalytics? get analytics => _analytics;
  
  /// Get Firebase Analytics Observer for navigation tracking
  static FirebaseAnalyticsObserver? get observer => _observer;
  
  /// Initialize Firebase Analytics
  static Future<void> initialize() async {
    try {
      // Firebase is already initialized in main.dart, just get instance
      _analytics = FirebaseAnalytics.instance;
      _observer = FirebaseAnalyticsObserver(analytics: _analytics!);
      
      // Set analytics collection enabled
      await _analytics!.setAnalyticsCollectionEnabled(true);
      
      if (kDebugMode) {
        developer.log(
          '✅ Firebase Analytics initialized',
          name: 'FirebaseAnalyticsService',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        developer.log(
          '❌ Firebase Analytics initialization failed: $e',
          name: 'FirebaseAnalyticsService',
          error: e,
        );
      }
    }
  }
  
  /// Log custom event
  static Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    try {
      await _analytics?.logEvent(
        name: name,
        parameters: parameters,
      );
      
      if (kDebugMode) {
        developer.log(
          'Event logged: $name ${parameters != null ? parameters.toString() : ""}',
          name: 'FirebaseAnalyticsService',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        developer.log(
          'Failed to log event: $name',
          name: 'FirebaseAnalyticsService',
          error: e,
        );
      }
    }
  }
  
  // ═══════════════════════════════════════════════════════════
  // QR Code Events
  // ═══════════════════════════════════════════════════════════
  
  /// Log QR code scanned
  static Future<void> logQrScanned(String type) async {
    await logEvent(
      name: 'qr_scanned',
      parameters: {
        'qr_type': type,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }
  
  /// Log QR code generated
  static Future<void> logQrGenerated(String type) async {
    await logEvent(
      name: 'qr_generated',
      parameters: {
        'qr_type': type,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }
  
  /// Log QR code saved
  static Future<void> logQrSaved(String type) async {
    await logEvent(
      name: 'qr_saved',
      parameters: {
        'qr_type': type,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }
  
  /// Log QR code shared
  static Future<void> logQrShared(String type) async {
    await logEvent(
      name: 'qr_shared',
      parameters: {
        'qr_type': type,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }
  
  /// Log QR code saved to gallery
  static Future<void> logQrSavedToGallery(String type) async {
    await logEvent(
      name: 'qr_saved_to_gallery',
      parameters: {
        'qr_type': type,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }
  
  /// Log QR code deleted
  static Future<void> logQrDeleted(String type, int count) async {
    await logEvent(
      name: 'qr_deleted',
      parameters: {
        'qr_type': type,
        'count': count,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }
  
  // ═══════════════════════════════════════════════════════════
  // Screen Events
  // ═══════════════════════════════════════════════════════════
  
  /// Log screen view
  static Future<void> logScreenView(String screenName) async {
    await _analytics?.logScreenView(
      screenName: screenName,
    );
  }
  
  // ═══════════════════════════════════════════════════════════
  // Feature Usage Events
  // ═══════════════════════════════════════════════════════════
  
  /// Log bug report submitted
  static Future<void> logBugReportSubmitted() async {
    await logEvent(name: 'bug_report_submitted');
  }
  
  /// Log batch scan started
  static Future<void> logBatchScanStarted() async {
    await logEvent(name: 'batch_scan_started');
  }
  
  /// Log batch scan completed
  static Future<void> logBatchScanCompleted(int count) async {
    await logEvent(
      name: 'batch_scan_completed',
      parameters: {'scan_count': count},
    );
  }
  
  /// Log settings changed
  static Future<void> logSettingsChanged(String setting, dynamic value) async {
    await logEvent(
      name: 'settings_changed',
      parameters: {
        'setting_name': setting,
        'setting_value': value.toString(),
      },
    );
  }
  
  /// Log theme changed
  static Future<void> logThemeChanged(String theme) async {
    await logEvent(
      name: 'theme_changed',
      parameters: {'theme': theme},
    );
  }
  
  /// Log language changed
  static Future<void> logLanguageChanged(String language) async {
    await logEvent(
      name: 'language_changed',
      parameters: {'language': language},
    );
  }
  
  // ═══════════════════════════════════════════════════════════
  // User Properties
  // ═══════════════════════════════════════════════════════════
  
  /// Set user property
  static Future<void> setUserProperty(String name, String? value) async {
    try {
      await _analytics?.setUserProperty(
        name: name,
        value: value,
      );
    } catch (e) {
      if (kDebugMode) {
        developer.log(
          'Failed to set user property: $name',
          name: 'FirebaseAnalyticsService',
          error: e,
        );
      }
    }
  }
}
