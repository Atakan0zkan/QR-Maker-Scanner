import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
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
  bool _isSelectionMode = false;
  final Set<String> _selectedIds = {};
  bool _showBarcodes = false;

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

  void _toggleSelectionMode() {
    setState(() {
      _isSelectionMode = !_isSelectionMode;
      if (!_isSelectionMode) {
        _selectedIds.clear();
      }
    });
  }

  void _deleteSelected(QRProvider provider) {
    for (var id in _selectedIds) {
      if (_tabController.index == 0) {
        provider.deleteScannedQR(id);
      } else {
        provider.deleteGeneratedQR(id);
      }
    }
    setState(() {
      _selectedIds.clear();
      _isSelectionMode = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_selectedIds.length} QR kod silindi'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isSelectionMode 
              ? '${_selectedIds.length} ${l10n.selected}' 
              : _showBarcodes 
                  ? l10n.barcodes 
                  : l10n.history,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: _isSelectionMode
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: _toggleSelectionMode,
              )
            : IconButton(
                icon: Icon(_showBarcodes ? Icons.qr_code_2 : Icons.barcode_reader),
                tooltip: _showBarcodes ? l10n.qrCodes : l10n.barcodes,
                onPressed: () {
                  setState(() {
                    _showBarcodes = !_showBarcodes;
                  });
                },
              ),
        actions: [
          if (!_isSelectionMode)
            IconButton(
              icon: const Icon(Icons.checklist),
              tooltip: l10n.selectItems,
              onPressed: _toggleSelectionMode,
            ),
          if (_isSelectionMode)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              tooltip: l10n.delete,
              onPressed: _selectedIds.isEmpty
                  ? null
                  : () {
                      _showDeleteDialog(
                        context,
                        onConfirm: () => _deleteSelected(context.read<QRProvider>()),
                        count: _selectedIds.length,
                      );
                    },
            ),
        ],
        bottom: _showBarcodes ? null : TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: l10n.scanned),
            Tab(text: l10n.generated),
          ],
        ),
      ),
      body: _showBarcodes
          ? _buildScannedList()
          : TabBarView(
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
        final l10n = AppLocalizations.of(context)!;
        final allScannedQRs = provider.scannedQRs;
        final scannedQRs = allScannedQRs.where((qr) => qr.isBarcode == _showBarcodes).toList();

        if (scannedQRs.isEmpty) {
          return _buildEmptyState(_showBarcodes ? l10n.noScannedBarcode : l10n.noScannedQR);
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: scannedQRs.length,
          itemBuilder: (context, index) {
            final qr = scannedQRs[index];
            final isSelected = _selectedIds.contains(qr.id);
            return _buildQRCard(
              id: qr.id,
              type: qr.type,
              content: qr.content,
              date: qr.scannedAt,
              isSelected: isSelected,
              isBarcode: qr.isBarcode,
              showQRPreview: false,
              onTap: () {
                if (_isSelectionMode) {
                  setState(() {
                    if (isSelected) {
                      _selectedIds.remove(qr.id);
                    } else {
                      _selectedIds.add(qr.id);
                    }
                  });
                } else {
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
                }
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
        final l10n = AppLocalizations.of(context)!;
        final allGeneratedQRs = provider.generatedQRs;
        final generatedQRs = allGeneratedQRs.where((qr) => qr.isBarcode == _showBarcodes).toList();

        if (generatedQRs.isEmpty) {
          return _buildEmptyState(_showBarcodes ? l10n.noGeneratedBarcode : l10n.noGeneratedQR);
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: generatedQRs.length,
          itemBuilder: (context, index) {
            final qr = generatedQRs[index];
            final isSelected = _selectedIds.contains(qr.id);
            return _buildQRCard(
              id: qr.id,
              type: qr.type,
              content: qr.content,
              date: qr.createdAt,
              title: qr.title,
              isSelected: isSelected,
              isBarcode: qr.isBarcode,
              showQRPreview: true,
              qrImage: qr.qrImage,
              onTap: () {
                if (_isSelectionMode) {
                  setState(() {
                    if (isSelected) {
                      _selectedIds.remove(qr.id);
                    } else {
                      _selectedIds.add(qr.id);
                    }
                  });
                } else {
                  // Tasarımlı QR ile detail screen'e git
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QRDetailScreen(
                        content: qr.content,
                        type: qr.type,
                        isScanned: false,
                        qrImage: qr.qrImage, // Özelleştirilmiş QR'ı gönder
                      ),
                    ),
                  );
                }
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
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _showBarcodes ? Icons.qr_code_scanner : Icons.qr_code_2_outlined,
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
            l10n.scanOrCreateQR,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildQRCard({
    required String id,
    required QRType type,
    required String content,
    required DateTime date,
    String? title,
    required bool isSelected,
    required bool isBarcode,
    required bool showQRPreview,
    required VoidCallback onTap,
    required VoidCallback onDelete,
    Uint8List? qrImage,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              if (_isSelectionMode && showQRPreview && !isBarcode)
                // Selection mode + QR preview
                Row(
                  children: [
                    Checkbox(
                      value: isSelected,
                      onChanged: (_) => onTap(),
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: qrImage != null
                          ? Image.memory(
                              qrImage,
                              width: 60,
                              height: 60,
                              fit: BoxFit.contain,
                            )
                          : QrImageView(
                              data: content,
                              version: QrVersions.auto,
                              size: 60,
                              backgroundColor: Colors.transparent,
                              errorCorrectionLevel: QrErrorCorrectLevel.L,
                            ),
                    ),
                  ],
                )
              else if (_isSelectionMode)
                Checkbox(
                  value: isSelected,
                  onChanged: (_) => onTap(),
                )
              else if (showQRPreview && !isBarcode)
                SizedBox(
                  width: 60,
                  height: 60,
                  child: qrImage != null
                      ? Image.memory(
                          qrImage,
                          width: 60,
                          height: 60,
                          fit: BoxFit.contain,
                        )
                      : QrImageView(
                          data: content,
                          version: QrVersions.auto,
                          size: 60,
                          backgroundColor: Colors.transparent,
                          errorCorrectionLevel: QrErrorCorrectLevel.L,
                        ),
                )
              else
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isBarcode ? Icons.qr_code_scanner : _getIconForType(type),
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
              if (!_isSelectionMode)
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

  void _showDeleteDialog(BuildContext context, {required VoidCallback onConfirm, int? count}) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteConfirmationTitle),
        content: Text(count != null && count > 1
            ? l10n.deleteMultipleMessage(count.toString())
            : l10n.deleteSingleMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              onConfirm();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.deleted)),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }
}
