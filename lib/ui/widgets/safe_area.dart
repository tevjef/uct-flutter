import 'package:flutter/material.dart';

import '../../core/lib.dart';
import '../../data/lib.dart';

class AdSafeArea extends StatelessWidget {
  const AdSafeArea({
    Key? key,
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
  Widget build(BuildContext context) {
    final injector = Injector();
    AdInitializer adInitializer = injector.get();

    if (adInitializer.isAdsEnabled()) {
      return SafeArea(
          left: left,
          top: top,
          right: right,
          bottom: bottom,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              child,
              adInitializer.getAdWidget(context),
            ],
          ),
          minimum: minimum);
    } else {
      return child;
    }
  }
}
