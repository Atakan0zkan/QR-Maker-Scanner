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
    
    // Location detection
    if (content.startsWith('geo:') || content.startsWith('GEO:')) {
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
    String? company,
  }) {
    final buffer = StringBuffer('BEGIN:VCARD\nVERSION:3.0\n');
    buffer.write('FN:$name\n');
    if (phone != null && phone.isNotEmpty) {
      buffer.write('TEL:$phone\n');
    }
    if (email != null && email.isNotEmpty) {
      buffer.write('EMAIL:$email\n');
    }
    if (company != null && company.isNotEmpty) {
      buffer.write('ORG:$company\n');
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
    if (!content.toLowerCase().startsWith('geo:')) return null;
    
    final coords = content.substring(4).split(',');
    if (coords.length >= 2) {
      return {
        'latitude': coords[0].trim(),
        'longitude': coords[1].trim(),
      };
    }
    return null;
  }
}
