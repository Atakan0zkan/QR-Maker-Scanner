import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import '../models/qr_type.dart';
import '../providers/qr_provider.dart';
import '../services/qr_helper.dart';
import '../core/constants/app_colors.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  QRType _selectedType = QRType.url;
  final _formKey = GlobalKey<FormState>();
  final _qrKey = GlobalKey();
  
  // Common fields
  final _urlController = TextEditingController();
  final _textController = TextEditingController();
  
  // WiFi fields
  final _ssidController = TextEditingController();
  final _passwordController = TextEditingController();
  String _securityType = 'WPA';
  
  // Contact fields
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _companyController = TextEditingController();
  
  // Email fields
  final _emailAddressController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  
  // SMS fields
  final _smsPhoneController = TextEditingController();
  final _smsMessageController = TextEditingController();
  
  // Phone field
  final _phoneNumberController = TextEditingController();
  
  // Location fields
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  
  // Social field
  final _profileUrlController = TextEditingController();

  String? _generatedQRData;
  
  // QR Color customization
  Color _qrForegroundColor = Colors.black;
  Color _qrBackgroundColor = Colors.white;
  
  // QR Logo/Image
  String? _selectedLogo; // asset path
  
  // QR Style customization
  String _eyeStyle = 'square'; // square, circle, rounded
  String _dataModuleShape = 'square'; // square, circle
  
  // Gradient/Background
  String _backgroundType = 'color'; // color, gradient
  String _selectedGradient = 'none'; // instagram, facebook, whatsapp, telegram, tiktok, youtube, linkedin, twitter, spotify, netflix, sunset, ocean, fire, purple, mint

  @override
  void dispose() {
    _urlController.dispose();
    _textController.dispose();
    _ssidController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _companyController.dispose();
    _emailAddressController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    _smsPhoneController.dispose();
    _smsMessageController.dispose();
    _phoneNumberController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _profileUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.createQRCode,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTypeSelector(),
              const SizedBox(height: 24),
              _buildFormFields(),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _generateQR,
                child: Text(l10n.generate),
              ),
              if (_generatedQRData != null) ...[
                const SizedBox(height: 32),
                _buildQRPreview(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeSelector() {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.codeType,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<QRType>(
              initialValue: _selectedType,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              items: [
                DropdownMenuItem(value: QRType.url, child: Text(l10n.url)),
                DropdownMenuItem(value: QRType.text, child: Text(l10n.text)),
                DropdownMenuItem(value: QRType.wifi, child: Text(l10n.wifi)),
                DropdownMenuItem(value: QRType.contact, child: Text(l10n.contact)),
                DropdownMenuItem(value: QRType.email, child: Text(l10n.email)),
                DropdownMenuItem(value: QRType.sms, child: Text(l10n.sms)),
                DropdownMenuItem(value: QRType.phone, child: Text(l10n.phone)),
                DropdownMenuItem(value: QRType.location, child: Text(l10n.location)),
                DropdownMenuItem(value: QRType.social, child: Text(l10n.social)),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedType = value!;
                  _generatedQRData = null;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormFields() {
    switch (_selectedType) {
      case QRType.url:
        return _buildURLForm();
      case QRType.text:
        return _buildTextForm();
      case QRType.wifi:
        return _buildWiFiForm();
      case QRType.contact:
        return _buildContactForm();
      case QRType.email:
        return _buildEmailForm();
      case QRType.sms:
        return _buildSMSForm();
      case QRType.phone:
        return _buildPhoneForm();
      case QRType.location:
        return _buildLocationForm();
      case QRType.social:
        return _buildSocialForm();
    }
  }

  Widget _buildURLForm() {
    return TextFormField(
      controller: _urlController,
      decoration: const InputDecoration(
        labelText: 'URL',
        hintText: 'https://www.example.com',
        prefixIcon: Icon(Icons.link),
      ),
      keyboardType: TextInputType.url,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'URL gerekli';
        }
        return null;
      },
    );
  }

  Widget _buildTextForm() {
    final l10n = AppLocalizations.of(context)!;
    return TextFormField(
      controller: _textController,
      decoration: InputDecoration(
        labelText: l10n.textLabel,
        hintText: l10n.textHint,
        prefixIcon: const Icon(Icons.text_fields),
      ),
      maxLines: 5,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return l10n.textRequired;
        }
        return null;
      },
    );
  }

  Widget _buildWiFiForm() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        TextFormField(
          controller: _ssidController,
          decoration: InputDecoration(
            labelText: l10n.ssid,
            prefixIcon: const Icon(Icons.wifi),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'SSID required';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(
            labelText: l10n.password,
            prefixIcon: const Icon(Icons.lock),
          ),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          initialValue: _securityType,
          decoration: InputDecoration(
            labelText: l10n.securityType,
            prefixIcon: const Icon(Icons.security),
          ),
          items: [
            DropdownMenuItem(value: 'WPA', child: Text(l10n.wpa)),
            DropdownMenuItem(value: 'WEP', child: Text(l10n.wep)),
            DropdownMenuItem(value: 'nopass', child: Text(l10n.none)),
          ],
          onChanged: (value) {
            setState(() {
              _securityType = value!;
            });
          },
        ),
      ],
    );
  }

  Widget _buildContactForm() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: l10n.nameLabel,
            prefixIcon: const Icon(Icons.person),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return l10n.nameRequired;
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _phoneController,
          decoration: InputDecoration(
            labelText: l10n.phoneLabel,
            prefixIcon: const Icon(Icons.phone),
          ),
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: l10n.emailLabel,
            prefixIcon: const Icon(Icons.email),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }

  Widget _buildEmailForm() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        TextFormField(
          controller: _emailAddressController,
          decoration: InputDecoration(
            labelText: l10n.emailLabel,
            prefixIcon: const Icon(Icons.email),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return l10n.emailRequired;
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _subjectController,
          decoration: InputDecoration(
            labelText: l10n.subjectOptional,
            prefixIcon: const Icon(Icons.subject),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _messageController,
          decoration: InputDecoration(
            labelText: l10n.messageOptional,
            prefixIcon: const Icon(Icons.message),
          ),
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildSMSForm() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        TextFormField(
          controller: _smsPhoneController,
          decoration: InputDecoration(
            labelText: l10n.phoneNumberLabel,
            prefixIcon: const Icon(Icons.phone),
          ),
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return l10n.phoneNumberRequired;
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _smsMessageController,
          decoration: InputDecoration(
            labelText: l10n.messageOptional,
            prefixIcon: const Icon(Icons.message),
          ),
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildPhoneForm() {
    final l10n = AppLocalizations.of(context)!;
    return TextFormField(
      controller: _phoneNumberController,
      decoration: InputDecoration(
        labelText: l10n.phoneNumberLabel,
        prefixIcon: const Icon(Icons.phone),
      ),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return l10n.phoneNumberRequired;
        }
        return null;
      },
    );
  }

  Widget _buildLocationForm() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        TextFormField(
          controller: _latitudeController,
          decoration: InputDecoration(
            labelText: l10n.locationSearch,
            hintText: l10n.locationExample,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              icon: const Icon(Icons.map),
              tooltip: 'Google Maps\'te Ara',
              onPressed: _openGoogleMapsSearch,
            ),
          ),
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return l10n.locationRequired;
            }
            return null;
          },
        ),
        const SizedBox(height: 8),
        Text(
          'Google Maps\'te arama yapın ve konumu seçin',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 16),
        ExpansionTile(
          title: Text(l10n.enterCoordinates),
          children: [
            const SizedBox(height: 8),
            TextFormField(
              controller: _longitudeController,
              decoration: const InputDecoration(
                labelText: 'Enlem, Boylam',
                hintText: '41.0082, 28.9784',
                prefixIcon: Icon(Icons.location_on),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
            ),
            const SizedBox(height: 8),
            Text(
              'Format: enlem, boylam (örn: 41.0082, 28.9784)',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Future<void> _openGoogleMapsSearch() async {
    final l10n = AppLocalizations.of(context)!;
    final query = _latitudeController.text.trim();
    if (query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.enterLocationName)),
      );
      return;
    }
    
    // Google Maps arama URL'i
    final encodedQuery = Uri.encodeComponent(query);
    final url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$encodedQuery');
    
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
      
      // Kullanıcıya bilgi ver
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Google Maps\'te konumu seçtikten sonra URL\'yi kopyalayıp buraya yapıştırın'),
            duration: Duration(seconds: 4),
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.cannotOpenMaps)),
        );
      }
    }
  }

  Widget _buildSocialForm() {
    return TextFormField(
      controller: _profileUrlController,
      decoration: const InputDecoration(
        labelText: 'Profil URL',
        hintText: 'https://instagram.com/username',
        prefixIcon: Icon(Icons.share),
      ),
      keyboardType: TextInputType.url,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Profil URL gerekli';
        }
        return null;
      },
    );
  }

  Widget _buildQRPreview() {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            RepaintBoundary(
              key: _qrKey,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white.withValues(alpha: 0.1)
                        : Colors.black.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Arka plan (gradient veya renk)
                    Container(
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        gradient: _backgroundType == 'gradient' ? _getSelectedGradient() : null,
                        color: _backgroundType == 'color' ? _qrBackgroundColor : null,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    // QR Kod - PrettyQr ile! ✨ Rounded corners support!
                    SizedBox(
                      width: 220,
                      height: 220,
                      child: PrettyQrView.data(
                        key: ValueKey('$_eyeStyle-$_dataModuleShape'), // Force rebuild!
                        data: _generatedQRData!,
                        errorCorrectLevel: QrErrorCorrectLevel.H,
                        decoration: PrettyQrDecoration(
                          // Shape - both eyes and data modules
                          // Eye style öncelikli (daha görünür)
                          shape: _getCombinedShape(),
                          // Logo image
                          image: _selectedLogo != null 
                              ? PrettyQrDecorationImage(
                                  image: AssetImage(_selectedLogo!),
                                  position: PrettyQrDecorationImagePosition.embedded,
                                )
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildColorPicker(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _saveQR,
                  icon: const Icon(Icons.save),
                  label: Text(l10n.save),
                ),
                OutlinedButton.icon(
                  onPressed: _shareQR,
                  icon: const Icon(Icons.share),
                  label: Text(l10n.share),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _generateQR() {
    final l10n = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String qrData = '';

    switch (_selectedType) {
      case QRType.url:
        qrData = _urlController.text;
        break;
      case QRType.text:
        qrData = _textController.text;
        break;
      case QRType.wifi:
        qrData = QRHelper.formatWiFiQR(
          ssid: _ssidController.text,
          password: _passwordController.text,
          security: _securityType,
        );
        break;
      case QRType.contact:
        qrData = QRHelper.formatContactQR(
          name: _nameController.text,
          phone: _phoneController.text.isEmpty ? null : _phoneController.text,
          email: _emailController.text.isEmpty ? null : _emailController.text,
        );
        break;
      case QRType.email:
        qrData = QRHelper.formatEmailQR(
          email: _emailAddressController.text,
          subject: _subjectController.text.isEmpty ? null : _subjectController.text,
          body: _messageController.text.isEmpty ? null : _messageController.text,
        );
        break;
      case QRType.sms:
        qrData = QRHelper.formatSMSQR(
          phone: _smsPhoneController.text,
          message: _smsMessageController.text.isEmpty ? null : _smsMessageController.text,
        );
        break;
      case QRType.phone:
        qrData = QRHelper.formatPhoneQR(_phoneNumberController.text);
        break;
      case QRType.location:
        final locationInput = _latitudeController.text.trim();
        
        // Google Maps linki mi kontrol et
        if (locationInput.contains('google.com/maps') || locationInput.contains('goo.gl/maps')) {
          qrData = locationInput;
        } 
        // Koordinat girişi mi kontrol et
        else if (_longitudeController.text.isNotEmpty) {
          try {
            final coords = _longitudeController.text.split(',');
            if (coords.length == 2) {
              final lat = double.parse(coords[0].trim());
              final lon = double.parse(coords[1].trim());
              qrData = QRHelper.formatLocationQR(latitude: lat, longitude: lon);
            } else {
              throw FormatException('Geçersiz format');
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.invalidCoordinateFormat)),
            );
            return;
          }
        }
        // Konum adı girilmiş, Google Maps linki oluştur
        else {
          final encodedQuery = Uri.encodeComponent(locationInput);
          qrData = 'https://www.google.com/maps/search/?api=1&query=$encodedQuery';
        }
        break;
      case QRType.social:
        qrData = _profileUrlController.text;
        break;
    }

    setState(() {
      _generatedQRData = qrData;
    });
  }

  Future<void> _saveQR() async {
    if (_generatedQRData == null || !mounted) return;

    try {
      // QR kod widget'ını resme dönüştür ve byte array olarak al
      final boundary = _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      if (!mounted) return;

      // QR kod görüntüsü ile birlikte kaydet
      final provider = context.read<QRProvider>();
      final success = await provider.addGeneratedQR(
        content: _generatedQRData!,
        type: _selectedType,
        title: _getQRTitle(),
        qrImage: pngBytes, // QR kod görüntüsünü ekle!
      );

      if (!mounted) return;
      
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('QR kod kaydedildi'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kayıt hatası: $e')),
        );
      }
    }
  }

  String _getQRTitle() {
    final l10n = AppLocalizations.of(context)!;
    switch (_selectedType) {
      case QRType.url:
        return _urlController.text;
      case QRType.text:
        return _textController.text.substring(0, _textController.text.length > 30 ? 30 : _textController.text.length);
      case QRType.wifi:
        return _ssidController.text;
      case QRType.contact:
        return _nameController.text;
      case QRType.email:
        return _emailAddressController.text;
      case QRType.sms:
        return _smsPhoneController.text;
      case QRType.phone:
        return _phoneNumberController.text;
      case QRType.location:
        return l10n.locationTitle;
      case QRType.social:
        return _profileUrlController.text;
    }
  }

  Future<void> _shareQR() async {
    final l10n = AppLocalizations.of(context)!;
    if (_generatedQRData == null) return;
    
    try {
      // QR kod widget'ını resme dönüştür
      final boundary = _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();
      
      // Geçici dosya oluştur
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/qr_code.png');
      await file.writeAsBytes(pngBytes);
      
      // Paylaş
      // ignore: deprecated_member_use
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'QR Kod: ${_getQRTitle()}\n\n$_generatedQRData',
      );
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('QR kod paylaşıldı'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${l10n.shareError}: $e')),
        );
      }
    }
  }

  Widget _buildColorPicker() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.qrColorSettings,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        // QR Color
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.qrColor, style: const TextStyle(fontSize: 13)),
            const SizedBox(height: 6),
            _buildHorizontalColorSelector(
              selectedColor: _qrForegroundColor,
              onColorSelected: (color) {
                setState(() {
                  _qrForegroundColor = color;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Background Color
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.backgroundColor, style: const TextStyle(fontSize: 13)),
            const SizedBox(height: 6),
            _buildHorizontalColorSelector(
              selectedColor: _qrBackgroundColor,
              onColorSelected: (color) {
                setState(() {
                  _qrBackgroundColor = color;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Logo Selector
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.qrLogo, style: const TextStyle(fontSize: 13)),
            const SizedBox(height: 6),
            _buildLogoSelector(),
          ],
        ),
        const SizedBox(height: 12),
        // Eye Style Selector
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.eyeStyle, style: const TextStyle(fontSize: 13)),
            const SizedBox(height: 6),
            _buildEyeStyleSelector(),
          ],
        ),
        const SizedBox(height: 12),
        // Data Module Shape Selector
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.dataModuleShape, style: const TextStyle(fontSize: 13)),
            const SizedBox(height: 6),
            _buildDataModuleShapeSelector(),
          ],
        ),
        const SizedBox(height: 12),
        // Background Type Selector
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.backgroundStyle, style: const TextStyle(fontSize: 13)),
            const SizedBox(height: 6),
            _buildBackgroundTypeSelector(),
          ],
        ),
      ],
    );
  }

  Widget _buildHorizontalColorSelector({
    required Color selectedColor,
    required Function(Color) onColorSelected,
  }) {
    final colors = [
      Colors.black,
      Colors.white,
      Colors.red,
      Colors.purple,
      Colors.blue,
      Colors.teal,
      Colors.green,
      Colors.yellow,
      Colors.orange,
      Colors.grey,
    ];

    return SizedBox(
      height: 42,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        itemBuilder: (context, index) {
          final color = colors[index];
          final isSelected = selectedColor == color;
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => onColorSelected(color),
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected 
                        ? AppColors.primary 
                        : Theme.of(context).brightness == Brightness.dark
                            ? Colors.white.withValues(alpha: 0.2)
                            : Colors.black.withValues(alpha: 0.15),
                    width: isSelected ? 3 : 1.5,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.4),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ]
                      : null,
                ),
                child: isSelected
                    ? Icon(
                        Icons.check,
                        color: color == Colors.white || color == Colors.yellow
                            ? Colors.black
                            : Colors.white,
                        size: 16,
                      )
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLogoSelector() {
    final l10n = AppLocalizations.of(context)!;
    
    // Hazır logolar (asset paths)
    final presetLogos = {
      'assets/logos/instagram.png': 'Instagram',
      'assets/logos/facebook.png': 'Facebook',
      'assets/logos/twitter.png': 'Twitter',
      'assets/logos/linkedin.png': 'LinkedIn',
      'assets/logos/youtube.png': 'YouTube',
      'assets/logos/tiktok.png': 'TikTok',
      'assets/logos/WhatsApp.png': 'WhatsApp',
      'assets/logos/telegram.png': 'Telegram',
    };

    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: presetLogos.length + 1, // +1 for "None"
        itemBuilder: (context, index) {
          // İlk item: Logo Yok
          if (index == 0) {
            final isSelected = _selectedLogo == null;
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedLogo = null;
                  });
                },
                child: Container(
                  width: 70,
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? AppColors.primary.withValues(alpha: 0.12)
                        : Theme.of(context).brightness == Brightness.dark
                            ? Colors.white.withValues(alpha: 0.05)
                            : Colors.black.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected 
                          ? AppColors.primary 
                          : Theme.of(context).brightness == Brightness.dark
                              ? Colors.white.withValues(alpha: 0.1)
                              : Colors.black.withValues(alpha: 0.08),
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.block,
                        color: isSelected ? AppColors.primary : Colors.grey.shade600,
                        size: 28,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.none,
                        style: TextStyle(
                          fontSize: 11,
                          color: isSelected ? AppColors.primary : Colors.grey.shade700,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          
          // Preset logolar
          final logoIndex = index - 1;
          final logoPath = presetLogos.keys.elementAt(logoIndex);
          final logoName = presetLogos[logoPath]!;
          final isSelected = _selectedLogo == logoPath;
          
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedLogo = logoPath;
                });
              },
              child: Container(
                width: 70,
                decoration: BoxDecoration(
                  color: isSelected 
                      ? AppColors.primary.withValues(alpha: 0.12)
                      : Theme.of(context).brightness == Brightness.dark
                          ? Colors.white.withValues(alpha: 0.05)
                          : Colors.black.withValues(alpha: 0.03),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected 
                        ? AppColors.primary 
                        : Theme.of(context).brightness == Brightness.dark
                            ? Colors.white.withValues(alpha: 0.1)
                            : Colors.black.withValues(alpha: 0.08),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Asset image
                    Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.transparent, 
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset(
                        logoPath,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          // Debug: logo yüklenemedi
                          debugPrint('Logo yüklenemedi: $logoPath - Error: $error');
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 20,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Error',
                                style: TextStyle(fontSize: 8, color: Colors.red),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      logoName,
                      style: TextStyle(
                        fontSize: 10,
                        color: isSelected ? AppColors.primary : Colors.grey.shade700,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEyeStyleSelector() {
    final l10n = AppLocalizations.of(context)!;
    final eyeStyles = {
      'square': (l10n.square, Icons.crop_square),
      'circle': (l10n.circle, Icons.circle_outlined),
      'rounded': ('Rounded', Icons.rounded_corner), // ✨ Custom Painter ile artık gerçek rounded!
    };

    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: eyeStyles.length,
        itemBuilder: (context, index) {
          final styleKey = eyeStyles.keys.elementAt(index);
          final style = eyeStyles[styleKey]!;
          final isSelected = _eyeStyle == styleKey;
          
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _eyeStyle = styleKey;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? AppColors.primary.withValues(alpha: 0.12)
                      : Theme.of(context).brightness == Brightness.dark
                          ? Colors.white.withValues(alpha: 0.05)
                          : Colors.black.withValues(alpha: 0.03),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected 
                        ? AppColors.primary 
                        : Theme.of(context).brightness == Brightness.dark
                            ? Colors.white.withValues(alpha: 0.1)
                            : Colors.black.withValues(alpha: 0.08),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      style.$2,
                      color: isSelected ? AppColors.primary : Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.grey.shade600,
                      size: 24,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      style.$1,
                      style: TextStyle(
                        fontSize: 11,
                        color: isSelected ? AppColors.primary : Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.grey.shade700,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDataModuleShapeSelector() {
    final l10n = AppLocalizations.of(context)!;
    // Body Shape patterns - Screenshot'taki gibi görsel preview ile!
    final shapes = {
      'square': (l10n.square, _buildShapePreviewIcon('square')),
      'circle': (l10n.circle, _buildShapePreviewIcon('circle')),
      'rounded': ('Rounded', _buildShapePreviewIcon('rounded')), // 🆕 YENİ!
    };

    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: shapes.length,
        itemBuilder: (context, index) {
          final shapeKey = shapes.keys.elementAt(index);
          final shape = shapes[shapeKey]!;
          final isSelected = _dataModuleShape == shapeKey;
          
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _dataModuleShape = shapeKey;
                });
              },
              child: Container(
                width: 70,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? AppColors.primary.withValues(alpha: 0.12)
                      : Theme.of(context).brightness == Brightness.dark
                          ? Colors.white.withValues(alpha: 0.05)
                          : Colors.black.withValues(alpha: 0.03),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected 
                        ? AppColors.primary 
                        : Theme.of(context).brightness == Brightness.dark
                            ? Colors.white.withValues(alpha: 0.1)
                            : Colors.black.withValues(alpha: 0.08),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Pattern Preview (Screenshot tarzı)
                    shape.$2,
                    const SizedBox(height: 4),
                    Text(
                      shape.$1,
                      style: TextStyle(
                        fontSize: 10,
                        color: isSelected ? AppColors.primary : Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.grey.shade700,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Body Shape preview widget - Screenshot'taki gibi pattern gösterimi
  Widget _buildShapePreviewIcon(String shapeType) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dotColor = isDark ? Colors.white70 : Colors.grey.shade800;
    
    if (shapeType == 'circle') {
      // Circle pattern preview
      return SizedBox(
        width: 40,
        height: 24,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(4, (i) => 
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      );
    } else if (shapeType == 'rounded') {
      // Rounded pattern preview
      return SizedBox(
        width: 40,
        height: 24,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(4, (i) => 
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: dotColor,
                borderRadius: BorderRadius.circular(1.5), // Yumuşak köşeler
              ),
            ),
          ),
        ),
      );
    } else {
      // Square pattern preview (default)
      return SizedBox(
        width: 40,
        height: 24,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(4, (i) => 
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.rectangle,
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget _buildBackgroundTypeSelector() {
    final l10n = AppLocalizations.of(context)!;
    
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _backgroundType == 'gradient' ? 16 : 1, // Color veya 15 gradient
        itemBuilder: (context, index) {
          // İlk item her zaman "Color" toggle
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Row(
                children: [
                  // Color Button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _backgroundType = 'color';
                      });
                    },
                    child: Container(
                      width: 70,
                      decoration: BoxDecoration(
                        color: _backgroundType == 'color' 
                            ? AppColors.primary.withValues(alpha: 0.12)
                            : Theme.of(context).brightness == Brightness.dark
                                ? Colors.white.withValues(alpha: 0.05)
                                : Colors.black.withValues(alpha: 0.03),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _backgroundType == 'color' 
                              ? AppColors.primary 
                              : Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white.withValues(alpha: 0.1)
                                  : Colors.black.withValues(alpha: 0.08),
                          width: _backgroundType == 'color' ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.palette,
                            color: _backgroundType == 'color' ? AppColors.primary : Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.grey.shade600,
                            size: 28,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.qrColor,
                            style: TextStyle(
                              fontSize: 11,
                              color: _backgroundType == 'color' ? AppColors.primary : Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.grey.shade700,
                              fontWeight: _backgroundType == 'color' ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Gradient Button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _backgroundType = 'gradient';
                        if (_selectedGradient == 'none') {
                          _selectedGradient = 'instagram';
                        }
                      });
                    },
                    child: Container(
                      width: 70,
                      decoration: BoxDecoration(
                        color: _backgroundType == 'gradient' 
                            ? AppColors.primary.withValues(alpha: 0.12)
                            : Theme.of(context).brightness == Brightness.dark
                                ? Colors.white.withValues(alpha: 0.05)
                                : Colors.black.withValues(alpha: 0.03),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _backgroundType == 'gradient' 
                              ? AppColors.primary 
                              : Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white.withValues(alpha: 0.1)
                                  : Colors.black.withValues(alpha: 0.08),
                          width: _backgroundType == 'gradient' ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.gradient,
                            color: _backgroundType == 'gradient' ? AppColors.primary : Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.grey.shade600,
                            size: 28,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.gradient,
                            style: TextStyle(
                              fontSize: 11,
                              color: _backgroundType == 'gradient' ? AppColors.primary : Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.grey.shade700,
                              fontWeight: _backgroundType == 'gradient' ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          
          // Gradient seçenekleri (sadece gradient modundayken göster) - Vibrant & Colorful!
          final gradients = {
            'instagram': ('Instagram', [const Color(0xFFf09433), const Color(0xFFe6683c), const Color(0xFFdc2743), const Color(0xFFcc2366), const Color(0xFFbc1888)]),
            'tiktok': ('TikTok', [const Color(0xFF000000), const Color(0xFFFF0050), const Color(0xFF00F2EA), const Color(0xFFFFFFFF)]),
            'facebook': ('Facebook', [const Color(0xFF0084ff), const Color(0xFF00C6FF), const Color(0xFF0051ff), const Color(0xFF667eea)]),
            'whatsapp': ('WhatsApp', [const Color(0xFF25D366), const Color(0xFF128C7E), const Color(0xFF075E54), const Color(0xFF00BFA5)]),
            'telegram': ('Telegram', [const Color(0xFF0088cc), const Color(0xFF00579C), const Color(0xFF64B5F6), const Color(0xFF2196F3)]),
            'youtube': ('YouTube', [const Color(0xFFFF0000), const Color(0xFFFF5722), const Color(0xFFFF6F00), const Color(0xFF8B0000)]),
            'spotify': ('Spotify', [const Color(0xFF1DB954), const Color(0xFF1ED760), const Color(0xFF191414), const Color(0xFF535353)]),
            'linkedin': ('LinkedIn', [const Color(0xFF0077B5), const Color(0xFF00A0DC), const Color(0xFF004471), const Color(0xFF0073B1)]),
            'twitter': ('Twitter', [const Color(0xFF1DA1F2), const Color(0xFF14B8FF), const Color(0xFF0e71c8), const Color(0xFF2196F3)]),
            'netflix': ('Netflix', [const Color(0xFFE50914), const Color(0xFFFF0000), const Color(0xFF8B0000), const Color(0xFF000000)]),
            'sunset': ('Sunset', [const Color(0xFFFF512F), const Color(0xFFFF8C42), const Color(0xFFDD2476), const Color(0xFFFF6B6B)]),
            'ocean': ('Ocean', [const Color(0xFF2E3192), const Color(0xFF1BFFFF), const Color(0xFF00D4FF), const Color(0xFF0099CC)]),
            'fire': ('Fire', [const Color(0xFFf12711), const Color(0xFFf5af19), const Color(0xFFFF6B6B), const Color(0xFFFF9500)]),
            'purple': ('Purple Dream', [const Color(0xFF667eea), const Color(0xFF764ba2), const Color(0xFFa8edea), const Color(0xFFfed6e3)]),
            'mint': ('Mint Fresh', [const Color(0xFF00b09b), const Color(0xFF96c93d), const Color(0xFF00D9A3), const Color(0xFFB4EC51)]),
          };
          
          final gradientIndex = index - 1;
          final gradientKey = gradients.keys.elementAt(gradientIndex);
          final gradient = gradients[gradientKey]!;
          final isSelected = _selectedGradient == gradientKey;
          
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedGradient = gradientKey;
                });
              },
              child: Container(
                width: 70,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradient.$2,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected 
                        ? AppColors.primary 
                        : Colors.white.withValues(alpha: 0.3),
                    width: isSelected ? 3 : 1.5,
                  ),
                  boxShadow: isSelected ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ] : null,
                ),
                child: Center(
                  child: Text(
                    gradient.$1,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [Shadow(color: Colors.black45, blurRadius: 2)],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Helper methods - Vibrant Multi-Color Gradients!
  LinearGradient _getSelectedGradient() {
    final gradients = {
      'instagram': const LinearGradient(
        colors: [Color(0xFFf09433), Color(0xFFe6683c), Color(0xFFdc2743), Color(0xFFcc2366), Color(0xFFbc1888)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      'tiktok': const LinearGradient(
        colors: [Color(0xFF000000), Color(0xFFFF0050), Color(0xFF00F2EA), Color(0xFFFFFFFF)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      'facebook': const LinearGradient(
        colors: [Color(0xFF0084ff), Color(0xFF00C6FF), Color(0xFF0051ff), Color(0xFF667eea)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      'whatsapp': const LinearGradient(
        colors: [Color(0xFF25D366), Color(0xFF128C7E), Color(0xFF075E54), Color(0xFF00BFA5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      'telegram': const LinearGradient(
        colors: [Color(0xFF0088cc), Color(0xFF00579C), Color(0xFF64B5F6), Color(0xFF2196F3)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      'youtube': const LinearGradient(
        colors: [Color(0xFFFF0000), Color(0xFFFF5722), Color(0xFFFF6F00), Color(0xFF8B0000)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      'spotify': const LinearGradient(
        colors: [Color(0xFF1DB954), Color(0xFF1ED760), Color(0xFF191414), Color(0xFF535353)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      'linkedin': const LinearGradient(
        colors: [Color(0xFF0077B5), Color(0xFF00A0DC), Color(0xFF004471), Color(0xFF0073B1)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      'twitter': const LinearGradient(
        colors: [Color(0xFF1DA1F2), Color(0xFF14B8FF), Color(0xFF0e71c8), Color(0xFF2196F3)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      'netflix': const LinearGradient(
        colors: [Color(0xFFE50914), Color(0xFFFF0000), Color(0xFF8B0000), Color(0xFF000000)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      'sunset': const LinearGradient(
        colors: [Color(0xFFFF512F), Color(0xFFFF8C42), Color(0xFFDD2476), Color(0xFFFF6B6B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      'ocean': const LinearGradient(
        colors: [Color(0xFF2E3192), Color(0xFF1BFFFF), Color(0xFF00D4FF), Color(0xFF0099CC)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      'fire': const LinearGradient(
        colors: [Color(0xFFf12711), Color(0xFFf5af19), Color(0xFFFF6B6B), Color(0xFFFF9500)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      'purple': const LinearGradient(
        colors: [Color(0xFF667eea), Color(0xFF764ba2), Color(0xFFa8edea), Color(0xFFfed6e3)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      'mint': const LinearGradient(
        colors: [Color(0xFF00b09b), Color(0xFF96c93d), Color(0xFF00D9A3), Color(0xFFB4EC51)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    };
    return gradients[_selectedGradient] ?? gradients['instagram']!;
  }

  // Get combined shape for pretty_qr_code
  // NOT: pretty_qr_code'da eye ve data module ayrı customization yok
  // Tek shape parametresi hem eye'ları hem module'leri etkiliyor
  PrettyQrSmoothSymbol _getCombinedShape() {
    // Eye style öncelikli (daha belirgin ve önemli)
    double roundFactor = 0.0;
    
    // Eye style belirleme
    if (_eyeStyle == 'circle') {
      roundFactor = 1.0; // Tam yuvarlak
    } else if (_eyeStyle == 'rounded') {
      roundFactor = 0.5; // Yumuşak
    } else {
      // Square eye - data module shape'e bak
      if (_dataModuleShape == 'circle') {
        roundFactor = 1.0;
      } else if (_dataModuleShape == 'rounded') {
        roundFactor = 0.5;
      } else {
        roundFactor = 0.0; // Tam kare
      }
    }
    
    return PrettyQrSmoothSymbol(
      color: _qrForegroundColor,
      roundFactor: roundFactor,
    );
  }

}
