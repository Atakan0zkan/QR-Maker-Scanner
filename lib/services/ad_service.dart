import 'dart:io';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  // Production AdMob IDs
  static Future<void> initialize() async {
    if (Platform.isAndroid || Platform.isIOS) {
      await MobileAds.instance.initialize();
      if (kDebugMode) {
        developer.log('AdMob initialized successfully (${Platform.isAndroid ? "Android" : "iOS"})', name: 'AdService');
      }
    }
  }

  // Interstitial Ad ID
  static String get interstitialAdUnitId {
    if (kDebugMode) {
      if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/1033173712'; // Android Test ID
      } else if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/4411468910'; // iOS Test ID
      }
    }
    if (Platform.isAndroid) {
      return 'ca-app-pub-8966682109895515/2308582680';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-8966682109895515/5613225267';
    }
    throw UnsupportedError('Desteklenmeyen platform');
  }

  static InterstitialAd? _interstitialAd;
  static bool _isInterstitialAdReady = false;

  static void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialAdReady = true;
          if (kDebugMode) {
            developer.log('Interstitial ad loaded successfully', name: 'AdService');
          }
          
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              if (kDebugMode) {
                developer.log('Interstitial ad dismissed', name: 'AdService');
              }
              ad.dispose();
              _isInterstitialAdReady = false;
              loadInterstitialAd(); // Reload for next time
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              if (kDebugMode) {
                developer.log('Interstitial ad failed to show: $error', name: 'AdService');
              }
              ad.dispose();
              _isInterstitialAdReady = false;
              loadInterstitialAd(); // Reload for next time
            },
          );
        },
        onAdFailedToLoad: (error) {
          if (kDebugMode) {
            developer.log('Interstitial ad failed to load: $error', name: 'AdService');
          }
          _isInterstitialAdReady = false;
        },
      ),
    );
  }

  static void showInterstitialAd() {
    if (_isInterstitialAdReady && _interstitialAd != null) {
      _interstitialAd!.show();
      _interstitialAd = null;
      _isInterstitialAdReady = false;
    } else {
      if (kDebugMode) {
        developer.log('Interstitial ad not ready yet', name: 'AdService');
      }
      // Try to load for next time if it wasn't ready
      loadInterstitialAd();
    }
  }
}
