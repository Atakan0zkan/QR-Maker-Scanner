import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.privacyPolicyTitle), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            title: l10n.ppSection1Title,
            content: l10n.ppSection1Content,
          ),
          _buildSection(
            title: l10n.ppSection2Title,
            content: l10n.ppSection2Content,
          ),
          _buildSection(
            title: l10n.ppSection3Title,
            content: l10n.ppSection3Content,
          ),
          _buildSection(
            title: l10n.ppSection4Title,
            content: l10n.ppSection4Content,
          ),
          _buildSection(
            title: l10n.ppSection5Title,
            content: l10n.ppSection5Content,
          ),
          _buildSection(
            title: l10n.ppSection6Title,
            content: l10n.ppSection6Content,
          ),
          _buildSection(
            title: l10n.ppSection7Title,
            content: l10n.ppSection7Content,
          ),
          _buildSection(
            title: l10n.ppSection8Title,
            content: l10n.ppSection8Content,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(content, style: const TextStyle(fontSize: 14, height: 1.5)),
        const SizedBox(height: 24),
      ],
    );
  }
}
