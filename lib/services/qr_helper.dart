import 'package:flutter/material.dart';
import '../models/qr_type.dart';

class QRHelper {
  static QRType detectQRType(String content) {
    content = content.trim();
    
    // URL detection
    if (_isURL(content)) {
      // Check for social media
      if (_isSocialMedia(content)) {
        return QRType.social;
      }
      return QRType.url;
    }
    
    // WiFi detection
    if (content.startsWith('WIFI:')) {
      return QRType.wifi;
    }
    
    // vCard/Contact detection
    if (content.startsWith('BEGIN:VCARD') || content.startsWith('MECARD:')) {
      return QRType.contact;
    }
    
    // Email detection
    if (content.startsWith('mailto:') || content.startsWith('MATMSG:')) {
      return QRType.email;
    }
    
    // SMS detection
    if (content.startsWith('sms:') || content.startsWith('smsto:') || content.startsWith('SMSTO:')) {
      return QRType.sms;
    }
    
    // Phone detection
    if (content.startsWith('tel:') || content.startsWith('TEL:')) {
      return QRType.phone;
    }
    
    // Location detection (geo:, Google Maps, Apple Maps)
    if (content.startsWith('geo:') || content.startsWith('GEO:') ||
        _isGoogleMapsLink(content) || _isAppleMapsLink(content)) {
      return QRType.location;
    }
    
    // Default to text
    return QRType.text;
  }

  static bool _isURL(String text) {
    final urlPattern = RegExp(
      r'^(https?:\/\/)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
      caseSensitive: false,
    );
    return urlPattern.hasMatch(text);
  }

  static bool _isSocialMedia(String url) {
    final socialDomains = [
      'instagram.com',
      'facebook.com',
      'twitter.com',
      'x.com',
      'linkedin.com',
      'tiktok.com',
      'youtube.com',
      'snapchat.com',
      'pinterest.com',
      'reddit.com',
      'whatsapp.com',
      'telegram.org',
      't.me',
    ];
    
    return socialDomains.any((domain) => url.toLowerCase().contains(domain));
  }

  static bool _isGoogleMapsLink(String url) {
    return url.contains('google.com/maps') || 
           url.contains('goo.gl/maps') ||
           url.contains('maps.app.goo.gl');
  }

  static bool _isAppleMapsLink(String url) {
    return url.contains('maps.apple.com') || 
           url.startsWith('http://maps.apple.com') ||
           url.startsWith('https://maps.apple.com');
  }

  static String formatWiFiQR({
    required String ssid,
    required String password,
    required String security,
  }) {
    return 'WIFI:T:$security;S:$ssid;P:$password;;';
  }

  static String formatContactQR({
    required String name,
    String? phone,
    String? email,
  }) {
    final buffer = StringBuffer('BEGIN:VCARD\nVERSION:3.0\n');
    buffer.write('FN:$name\n');
    if (phone != null && phone.isNotEmpty) {
      buffer.write('TEL:$phone\n');
    }
    if (email != null && email.isNotEmpty) {
      buffer.write('EMAIL:$email\n');
    }
    buffer.write('END:VCARD');
    return buffer.toString();
  }

  static String formatEmailQR({
    required String email,
    String? subject,
    String? body,
  }) {
    final buffer = StringBuffer('mailto:$email');
    final params = <String>[];
    
    if (subject != null && subject.isNotEmpty) {
      params.add('subject=${Uri.encodeComponent(subject)}');
    }
    if (body != null && body.isNotEmpty) {
      params.add('body=${Uri.encodeComponent(body)}');
    }
    
    if (params.isNotEmpty) {
      buffer.write('?${params.join('&')}');
    }
    
    return buffer.toString();
  }

  static String formatSMSQR({
    required String phone,
    String? message,
  }) {
    if (message != null && message.isNotEmpty) {
      return 'smsto:$phone:$message';
    }
    return 'smsto:$phone';
  }

  static String formatPhoneQR(String phone) {
    return 'tel:$phone';
  }

  static String formatLocationQR({
    required double latitude,
    required double longitude,
  }) {
    return 'geo:$latitude,$longitude';
  }

