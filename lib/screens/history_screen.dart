import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/qr_provider.dart';
import '../models/qr_type.dart';
import '../core/constants/app_colors.dart';
import 'qr_detail_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geçmiş'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Taranan'),
            Tab(text: 'Oluşturulan'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildScannedList(),
          _buildGeneratedList(),
        ],
      ),
    );
  }

  Widget _buildScannedList() {
    return Consumer<QRProvider>(
      builder: (context, provider, _) {
        final scannedQRs = provider.scannedQRs;

        if (scannedQRs.isEmpty) {
          return _buildEmptyState('Henüz taranan QR kod yok');
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: scannedQRs.length,
          itemBuilder: (context, index) {
            final qr = scannedQRs[index];
            return _buildQRCard(
              type: qr.type,
              content: qr.content,
              date: qr.scannedAt,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QRDetailScreen(
                      content: qr.content,
                      type: qr.type,
                      isScanned: true,
                    ),
                  ),
                );
              },
              onDelete: () {
                _showDeleteDialog(
                  context,
                  onConfirm: () => provider.deleteScannedQR(qr.id),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildGeneratedList() {
    return Consumer<QRProvider>(
      builder: (context, provider, _) {
        final generatedQRs = provider.generatedQRs;

        if (generatedQRs.isEmpty) {
          return _buildEmptyState('Henüz oluşturulan QR kod yok');
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: generatedQRs.length,
          itemBuilder: (context, index) {
            final qr = generatedQRs[index];
            return _buildQRCard(
              type: qr.type,
              content: qr.content,
              date: qr.createdAt,
              title: qr.title,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QRDetailScreen(
                      content: qr.content,
                      type: qr.type,
                      isScanned: false,
                    ),
                  ),
                );
              },
              onDelete: () {
                _showDeleteDialog(
                  context,
                  onConfirm: () => provider.deleteGeneratedQR(qr.id),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.qr_code_2_outlined,
            size: 80,
            color: Theme.of(context).disabledColor,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'İlk QR kodunuzu tarayın veya oluşturun',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildQRCard({
    required QRType type,
    required String content,
    required DateTime date,
    String? title,
    required VoidCallback onTap,
    required VoidCallback onDelete,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getIconForType(type),
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? _getTypeLabel(type),
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('dd MMM yyyy, HH:mm').format(date),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: onDelete,
                color: AppColors.error,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForType(QRType type) {
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

  String _getTypeLabel(QRType type) {
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

  void _showDeleteDialog(BuildContext context, {required VoidCallback onConfirm}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Silme Onayı'),
        content: const Text('Bu öğeyi silmek istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              onConfirm();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Silindi')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Sil'),
          ),
        ],
      ),
    );
  }
}
