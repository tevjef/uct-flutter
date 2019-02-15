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

  BannerAd myBanner;

  bool isLoaded;

  BannerAd showBanner(bool show) {
    if (myBanner == null) {
      MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
        keywords: <String>['flutterio', 'beautiful apps'],
        contentUrl: 'https://flutter.io',
        childDirected: false,
        testDevices: <
            String>[], // Android emulators are considered test devices
      );

      myBanner = BannerAd(
        // Replace the testAdUnitId with an ad unit id from the AdMob dash.
        // https://developers.google.com/admob/android/test-ads
        // https://developers.google.com/admob/ios/test-ads
        adUnitId: BannerAd.testAdUnitId,
        size: AdSize.fullBanner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd event is $event");
        },
      );
    }

    if (show) {
      myBanner.load().then((loaded) {
        print("################# loaded $loaded");
        myBanner.show();
      });
    } else {
      myBanner.isLoaded().then((isLoaded) {
        print("################# isLoaded $isLoaded");
        if (isLoaded) {
          myBanner.dispose().then((discarded) {
            myBanner = null;
          });
        }
      });
    }
  }

  bool isAdsEnabled() {
    return true;
  }
}
