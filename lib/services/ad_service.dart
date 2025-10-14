import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  // Android ve iOS destekleniyor
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      // Production AdMob ID (Android)
      return 'ca-app-pub-8966682109895515/8906178061';
    } else if (Platform.isIOS) {
      // TODO: AdMob konsoldan iOS app oluştur ve gerçek ID'yi buraya ekle
      // Şimdilik test ID kullanılıyor
      return 'ca-app-pub-3940256099942544/2934735716'; // Test ID
    }
    throw UnsupportedError('Desteklenmeyen platform');
  }

  static Future<void> initialize() async {
    if (Platform.isAndroid || Platform.isIOS) {
      await MobileAds.instance.initialize();
      if (kDebugMode) {
        print('✅ AdMob initialized successfully (${Platform.isAndroid ? "Android" : "iOS"})');
      }
    }
  }

  static BannerAd createBannerAd() {
    if (kDebugMode) {
      print('🔄 Creating banner ad with ID: $bannerAdUnitId');
    }
    
    return BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (kDebugMode) {
            print('✅ Banner ad loaded successfully');
          }
        },
        onAdFailedToLoad: (ad, error) {
          if (kDebugMode) {
            print('❌ Banner ad failed to load: ${error.message} (Code: ${error.code})');
          }
          ad.dispose();
        },
        onAdOpened: (ad) {
          if (kDebugMode) {
            print('📱 Banner ad opened');
          }
        },
        onAdClosed: (ad) {
          if (kDebugMode) {
            print('🔒 Banner ad closed');
          }
        },
      ),
    );
  }
}
