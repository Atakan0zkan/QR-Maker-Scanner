import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:feedback/feedback.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../providers/locale_provider.dart';
import '../core/constants/app_colors.dart';
import '../l10n/app_localizations.dart';
import '../services/feedback_service.dart';
import 'privacy_policy_screen.dart';
import 'terms_of_service_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.settings,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            context,
            title: l10n.general,
            children: [
              _buildLanguageTile(context),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            context,
            title: l10n.privacy,
            children: [
              _buildSettingTile(
                context,
                icon: Icons.shield_outlined,
                title: l10n.privacyPolicy,
                subtitle: l10n.viewPrivacyPolicy,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PrivacyPolicyScreen(),
                    ),
                  );
                },
              ),
              _buildSettingTile(
                context,
                icon: Icons.description_outlined,
                title: l10n.termsOfService,
                subtitle: l10n.viewTermsOfService,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TermsOfServiceScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            context,
            title: l10n.about,
            children: [
              FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  final version = snapshot.hasData
                      ? '${snapshot.data!.version} (${snapshot.data!.buildNumber})'
                      : '...';
                  return _buildSettingTile(
                    context,
                    icon: Icons.info_outline,
                    title: l10n.version,
                    subtitle: version,
                    onTap: null,
                  );
                },
              ),
              _buildSettingTile(
                context,
                icon: Icons.bug_report_outlined,
                title: l10n.bugReport,
                subtitle: '',
                onTap: () {
                  BetterFeedback.of(context).show((UserFeedback feedback) async {
                    // Show loading
                    if (context.mounted) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    
                    // Send feedback
                    final success = await FeedbackService.sendFeedback(
                      userFeedback: feedback.text,
                      screenshot: feedback.screenshot,
                    );
                    
                    // Close loading
                    if (context.mounted) {
                      Navigator.pop(context);
                      
                      // Show result
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            success
                                ? l10n.feedbackSent
                                : '❌ ${l10n.emailAppCannotOpen}',
                          ),
                          backgroundColor: success ? Colors.green : Colors.red,
                        ),
                      );
                    }
                  });
                },
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
          color: AppColors.primary.withValues(alpha: 0.1),
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

  Widget _buildLanguageTile(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, _) {
        final currentLocale = localeProvider.locale?.languageCode ?? 'en';
        return ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.language_outlined,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          title: Text(AppLocalizations.of(context)!.language),
          subtitle: Text(_getLanguageLabel(currentLocale)),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showLanguageDialog(context, localeProvider),
        );
      },
    );
  }

  String _getLanguageLabel(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'tr':
        return 'Türkçe';
      case 'es':
        return 'Español';
      case 'de':
        return 'Deutsch';
      case 'fr':
        return 'Français';
      case 'it':
        return 'Italiano';
      case 'el':
        return 'Ελληνικά';
      case 'ar':
        return 'العربية';
      case 'zh':
        return '中文';
      case 'ja':
        return '日本語';
      default:
        return 'English';
    }
  }

  void _showLanguageDialog(BuildContext context, LocaleProvider localeProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.selectLanguage),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: LocaleProvider.supportedLanguages.map((langCode) {
              final isSelected = localeProvider.locale?.languageCode == langCode;
              return ListTile(
                title: Text(_getLanguageLabel(langCode)),
                trailing: isSelected
                    ? const Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () {
                  localeProvider.setLocale(Locale(langCode));
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

}
