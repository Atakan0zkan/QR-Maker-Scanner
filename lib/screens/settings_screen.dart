import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../core/constants/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            context,
            title: 'Genel',
            children: [
              _buildSettingTile(
                context,
                icon: Icons.notifications_outlined,
                title: 'Bildirimler',
                subtitle: 'Uygulama içi bildirimleri yönetin',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Bildirim ayarları yakında eklenecek')),
                  );
                },
              ),
              _buildSettingTile(
                context,
                icon: Icons.language,
                title: 'Dil',
                subtitle: 'Uygulama dilini değiştirin',
                onTap: () => _showLanguageDialog(context),
              ),
              _buildThemeTile(context),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            context,
            title: 'Gizlilik',
            children: [
              _buildSettingTile(
                context,
                icon: Icons.shield_outlined,
                title: 'Gizlilik Politikası',
                subtitle: 'Gizlilik politikasını görüntüleyin',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Gizlilik politikası yakında eklenecek')),
                  );
                },
              ),
              _buildSettingTile(
                context,
                icon: Icons.description_outlined,
                title: 'Hizmet Şartları',
                subtitle: 'Kullanım koşullarını görüntüleyin',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Hizmet şartları yakında eklenecek')),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            context,
            title: 'Hakkında',
            children: [
              _buildSettingTile(
                context,
                icon: Icons.info_outline,
                title: 'Sürüm',
                subtitle: '1.0.0',
                onTap: null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        Card(
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: AppColors.primary,
          size: 24,
        ),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: onTap != null ? const Icon(Icons.chevron_right) : null,
      onTap: onTap,
    );
  }

  Widget _buildThemeTile(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.brightness_6_outlined,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          title: const Text('Tema'),
          subtitle: Text(_getThemeLabel(themeProvider.themeMode)),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showThemeDialog(context, themeProvider),
        );
      },
    );
  }

  String _getThemeLabel(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Açık';
      case ThemeMode.dark:
        return 'Koyu';
      case ThemeMode.system:
        return 'Sistem';
    }
  }

  void _showThemeDialog(BuildContext context, ThemeProvider themeProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tema Seç'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<ThemeMode>(
              title: const Text('Açık'),
              value: ThemeMode.light,
              groupValue: themeProvider.themeMode,
              onChanged: (value) {
                themeProvider.setThemeMode(value!);
                Navigator.pop(context);
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('Koyu'),
              value: ThemeMode.dark,
              groupValue: themeProvider.themeMode,
              onChanged: (value) {
                themeProvider.setThemeMode(value!);
                Navigator.pop(context);
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('Sistem'),
              value: ThemeMode.system,
              groupValue: themeProvider.themeMode,
              onChanged: (value) {
                themeProvider.setThemeMode(value!);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    final languages = {
      'tr': 'Türkçe',
      'en': 'English',
      'es': 'Español',
      'de': 'Deutsch',
      'fr': 'Français',
      'it': 'Italiano',
      'el': 'Ελληνικά',
    };

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Dil Seç'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: languages.entries.map((entry) {
            return ListTile(
              title: Text(entry.value),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${entry.value} seçildi')),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
