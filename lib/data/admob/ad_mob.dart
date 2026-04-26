import 'dart:io' show Platform;

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:uctflutter/ui/widgets/lib.dart';

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

  BannerAd? btmBanner;
  bool _isLoaded = false;
  Widget? adWidget;
  late Orientation _currentOrientation;

  void showBanner(BuildContext context, bool show) {
    if (!isAdsEnabled()) {
      return null;
    }

    if (btmBanner == null && show) {
      _loadAd(context);
    }

    if (!show) {
      btmBanner?.load().then((loaded) {
        btmBanner?.dispose();
        btmBanner = null;
      });
    }
  }

  /// Load another ad, disposing of the current ad if there is one.
  Future<void> _loadAd(BuildContext context) async {
    await btmBanner?.dispose();
    btmBanner = null;
    _isLoaded = false;

    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    btmBanner = BannerAd(
      adUnitId: unitId,
      size: size,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$ad loaded: ${ad.responseInfo}');
          // When the ad is loaded, get the ad size and use it to set
          // the height of the ad container.
          btmBanner = ad as BannerAd;
          _isLoaded = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Anchored adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    return btmBanner!.load();
  }

  /// Gets a widget containing the ad, if one is loaded.
  ///
  /// Returns an empty container if no ad is loaded, or the orientation
  /// has changed. Also loads a new ad if the orientation changes.
  Widget getAdWidget(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (_currentOrientation == orientation && btmBanner != null && _isLoaded) {
          return Container(
            color: Colors.green,
            width: btmBanner!.size.width.toDouble(),
            height: btmBanner!.size.height.toDouble(),
            child: AdWidget(ad: btmBanner!),
          );
        }
        // Reload the ad if the orientation changes.
        if (_currentOrientation != orientation) {
          _currentOrientation = orientation;
          _loadAd(context);
        }
        return Container();
      },
    );
  }

  bool isAdsEnabled() {
    return true;
  }
}
