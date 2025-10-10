import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Kod Oluştur'),
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
                child: const Text('Oluştur'),
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kod Türü',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<QRType>(
              value: _selectedType,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              items: const [
                DropdownMenuItem(value: QRType.url, child: Text('URL')),
                DropdownMenuItem(value: QRType.text, child: Text('Metin')),
                DropdownMenuItem(value: QRType.wifi, child: Text('WiFi')),
                DropdownMenuItem(value: QRType.contact, child: Text('Kişi')),
                DropdownMenuItem(value: QRType.email, child: Text('E-posta')),
                DropdownMenuItem(value: QRType.sms, child: Text('SMS')),
                DropdownMenuItem(value: QRType.phone, child: Text('Telefon')),
                DropdownMenuItem(value: QRType.location, child: Text('Konum')),
                DropdownMenuItem(value: QRType.social, child: Text('Sosyal Medya')),
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
    return Column(
      children: [
        TextFormField(
          controller: _ssidController,
          decoration: const InputDecoration(
            labelText: 'Ağ Adı (SSID)',
            prefixIcon: Icon(Icons.wifi),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'SSID gerekli';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _passwordController,
          decoration: const InputDecoration(
            labelText: 'Şifre',
            prefixIcon: Icon(Icons.lock),
          ),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: _securityType,
          decoration: const InputDecoration(
            labelText: 'Güvenlik Türü',
            prefixIcon: Icon(Icons.security),
          ),
          items: const [
            DropdownMenuItem(value: 'WPA', child: Text('WPA/WPA2')),
            DropdownMenuItem(value: 'WEP', child: Text('WEP')),
            DropdownMenuItem(value: 'nopass', child: Text('Yok')),
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
        const SizedBox(height: 16),
        TextFormField(
          controller: _companyController,
          decoration: const InputDecoration(
            labelText: 'Şirket (Opsiyonel)',
            prefixIcon: Icon(Icons.business),
          ),
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
          decoration: const InputDecoration(
            labelText: 'Enlem (Latitude)',
            prefixIcon: Icon(Icons.location_on),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enlem gerekli';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _longitudeController,
          decoration: const InputDecoration(
            labelText: 'Boylam (Longitude)',
            prefixIcon: Icon(Icons.location_on),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Boylam gerekli';
            }
            return null;
          },
        ),
      ],
    );
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
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: QrImageView(
                data: _generatedQRData!,
                version: QrVersions.auto,
                size: 250,
                backgroundColor: Colors.white,
              ),
            ),
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
          company: _companyController.text.isEmpty ? null : _companyController.text,
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
        try {
          qrData = QRHelper.formatLocationQR(
            latitude: double.parse(_latitudeController.text),
            longitude: double.parse(_longitudeController.text),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Geçersiz koordinat formatı')),
          );
          return;
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

  void _shareQR() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Paylaşım özelliği yakında eklenecek')),
    );
  }
}
