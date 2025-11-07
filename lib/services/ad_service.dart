import 'dart:io';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  // Production AdMob IDs
  static String get bannerAdUnitId {
    if (kDebugMode) {
      if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/6300978111'; // Android Test ID
      } else if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/2934735716'; // iOS Test ID
      }
    }
    if (Platform.isAndroid) {
      // Production AdMob ID (Android)
      return 'ca-app-pub-8966682109895515/8906178061';
    } else if (Platform.isIOS) {
      // Production AdMob ID (iOS)
      return 'ca-app-pub-8966682109895515/3433174705';
    }
    throw UnsupportedError('Desteklenmeyen platform');
  }

  static Future<void> initialize() async {
    if (Platform.isAndroid || Platform.isIOS) {
      await MobileAds.instance.initialize();
      if (kDebugMode) {
        developer.log('AdMob initialized successfully (${Platform.isAndroid ? "Android" : "iOS"})', name: 'AdService');
      }
    }
  }

  static BannerAd createBannerAd() {
    if (kDebugMode) {
      developer.log('Creating banner ad with ID: $bannerAdUnitId', name: 'AdService');
    }
    
    return BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (kDebugMode) {
            developer.log('Banner ad loaded successfully', name: 'AdService');
          }
        },
        onAdFailedToLoad: (ad, error) {
          if (kDebugMode) {
            developer.log('Banner ad failed to load: ${error.message} (Code: ${error.code})', name: 'AdService');
          }
          ad.dispose();
        },
        onAdOpened: (ad) {
          if (kDebugMode) {
            developer.log('Banner ad opened', name: 'AdService');
          }
        },
        onAdClosed: (ad) {
          if (kDebugMode) {
            developer.log('Banner ad closed', name: 'AdService');
          }
        },
      ),
    );
  }
}
