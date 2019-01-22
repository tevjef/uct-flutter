import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '../../ui/widgets/lib.dart';
import 'analytics_keys.dart';

class AnalyticsLogger {
  FirebaseAnalytics analytics = FirebaseAnalytics();

  AnalyticsLogger() {
    AKeys;
  }

  Future<void> logEvent(String name, {Map<String, dynamic> parameters}) async {
    analytics.logEvent(name: name, parameters: parameters);
  }
}
