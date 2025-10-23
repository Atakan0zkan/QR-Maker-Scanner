import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';
import '../providers/qr_provider.dart';
import '../services/qr_helper.dart';
import '../services/permission_service.dart';
import '../widgets/permission_dialog.dart';
import '../widgets/scanner_overlay.dart';
import '../l10n/app_localizations.dart';
import 'qr_detail_screen.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen>
    with WidgetsBindingObserver {
  MobileScannerController? _controller;
  bool _hasPermission = false;
  bool _isProcessing = false;
  bool _isMultiScanMode = false;
  bool _isTorchOn = false;
  final List<Map<String, dynamic>> _scannedCodes = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkPermission();
    }
  }

  Future<void> _checkPermission() async {
    final hasPermission = await PermissionService.checkCameraPermission();
    setState(() {
      _hasPermission = hasPermission;
    });

    if (hasPermission) {
      _initializeController();
    } else {
      final granted = await PermissionService.requestCameraPermission();
      if (granted) {
        setState(() {
          _hasPermission = true;
        });
        _initializeController();
      } else {
        if (mounted) {
          _showPermissionDialog();
        }
      }
    }
  }

  void _initializeController() {
    if (_controller != null) return; // Zaten var ise yeniden oluşturma
    
    _controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
    );
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const PermissionDialog(),
    );
  }

  void _onDetect(BarcodeCapture capture) {
    if (_isProcessing && !_isMultiScanMode) return;

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final barcode = barcodes.first;
    final String? code = barcode.rawValue;

    if (code == null || code.isEmpty) return;

    // Haptic feedback - Hafif titreşim
    Vibration.hasVibrator().then((hasVibrator) {
      if (hasVibrator == true) {
        Vibration.vibrate(duration: 50); // 50ms hafif titreşim
      }
    });

    final qrType = QRHelper.detectQRType(code);
    final isBarcode = barcode.format != BarcodeFormat.qrCode;

    if (_isMultiScanMode) {
      // Toplu tarama modu - listeye ekle
      final alreadyScanned = _scannedCodes.any((item) => item['content'] == code);
      if (!alreadyScanned) {
        setState(() {
          _scannedCodes.add({
            'content': code,
            'type': qrType,
            'timestamp': DateTime.now(),
            'isBarcode': isBarcode,
          });
        });
        
        // Save to database
        final provider = context.read<QRProvider>();
        provider.addScannedQR(content: code, type: qrType, isBarcode: isBarcode);
      }
    } else {
      // Normal tarama modu
      setState(() {
        _isProcessing = true;
      });

      // Save to database
      final provider = context.read<QRProvider>();
      provider.addScannedQR(content: code, type: qrType, isBarcode: isBarcode);

      // Navigate to detail screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              QRDetailScreen(content: code, type: qrType, isScanned: true),
        ),
      ).then((_) {
        setState(() {
          _isProcessing = false;
        });
      });
    }
  }

  void _toggleMultiScanMode() {
    setState(() {
      _isMultiScanMode = !_isMultiScanMode;
      if (!_isMultiScanMode) {
        _scannedCodes.clear();
      }
    });
  }

  Future<void> _toggleTorch() async {
    final l10n = AppLocalizations.of(context)!;
    try {
      await _controller?.toggleTorch();
      setState(() {
        _isTorchOn = !_isTorchOn;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${l10n.flashControlFailed}: $e')),
        );
      }
    }
  }

  void _showScannedList() {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${l10n.scannedCodesLabel} (${_scannedCodes.length})',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _scannedCodes.isEmpty
                      ? Center(child: Text(l10n.noQRScannedYet))
                      : ListView.builder(
                          controller: scrollController,
                          itemCount: _scannedCodes.length,
                          itemBuilder: (context, index) {
                            final item = _scannedCodes[index];
                            return ListTile(
                              leading: Icon(QRHelper.getQRIcon(item['type'])),
                              title: Text(
                                item['content'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(QRHelper.getQRTypeLabel(item['type'])),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () {
                                  setState(() {
                                    _scannedCodes.removeAt(index);
                                  });
                                  Navigator.pop(context);
                                  if (_scannedCodes.isNotEmpty) {
                                    _showScannedList();
                                  }
                                },
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => QRDetailScreen(
                                      content: item['content'],
                                      type: item['type'],
                                      isScanned: true,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.appName,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          if (_hasPermission)
            IconButton(
              icon: Icon(_isTorchOn ? Icons.flash_on : Icons.flash_off),
              tooltip: _isTorchOn ? l10n.flashOn : l10n.flashOff,
              onPressed: _toggleTorch,
            ),
          if (_hasPermission)
            IconButton(
              icon: Icon(_isMultiScanMode ? Icons.qr_code_scanner : Icons.qr_code_2),
              tooltip: _isMultiScanMode ? l10n.normalMode : l10n.batchScanMode,
              onPressed: _toggleMultiScanMode,
            ),
          if (_isMultiScanMode && _scannedCodes.isNotEmpty)
            IconButton(
              icon: Badge(
                label: Text('${_scannedCodes.length}'),
                child: const Icon(Icons.list),
              ),
              tooltip: l10n.scannedCodesLabel,
              onPressed: _showScannedList,
            ),
        ],
      ),
      body: !_hasPermission
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    size: 80,
                    color: Theme.of(context).disabledColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.cameraPermissionNeeded,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      'QR kod taramak için kamera erişimine izin vermeniz gerekiyor',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _checkPermission,
                    child: Text(l10n.grantPermission),
                  ),
                ],
              ),
            )
          : Stack(
              children: [
                MobileScanner(controller: _controller, onDetect: _onDetect),
                const ScannerOverlay(),
                Positioned(
                  bottom: 32,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        l10n.scanQROrBarcode,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
