import 'dart:io' show Platform;

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdInitializer {
  late String unitId;

  AdInitializer() {
    if (Platform.isAndroid) {
      unitId = "ca-app-pub-4052504652952123/5990327854";
    } else if (Platform.isIOS) {
      unitId = "ca-app-pub-4052504652952123/4262313213";
    }

    MobileAds.instance.initialize();
  }

  bool isAdsEnabled() {
    return true;
  }
}
