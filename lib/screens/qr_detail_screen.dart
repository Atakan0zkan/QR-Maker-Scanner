import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/qr_type.dart';
import '../services/qr_helper.dart';
import '../core/constants/app_colors.dart';
import '../l10n/app_localizations.dart';

class QRDetailScreen extends StatelessWidget {
  final String content;
  final QRType type;
  final bool isScanned;
  final Uint8List? qrImage; // Özelleştirilmiş QR image

  const QRDetailScreen({
    super.key,
    required this.content,
    required this.type,
    this.isScanned = false,
    this.qrImage, // Opsiyonel - varsa tasarımlı QR'ı göster
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle(context)),
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
            _buildQRPreview(context),
            const SizedBox(height: 16),
            _buildContentCard(context, l10n),
            const SizedBox(height: 24),
            _buildActionButtons(context, l10n),
          ],
        ),
      ),
    );
  }

  String _getTitle(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (type) {
      case QRType.url:
        return l10n.url;
      case QRType.text:
        return l10n.text;
      case QRType.wifi:
        return l10n.wifi;
      case QRType.contact:
        return l10n.contact;
      case QRType.email:
        return l10n.email;
      case QRType.sms:
        return l10n.sms;
      case QRType.phone:
        return l10n.phone;
      case QRType.location:
        return l10n.location;
      case QRType.social:
        return l10n.social;
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
    final l10n = AppLocalizations.of(context)!;
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
                    _getTitle(context),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isScanned ? l10n.scannedLabel : l10n.generatedLabel,
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

  Widget _buildQRPreview(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: qrImage != null
              // Özelleştirilmiş QR varsa göster
              ? Image.memory(
                  qrImage!,
                  width: 250,
                  height: 250,
                  fit: BoxFit.contain,
                )
              // Yoksa basit QR oluştur
              : QrImageView(
                  data: content,
                  version: QrVersions.auto,
                  size: 250.0,
                  backgroundColor: Colors.transparent,
                  eyeStyle: const QrEyeStyle(color: Colors.white),
                  dataModuleStyle: const QrDataModuleStyle(color: Colors.white),
                  errorCorrectionLevel: QrErrorCorrectLevel.H,
                ),
        ),
      ),
    );
  }

  Widget _buildContentCard(BuildContext context, AppLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.content,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            _buildContentDisplay(context, l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildContentDisplay(BuildContext context, AppLocalizations l10n) {
    if (type == QRType.wifi) {
      final wifiData = QRHelper.parseWiFiQR(content);
      if (wifiData != null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(l10n, l10n.networkName, wifiData['ssid'] ?? ''),
            _buildInfoRow(l10n, l10n.password, wifiData['password'] ?? ''),
            _buildInfoRow(l10n, l10n.security, wifiData['security'] ?? ''),
          ],
        );
      }
    } else if (type == QRType.location) {
      final locationData = QRHelper.parseLocationQR(content);
      if (locationData != null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(l10n, l10n.latitude, locationData['latitude'] ?? ''),
            _buildInfoRow(l10n, l10n.longitude, locationData['longitude'] ?? ''),
          ],
        );
      }
    }

    return SelectableText(
      content,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }

Widget _buildInfoRow(AppLocalizations l10n, String label, String value) {
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

  Widget _buildActionButtons(BuildContext context, AppLocalizations l10n) {
    final buttons = <Widget>[];

    switch (type) {
      case QRType.url:
      case QRType.social:
        buttons.add(
          _buildActionButton(
            context,
            l10n,
            icon: Icons.open_in_browser,
            label: l10n.openInBrowser,
            onPressed: () => _openURL(context),
          ),
        );
        break;
      case QRType.wifi:
        buttons.add(
          _buildActionButton(
            context,
            l10n,
            icon: Icons.wifi,
            label: l10n.goToWiFiSettings,
            onPressed: () => _openWiFiSettings(context),
          ),
        );
        break;
      case QRType.phone:
        buttons.addAll([
          _buildActionButton(
            context,
            l10n,
            icon: Icons.call,
            label: l10n.call,
            onPressed: () => _makeCall(context),
          ),
          const SizedBox(height: 12),
          _buildActionButton(
            context,
            l10n,
            icon: Icons.message,
            label: l10n.sendMessage,
            onPressed: () => _sendSMS(context),
          ),
        ]);
        break;
      case QRType.email:
        buttons.add(
          _buildActionButton(
            context,
            l10n,
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
            l10n,
            icon: Icons.message,
            label: l10n.sendMessage,
            onPressed: () => _sendSMS(context),
          ),
        );
        break;
      case QRType.location:
        buttons.add(
          _buildActionButton(
            context,
            l10n,
            icon: Icons.map,
            label: l10n.openInMap,
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
    BuildContext context,
    AppLocalizations l10n, {
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
    final l10n = AppLocalizations.of(context)!;
    Clipboard.setData(ClipboardData(text: content));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.copiedToClipboard)),
    );
  }

  Future<void> _share(BuildContext context) async {
    // ignore: deprecated_member_use
    await SharePlus.instance.share(
      ShareParams(
        text: content,
        subject: 'QR Kod - ${_getTitle(context)}',
      ),
    );

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('QR kod içeriği paylaşıldı'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  Future<void> _openURL(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final uri = Uri.parse(content);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.urlCannotOpen)),
        );
      }
    }
  }

  Future<void> _openWiFiSettings(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.connectToWiFiManually),
        duration: const Duration(seconds: 3),
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
