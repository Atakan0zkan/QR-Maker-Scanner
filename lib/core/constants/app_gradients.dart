import 'package:flutter/material.dart';

/// Merkezi gradient tanımları.
/// create_screen.dart'taki 4x tekrarlanan gradient tanımlarını tek noktada toplar.
class GradientPreset {
  final String label;
  final List<Color> colors;
  final Alignment begin;
  final Alignment end;

  const GradientPreset({
    required this.label,
    required this.colors,
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
  });

  /// Background gradient — her preset'in kendi alignment'ını kullanır.
  LinearGradient toBackgroundGradient() {
    return LinearGradient(colors: colors, begin: begin, end: end);
  }

  /// QR gradient — her zaman topLeft→bottomRight.
  LinearGradient toQrGradient() {
    return LinearGradient(
      colors: colors,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  /// Preview gradient — ChoiceChip'lerde kullanılır.
  LinearGradient toPreviewGradient() {
    return LinearGradient(
      colors: colors,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}

class AppGradients {
  AppGradients._();

  /// Tüm preset gradient'ler — tek kaynak.
  static const Map<String, GradientPreset> presets = {
    'instagram': GradientPreset(
      label: 'Instagram',
      colors: [
        Color(0xFFf09433),
        Color(0xFFe6683c),
        Color(0xFFdc2743),
        Color(0xFFcc2366),
        Color(0xFFbc1888),
      ],
    ),
    'tiktok': GradientPreset(
      label: 'TikTok',
      colors: [
        Color(0xFF000000),
        Color(0xFFFF0050),
        Color(0xFF00F2EA),
        Color(0xFFFFFFFF),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    'facebook': GradientPreset(
      label: 'Facebook',
      colors: [
        Color(0xFF0084ff),
        Color(0xFF00C6FF),
        Color(0xFF0051ff),
        Color(0xFF667eea),
      ],
    ),
    'whatsapp': GradientPreset(
      label: 'WhatsApp',
      colors: [
        Color(0xFF25D366),
        Color(0xFF128C7E),
        Color(0xFF075E54),
        Color(0xFF00BFA5),
      ],
    ),
    'telegram': GradientPreset(
      label: 'Telegram',
      colors: [
        Color(0xFF0088cc),
        Color(0xFF00579C),
        Color(0xFF64B5F6),
        Color(0xFF2196F3),
      ],
    ),
    'youtube': GradientPreset(
      label: 'YouTube',
      colors: [
        Color(0xFFFF0000),
        Color(0xFFFF5722),
        Color(0xFFFF6F00),
        Color(0xFF8B0000),
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    'spotify': GradientPreset(
      label: 'Spotify',
      colors: [
        Color(0xFF1DB954),
        Color(0xFF1ED760),
        Color(0xFF191414),
        Color(0xFF535353),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    'linkedin': GradientPreset(
      label: 'LinkedIn',
      colors: [
        Color(0xFF0077B5),
        Color(0xFF00A0DC),
        Color(0xFF004471),
        Color(0xFF0073B1),
      ],
    ),
    'twitter': GradientPreset(
      label: 'Twitter',
      colors: [
        Color(0xFF1DA1F2),
        Color(0xFF14B8FF),
        Color(0xFF0e71c8),
        Color(0xFF2196F3),
      ],
    ),
    'netflix': GradientPreset(
      label: 'Netflix',
      colors: [
        Color(0xFFE50914),
        Color(0xFFFF0000),
        Color(0xFF8B0000),
        Color(0xFF000000),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    'sunset': GradientPreset(
      label: 'Sunset',
      colors: [
        Color(0xFFFF512F),
        Color(0xFFFF8C42),
        Color(0xFFDD2476),
        Color(0xFFFF6B6B),
      ],
    ),
    'ocean': GradientPreset(
      label: 'Ocean',
      colors: [
        Color(0xFF2E3192),
        Color(0xFF1BFFFF),
        Color(0xFF00D4FF),
        Color(0xFF0099CC),
      ],
    ),
    'fire': GradientPreset(
      label: 'Fire',
      colors: [
        Color(0xFFf12711),
        Color(0xFFf5af19),
        Color(0xFFFF6B6B),
        Color(0xFFFF9500),
      ],
    ),
    'purple': GradientPreset(
      label: 'Purple Dream',
      colors: [
        Color(0xFF667eea),
        Color(0xFF764ba2),
        Color(0xFFa8edea),
        Color(0xFFfed6e3),
      ],
    ),
    'mint': GradientPreset(
      label: 'Mint Fresh',
      colors: [
        Color(0xFF00b09b),
        Color(0xFF96c93d),
        Color(0xFF00D9A3),
        Color(0xFFB4EC51),
      ],
    ),
  };

  /// Background gradient — per-gradient alignment kullanır.
  static LinearGradient getBackgroundGradient(String? name) {
    final preset = presets[name] ?? presets['instagram']!;
    return preset.toBackgroundGradient();
  }

  /// QR gradient — uniform topLeft→bottomRight.
  static LinearGradient getQrGradient(String? name) {
    final preset = presets[name] ?? presets['instagram']!;
    return preset.toQrGradient();
  }
}
