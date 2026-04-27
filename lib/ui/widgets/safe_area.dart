import 'package:flutter/material.dart';

import '../../core/lib.dart';
import '../../data/lib.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdSafeArea extends StatefulWidget {
  const AdSafeArea({
    super.key,
    this.left = false,
    this.top = false,
    this.right = false,
    this.bottom = true,
    this.minimum = const EdgeInsets.only(bottom: 80),
    required this.child,
  });

  final bool left;
  final bool top;
  final bool right;
  final bool bottom;
  final EdgeInsets minimum;
  final Widget child;

  @override
  State<AdSafeArea> createState() => _AdSafeAreaState();
}

class _AdSafeAreaState extends State<AdSafeArea> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;
  late AdInitializer _adInitializer;
  Orientation? _currentOrientation;

  @override
  void initState() {
    super.initState();
    _adInitializer = getIt<AdInitializer>();
  }

  Future<void> _loadAd() async {
    await _bannerAd?.dispose();
    _bannerAd = null;
    if (mounted) {
      setState(() {
        _isLoaded = false;
      });
    }

    if (!mounted) return;
    final size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
        MediaQuery.of(context).size.width.truncate());

    if (size == null) return;

    _bannerAd = BannerAd(
      adUnitId: _adInitializer.unitId,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          if (mounted) {
            setState(() {
              _isLoaded = true;
            });
          }
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          debugPrint('Anchored adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    _bannerAd!.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_adInitializer.isAdsEnabled()) {
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          SafeArea(
            left: widget.left,
            top: widget.top,
            right: widget.right,
            bottom: widget.bottom,
            minimum: widget.minimum,
            child: widget.child,
          ),
          OrientationBuilder(
            builder: (context, orientation) {
              if (_currentOrientation != orientation) {
                _currentOrientation = orientation;
                // Run load after build phase
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _loadAd();
                });
              }

              if (_isLoaded && _bannerAd != null) {
                return SafeArea(
                  child: SizedBox(
                    width: _bannerAd!.size.width.toDouble(),
                    height: _bannerAd!.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd!),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          )
        ],
      );
    } else {
      return widget.child;
    }
  }
}
