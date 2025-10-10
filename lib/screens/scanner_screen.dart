import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import '../providers/qr_provider.dart';
import '../services/qr_helper.dart';
import '../services/permission_service.dart';
import '../widgets/permission_dialog.dart';
import '../widgets/scanner_overlay.dart';
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
    if (_isProcessing) return;

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final barcode = barcodes.first;
    final String? code = barcode.rawValue;

    if (code == null || code.isEmpty) return;

    setState(() {
      _isProcessing = true;
    });

    final qrType = QRHelper.detectQRType(code);

    // Save to database
    context.read<QRProvider>().addScannedQR(content: code, type: qrType);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Scanner'), centerTitle: true),
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
                    'Kamera izni gerekli',
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
                    child: const Text('İzin Ver'),
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
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        'QR kodunu taramak için kamerayı hizalayın',
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
