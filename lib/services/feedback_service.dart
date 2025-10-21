import 'dart:io';
import 'dart:typed_data';
import 'dart:developer' as developer;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class FeedbackService {
  static const String developerEmail = 'reportbugstomebro@gmail.com';
  
  /// Get device and app information
  static Future<String> getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    final packageInfo = await PackageInfo.fromPlatform();
    
    String deviceDetails = '';
    
    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        deviceDetails = '''
📱 Device Information:
• OS: Android ${androidInfo.version.release} (SDK ${androidInfo.version.sdkInt})
• Device: ${androidInfo.manufacturer} ${androidInfo.model}
• Brand: ${androidInfo.brand}
• Hardware: ${androidInfo.hardware}

📦 App Information:
• Version: ${packageInfo.version} (${packageInfo.buildNumber})
• Package: ${packageInfo.packageName}
''';
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        deviceDetails = '''
📱 Device Information:
• OS: iOS ${iosInfo.systemVersion}
• Device: ${iosInfo.name} (${iosInfo.model})
• System Name: ${iosInfo.systemName}
• Identifier: ${iosInfo.identifierForVendor ?? 'Unknown'}

📦 App Information:
• Version: ${packageInfo.version} (${packageInfo.buildNumber})
• Package: ${packageInfo.packageName}
''';
      } else {
        deviceDetails = '''
📱 Device Information:
• Platform: ${Platform.operatingSystem}

📦 App Information:
• Version: ${packageInfo.version} (${packageInfo.buildNumber})
• Package: ${packageInfo.packageName}
''';
      }
    } catch (e) {
      deviceDetails = '''
📦 App Information:
• Version: ${packageInfo.version} (${packageInfo.buildNumber})
• Package: ${packageInfo.packageName}
• Error getting device info: $e
''';
    }
    
    return deviceDetails;
  }
  
  /// Send feedback email with screenshot
  static Future<bool> sendFeedback({
    required String userFeedback,
    required Uint8List screenshot,
  }) async {
    try {
      // Get device info
      final deviceInfo = await getDeviceInfo();
      
      // Save screenshot to temp file
      final tempDir = await getTemporaryDirectory();
      final screenshotFile = File('${tempDir.path}/bug_report_${DateTime.now().millisecondsSinceEpoch}.png');
      await screenshotFile.writeAsBytes(screenshot);
      
      // Prepare email body
      final emailBody = '''
🐛 Bug Report

User Feedback:
$userFeedback

---

$deviceInfo

---
⏰ Reported at: ${DateTime.now()}
''';
      
      // Try to share via email with attachment
      try {
        final result = await Share.shareXFiles(
          [XFile(screenshotFile.path)],
          subject: '🐛 QR Scanner Bug Report',
          text: emailBody,
        );
        return result.status == ShareResultStatus.success || 
               result.status == ShareResultStatus.unavailable; // unavailable = dialog closed
      } catch (e) {
        // Fallback: Try mailto with just text
        final Uri emailUri = Uri(
          scheme: 'mailto',
          path: developerEmail,
          queryParameters: {
            'subject': '🐛 QR Scanner Bug Report',
            'body': '$emailBody\n\n(Screenshot attached separately)',
          },
        );
        
        if (await canLaunchUrl(emailUri)) {
          await launchUrl(emailUri);
          return true;
        }
        return false;
      }
    } catch (e) {
      developer.log('Error sending feedback: $e', name: 'FeedbackService');
      return false;
    }
  }
}
