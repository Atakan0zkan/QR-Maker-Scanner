import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import '../models/qr_type.dart';
import '../services/qr_helper.dart';
import '../core/constants/app_colors.dart';

class QRDetailScreen extends StatelessWidget {
  final String content;
  final QRType type;
  final bool isScanned;

  const QRDetailScreen({
    super.key,
    required this.content,
    required this.type,
    this.isScanned = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle()),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () => _copyToClipboard(context),
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _share(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTypeCard(context),
            const SizedBox(height: 16),
            _buildContentCard(context),
            const SizedBox(height: 24),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  String _getTitle() {
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

  IconData _getIcon() {
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
        return Icons.message;
      case QRType.phone:
        return Icons.phone;
      case QRType.location:
        return Icons.location_on;
      case QRType.social:
        return Icons.share;
    }
  }

  Widget _buildTypeCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getIcon(),
                color: AppColors.primary,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getTitle(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isScanned ? 'Taranan' : 'Oluşturulan',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'İçerik',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            _buildContentDisplay(context),
          ],
        ),
      ),
    );
  }

  Widget _buildContentDisplay(BuildContext context) {
    if (type == QRType.wifi) {
      final wifiData = QRHelper.parseWiFiQR(content);
      if (wifiData != null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Ağ Adı', wifiData['ssid'] ?? ''),
            _buildInfoRow('Şifre', wifiData['password'] ?? ''),
            _buildInfoRow('Güvenlik', wifiData['security'] ?? ''),
          ],
        );
      }
    } else if (type == QRType.location) {
      final locationData = QRHelper.parseLocationQR(content);
      if (locationData != null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Enlem', locationData['latitude'] ?? ''),
            _buildInfoRow('Boylam', locationData['longitude'] ?? ''),
          ],
        );
      }
    }

    return SelectableText(
      content,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: SelectableText(value),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final buttons = <Widget>[];

    switch (type) {
      case QRType.url:
      case QRType.social:
        buttons.add(
          _buildActionButton(
            context,
            icon: Icons.open_in_browser,
            label: 'Tarayıcıda Aç',
            onPressed: () => _openURL(context),
          ),
        );
        break;
      case QRType.wifi:
        buttons.add(
          _buildActionButton(
            context,
            icon: Icons.wifi,
            label: 'WiFi Ayarlarına Git',
            onPressed: () => _openWiFiSettings(context),
          ),
        );
        break;
      case QRType.phone:
        buttons.addAll([
          _buildActionButton(
            context,
            icon: Icons.call,
            label: 'Ara',
            onPressed: () => _makeCall(context),
          ),
          const SizedBox(height: 12),
          _buildActionButton(
            context,
            icon: Icons.message,
            label: 'Mesaj Gönder',
            onPressed: () => _sendSMS(context),
          ),
        ]);
        break;
      case QRType.email:
        buttons.add(
          _buildActionButton(
            context,
            icon: Icons.email,
            label: 'E-posta Gönder',
            onPressed: () => _sendEmail(context),
          ),
        );
        break;
      case QRType.sms:
        buttons.add(
          _buildActionButton(
            context,
            icon: Icons.message,
            label: 'Mesaj Gönder',
            onPressed: () => _sendSMS(context),
          ),
        );
        break;
      case QRType.location:
        buttons.add(
          _buildActionButton(
            context,
            icon: Icons.map,
            label: 'Haritada Aç',
            onPressed: () => _openMap(context),
          ),
        );
        break;
      default:
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: buttons,
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: content));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Panoya kopyalandı')),
    );
  }

  void _share(BuildContext context) {
    // ignore: deprecated_member_use
    Share.share(
      content,
      subject: 'QR Kod - ${_getTitle()}',
    );
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('QR kod içeriği paylaşıldı'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  Future<void> _openURL(BuildContext context) async {
    final uri = Uri.parse(content);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('URL açılamadı')),
        );
      }
    }
  }

  Future<void> _openWiFiSettings(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Lütfen WiFi ayarlarından manuel olarak bağlanın'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<void> _makeCall(BuildContext context) async {
    final uri = Uri.parse(content.startsWith('tel:') ? content : 'tel:$content');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _sendSMS(BuildContext context) async {
    final uri = Uri.parse(content.startsWith('sms') ? content : 'sms:$content');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _sendEmail(BuildContext context) async {
    final uri = Uri.parse(content);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _openMap(BuildContext context) async {
    final uri = Uri.parse(content);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
