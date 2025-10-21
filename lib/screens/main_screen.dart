import 'dart:developer' as developer;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../services/ad_service.dart';
import '../l10n/app_localizations.dart';
import 'scanner_screen.dart';
import 'create_screen.dart';
import 'history_screen.dart';
import 'settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  BannerAd? _bannerAd;
  bool _isBannerAdLoaded = false;

  final List<Widget> _screens = [
    const ScannerScreen(),
    const CreateScreen(),
    const HistoryScreen(),
    const SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Android ve iOS'ta reklam yükle
    if (Platform.isAndroid || Platform.isIOS) {
      _loadBannerAd();
    }
  }

  void _loadBannerAd() {
    try {
      if (kDebugMode) {
        developer.log('Loading banner ad...', name: 'MainScreen');
      }
      
      _bannerAd = AdService.createBannerAd();
      _bannerAd!.load().then((_) {
        if (mounted) {
          setState(() {
            _isBannerAdLoaded = true;
          });
          if (kDebugMode) {
            developer.log('Banner ad loaded and displayed', name: 'MainScreen');
          }
        }
      }).catchError((error) {
        if (kDebugMode) {
          developer.log('Error loading banner ad: $error', name: 'MainScreen');
        }
      });
    } catch (e) {
      if (kDebugMode) {
        developer.log('Exception while creating banner ad: $e', name: 'MainScreen');
      }
    }
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Banner Ad
          if (_isBannerAdLoaded && _bannerAd != null)
            Container(
              height: _bannerAd!.size.height.toDouble(),
              alignment: Alignment.center,
              child: AdWidget(ad: _bannerAd!),
            ),
          // Navigation Bar
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
            ),
            child: NavigationBar(
              selectedIndex: _currentIndex,
              onDestinationSelected: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.qr_code_scanner_outlined),
                  selectedIcon: const Icon(Icons.qr_code_scanner),
                  label: AppLocalizations.of(context)!.scan,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.add_box_outlined),
                  selectedIcon: const Icon(Icons.add_box),
                  label: AppLocalizations.of(context)!.create,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.history_outlined),
                  selectedIcon: const Icon(Icons.history),
                  label: AppLocalizations.of(context)!.history,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.settings_outlined),
                  selectedIcon: const Icon(Icons.settings),
                  label: AppLocalizations.of(context)!.settings,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
