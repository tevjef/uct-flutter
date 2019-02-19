import 'dart:io' show Platform;

import 'package:firebase_admob/firebase_admob.dart';

class AdInitializer {
  AdInitializer() {
    var appId;
    if (Platform.isAndroid) {
      appId = "ca-app-pub-4052504652952123~2220516610";
    } else if (Platform.isIOS) {
      appId = "ca-app-pub-4052504652952123~3134729769";
    }

    FirebaseAdMob.instance.initialize(appId: appId);
  }

  BannerAd btmBanner;

  void showBanner(bool show) {
    if (!isAdsEnabled()) {
      return null;
    }

    if (btmBanner == null && show) {
      MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
        childDirected: false,
        testDevices: <
            String>[], // Android emulators are considered test devices
      );

      btmBanner = BannerAd(
        // Replace the testAdUnitId with an ad unit id from the AdMob dash.
        // https://developers.google.com/admob/android/test-ads
        // https://developers.google.com/admob/ios/test-ads
        adUnitId: BannerAd.testAdUnitId,
        size: AdSize.fullBanner,
        targetingInfo: targetingInfo,
      );
    }

    if (show) {
      btmBanner.load().then((loaded) {
        btmBanner.show();
      });
    }

    if (!show && btmBanner != null) {
      btmBanner.load().then((loaded) {
        if (btmBanner != null) {
          btmBanner.dispose();
          btmBanner = null;
        }
      });
    }
  }

  bool isAdsEnabled() {
    return true;
  }
}
