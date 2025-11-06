import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.termsOfServiceTitle),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            title: AppLocalizations.of(context)!.tosSection1Title,
            content: AppLocalizations.of(context)!.tosSection1Content,
          ),
          _buildSection(
            title: AppLocalizations.of(context)!.tosSection2Title,
            content: AppLocalizations.of(context)!.tosSection2Content,
          ),
          _buildSection(
            title: AppLocalizations.of(context)!.tosSection3Title,
            content: AppLocalizations.of(context)!.tosSection3Content,
          ),
          _buildSection(
            title: AppLocalizations.of(context)!.tosSection4Title,
            content: AppLocalizations.of(context)!.tosSection4Content,
          ),
          _buildSection(
            title: AppLocalizations.of(context)!.tosSection5Title,
            content: AppLocalizations.of(context)!.tosSection5Content,
          ),
          _buildSection(
            title: AppLocalizations.of(context)!.tosSection6Title,
_            content: AppLocalizations.of(context)!.tosSection6Content,
          ),
          _buildSection(
            title: AppLocalizations.of(context)!.tosSection7Title,
            content: AppLocalizations.of(context)!.tosSection7Content,
          ),
          _buildSection(
            title: AppLocalizations.of(context)!.tosSection8Title,
            content: AppLocalizations.of(context)!.tosSection8Content,
          ),
          _buildSection(
            title: AppLocalizations.of(context)!.tosSection9Title,
            content: AppLocalizations.of(context)!.tosSection9Content,
          ),
          _buildSection(
            title: AppLocalizations.of(context)!.tosSection10Title,
            content: AppLocalizations.of(context)!.tosSection10Content,
          ),
          _buildSection(
            title: AppLocalizations.of(context)!.tosSection11Title,
            content: AppLocalizations.of(context)!.tosSection11Content,
          ),
          _buildSection(
            title: AppLocalizations.of(context)!.tosSection12Title,
            content: AppLocalizations.of(context)!.tosSection12Content,
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
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
