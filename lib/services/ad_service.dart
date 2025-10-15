import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  // Production AdMob IDs
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      // Production AdMob ID (Android)
      return 'ca-app-pub-8966682109895515/8906178061';
    } else if (Platform.isIOS) {
      // Production AdMob ID (iOS)
      // TODO: AdMob konsoldan iOS app oluştur ve gerçek ID'yi buraya ekle
      // Şimdilik Android ID kullanılıyor (iOS app oluşturulunca güncellenecek)
      return 'ca-app-pub-8966682109895515/8906178061';
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
