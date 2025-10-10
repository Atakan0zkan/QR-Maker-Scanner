import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      // Test ID for development
      return 'ca-app-pub-3940256099942544/6300978111';
      // Replace with your actual AdMob ID for production:
      // return 'ca-app-pub-XXXXXXXXXXXXXXXX/YYYYYYYYYY';
    } else if (Platform.isIOS) {
      // Test ID for development
      return 'ca-app-pub-3940256099942544/2934735716';
      // Replace with your actual AdMob ID for production:
      // return 'ca-app-pub-XXXXXXXXXXXXXXXX/YYYYYYYYYY';
    }
    throw UnsupportedError('Unsupported platform');
  }

  static Future<void> initialize() async {
    await MobileAds.instance.initialize();
  }

  static BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          print('Banner ad loaded');
        },
        onAdFailedToLoad: (ad, error) {
          print('Banner ad failed to load: $error');
          ad.dispose();
        },
      ),
    );
  }
}