  /// Extract coordinates from Google Maps or Apple Maps link
  static String? formatLocationFromMapsLink(String url) {
    // Google Maps: https://maps.google.com/?q=41.0082,28.9784
    // Google Maps: https://www.google.com/maps/place/41.0082,28.9784
    // Apple Maps: https://maps.apple.com/?ll=41.0082,28.9784
    
    try {
      final uri = Uri.parse(url);
      
      // Google Maps - q parameter
      if (uri.queryParameters.containsKey('q')) {
        final coords = uri.queryParameters['q']!.split(',');
        if (coords.length == 2) {
          final lat = double.tryParse(coords[0].trim());
          final lng = double.tryParse(coords[1].trim());
          if (lat != null && lng != null) {
            return 'geo:$lat,$lng';
          }
        }
      }
      
      // Apple Maps - ll parameter
      if (uri.queryParameters.containsKey('ll')) {
        final coords = uri.queryParameters['ll']!.split(',');
        if (coords.length == 2) {
          final lat = double.tryParse(coords[0].trim());
          final lng = double.tryParse(coords[1].trim());
          if (lat != null && lng != null) {
            return 'geo:$lat,$lng';
          }
        }
      }
      
      // Google Maps - path format /place/lat,lng
      if (url.contains('/place/')) {
        final placeMatch = RegExp(r'/place/(-?\d+\.\d+),(-?\d+\.\d+)').firstMatch(url);
        if (placeMatch != null) {
          return 'geo:${placeMatch.group(1)},${placeMatch.group(2)}';
        }
      }
      
      // Google Maps - @lat,lng format
      final atMatch = RegExp(r'@(-?\d+\.\d+),(-?\d+\.\d+)').firstMatch(url);
      if (atMatch != null) {
        return 'geo:${atMatch.group(1)},${atMatch.group(2)}';
      }
    } catch (e) {
      return null;
    }
    
    return null;
  }

  static Map<String, String>? parseWiFiQR(String content) {
    if (!content.startsWith('WIFI:')) return null;
    
    final regex = RegExp(r'T:([^;]*);S:([^;]*);P:([^;]*);');
    final match = regex.firstMatch(content);
    
    if (match != null) {
      return {
        'security': match.group(1) ?? '',
        'ssid': match.group(2) ?? '',
        'password': match.group(3) ?? '',
      };
    }
    return null;
  }

  static Map<String, String>? parseLocationQR(String content) {
    String? geoContent = content;
    
    // If it's a Maps link, convert to geo format first
    if (_isGoogleMapsLink(content) || _isAppleMapsLink(content)) {
      geoContent = formatLocationFromMapsLink(content);
      if (geoContent == null) return null;
    }
    
    if (!geoContent.toLowerCase().startsWith('geo:')) return null;
    
    final coords = geoContent.substring(4).split(',');
    if (coords.length >= 2) {
      return {
        'latitude': coords[0].trim(),
        'longitude': coords[1].trim(),
      };
    }
    return null;
  }

  // QR Type Icon
  static IconData getQRIcon(QRType type) {
    switch (type) {
      case QRType.url:
        return Icons.link;
      case QRType.text:
        return Icons.text_fields;
      case QRType.wifi:
        return Icons.wifi;
      case QRType.contact:
        return Icons.person;
      case QRType.email:
        return Icons.email;
      case QRType.sms:
        return Icons.sms;
      case QRType.phone:
        return Icons.phone;
      case QRType.location:
        return Icons.location_on;
      case QRType.social:
        return Icons.share;
    }
  }

  // QR Type Label
  static String getQRTypeLabel(QRType type) {
    switch (type) {
      case QRType.url:
        return 'URL';
      case QRType.text:
        return 'Metin';
      case QRType.wifi:
        return 'WiFi';
      case QRType.contact:
        return 'Kişi';
      case QRType.email:
        return 'E-posta';
      case QRType.sms:
        return 'SMS';
      case QRType.phone:
        return 'Telefon';
      case QRType.location:
        return 'Konum';
      case QRType.social:
        return 'Sosyal Medya';
    }
  }
}
