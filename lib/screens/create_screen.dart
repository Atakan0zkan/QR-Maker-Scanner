import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
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
  String? _selectedLogo; // asset path veya 'gallery'
  File? _customLogoFile; // Galeriden seçilen dosya

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
    return TextFormField(
      controller: _textController,
      decoration: const InputDecoration(
        labelText: 'Metin',
        hintText: 'Metninizi girin',
        prefixIcon: Icon(Icons.text_fields),
      ),
      maxLines: 5,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Metin gerekli';
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
    return Column(
      children: [
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'İsim',
            prefixIcon: Icon(Icons.person),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'İsim gerekli';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _phoneController,
          decoration: const InputDecoration(
            labelText: 'Telefon',
            prefixIcon: Icon(Icons.phone),
          ),
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'E-posta',
            prefixIcon: Icon(Icons.email),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }

  Widget _buildEmailForm() {
    return Column(
      children: [
        TextFormField(
          controller: _emailAddressController,
          decoration: const InputDecoration(
            labelText: 'E-posta Adresi',
            prefixIcon: Icon(Icons.email),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'E-posta gerekli';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _subjectController,
          decoration: const InputDecoration(
            labelText: 'Konu (Opsiyonel)',
            prefixIcon: Icon(Icons.subject),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _messageController,
          decoration: const InputDecoration(
            labelText: 'Mesaj (Opsiyonel)',
            prefixIcon: Icon(Icons.message),
          ),
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildSMSForm() {
    return Column(
      children: [
        TextFormField(
          controller: _smsPhoneController,
          decoration: const InputDecoration(
            labelText: 'Telefon Numarası',
            prefixIcon: Icon(Icons.phone),
          ),
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Telefon numarası gerekli';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _smsMessageController,
          decoration: const InputDecoration(
            labelText: 'Mesaj (Opsiyonel)',
            prefixIcon: Icon(Icons.message),
          ),
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildPhoneForm() {
    return TextFormField(
      controller: _phoneNumberController,
      decoration: const InputDecoration(
        labelText: 'Telefon Numarası',
        prefixIcon: Icon(Icons.phone),
      ),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Telefon numarası gerekli';
        }
        return null;
      },
    );
  }

  Widget _buildLocationForm() {
    return Column(
      children: [
        TextFormField(
          controller: _latitudeController,
          decoration: InputDecoration(
            labelText: 'Konum Ara (Google Maps)',
            hintText: 'Örn: Galata Kulesi, İstanbul',
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
              return 'Konum gerekli';
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
          title: const Text('Veya Koordinat Gir'),
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
    final query = _latitudeController.text.trim();
    if (query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen bir konum adı girin')),
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
          const SnackBar(content: Text('Google Maps açılamadı')),
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            RepaintBoundary(
              key: _qrKey,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _qrBackgroundColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                child: QrImageView(
                  data: _generatedQRData!,
                  version: QrVersions.auto,
                  size: 250,
                  backgroundColor: _qrBackgroundColor,
                  eyeStyle: QrEyeStyle(
                    eyeShape: QrEyeShape.square,
                    color: _qrForegroundColor,
                  ),
                  dataModuleStyle: QrDataModuleStyle(
                    dataModuleShape: QrDataModuleShape.square,
                    color: _qrForegroundColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildColorPicker(),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _saveQR,
                  icon: const Icon(Icons.save),
                  label: const Text('Kaydet'),
                ),
                OutlinedButton.icon(
                  onPressed: _shareQR,
                  icon: const Icon(Icons.share),
                  label: const Text('Paylaş'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _generateQR() {
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
              const SnackBar(content: Text('Geçersiz koordinat formatı. Örnek: 41.0082, 28.9784')),
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

  void _saveQR() {
    if (_generatedQRData == null) return;

    context.read<QRProvider>().addGeneratedQR(
      content: _generatedQRData!,
      type: _selectedType,
      title: _getQRTitle(),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('QR kod kaydedildi'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  String _getQRTitle() {
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
        return 'Konum';
      case QRType.social:
        return _profileUrlController.text;
    }
  }

  Future<void> _shareQR() async {
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
          SnackBar(content: Text('Paylaşım hatası: $e')),
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
        const SizedBox(height: 16),
        // QR Color
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.qrColor, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
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
        const SizedBox(height: 16),
        // Background Color
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.backgroundColor, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
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
        const SizedBox(height: 16),
        // Logo Selector
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.qrLogo, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
            _buildLogoSelector(),
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
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        itemBuilder: (context, index) {
          final color = colors[index];
          final isSelected = selectedColor == color;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => onColorSelected(color),
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? AppColors.primary : Colors.grey.shade300,
                    width: isSelected ? 3 : 1,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 8,
                            spreadRadius: 2,
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
                        size: 20,
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
      'assets/logos/whatsapp.png': 'WhatsApp',
      'assets/logos/telegram.png': 'Telegram',
    };

    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: presetLogos.length + 2, // +2 for "None" and "Gallery"
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
                    _customLogoFile = null;
                  });
                },
                child: Container(
                  width: 70,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : Colors.grey.shade300,
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
          
          // Son item: Galeriden Seç
          if (index == presetLogos.length + 1) {
            final isSelected = _selectedLogo == 'gallery';
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap: () async {
                  // TODO: Image picker eklenecek
                  setState(() {
                    _selectedLogo = 'gallery';
                  });
                },
                child: Container(
                  width: 70,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : Colors.grey.shade300,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_photo_alternate,
                        color: isSelected ? AppColors.primary : Colors.grey.shade600,
                        size: 28,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.gallery,
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
                  _customLogoFile = null;
                });
              },
              child: Container(
                width: 70,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : Colors.grey.shade300,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // TODO: Asset image eklenecek
                    Icon(
                      Icons.image,
                      color: isSelected ? AppColors.primary : Colors.grey.shade600,
                      size: 32,
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
}
