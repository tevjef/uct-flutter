import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:uctflutter/core/lib.dart';

import '../ui/widgets/lib.dart';
import 'analytics/analytics.dart';
import 'analytics/analytics_keys.dart';

class NotificationRepo {
  GlobalKey<ScaffoldState> scaffoldKey;

  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  AnalyticsLogger analyticsLogger;

  final String groupKey = "io.crousetrakr.section";

  BuildContext _buildContext;

  bool didInitializeLocalNotifications = false;

  NotificationRepo(AnalyticsLogger analyticsLogger) {
    this.analyticsLogger = analyticsLogger;

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        var title = message['notification']['title'];
        var body = message['notification']['body'];

        var isOpen = isSectionOpen(title);

        analyticsLogger.logEvent(AKeys.EVENT_FOREGROUND_NOTIFICATION);

        createSectionNotification(isOpen, title, body).then((a) {});

        scaffoldKey?.currentState?.showSnackBar(Widgets.makeSnackBar(body));
      },
      onLaunch: (Map<String, dynamic> message) async {
        var parameters = {AKeys.IS_FOREGROUND: false};
        analyticsLogger.logEvent(AKeys.EVENT_FOREGROUND_NOTIFICATION,
            parameters: parameters);

        Navigator.of(_buildContext).pushNamedAndRemoveUntil(
            UCTRoutes.home, (Route<dynamic> route) => false);
      },
      onResume: (Map<String, dynamic> message) async {
        var parameters = {AKeys.IS_FOREGROUND: false};
        analyticsLogger.logEvent(AKeys.EVENT_FOREGROUND_NOTIFICATION,
            parameters: parameters);

        Navigator.of(_buildContext).pushNamedAndRemoveUntil(
            UCTRoutes.home, (Route<dynamic> route) => false);
      },
    );
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      var parameters = {AKeys.IS_FOREGROUND: true};
      analyticsLogger.logEvent(AKeys.EVENT_FOREGROUND_NOTIFICATION,
          parameters: parameters);

      Navigator.of(_buildContext).pushNamedAndRemoveUntil(
          UCTRoutes.home, (Route<dynamic> route) => false);
    }
  }

  void register(GlobalKey<ScaffoldState> key) {
    scaffoldKey = key;
  }

  void registerContext(BuildContext context) {
    _buildContext = context;
  }

  void initializeLocalNotifications() {
    if (didInitializeLocalNotifications) {
      return;
    }

    var initializationSettingsAndroid =
        new AndroidInitializationSettings('ic_notification');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    didInitializeLocalNotifications = true;
  }

  AndroidNotificationDetails createClosedChannel() {
    return new AndroidNotificationDetails(
        'channel_section_closed',
        S.of(_buildContext).closedChannelTitle,
        S.of(_buildContext).closedChannelTitleDesc,
        groupKey: groupKey,
        enableVibration: true,
        color: Color(0xF44336),
        importance: Importance.Max,
        priority: Priority.High);
  }

  AndroidNotificationDetails createOpenChannel() {
    return new AndroidNotificationDetails(
        'channel_section_open',
        S.of(_buildContext).openChannelTitle,
        S.of(_buildContext).openChannelTitleDesc,
        groupKey: groupKey,
        enableVibration: true,
        color: Color(0x4CAF50),
        importance: Importance.Max,
        priority: Priority.High);
  }

  AndroidNotificationDetails createGenericChannel() {
    return new AndroidNotificationDetails(
        'channel_generic',
        S.of(_buildContext).genericChannelTitle,
        S.of(_buildContext).genericChannelTitleDesc,
        groupKey: groupKey,
        enableVibration: false,
        color: Color(0x607D8B),
        importance: Importance.Default,
        priority: Priority.High);
  }

  Future createSectionNotification(
      bool isOpen, String title, String body) async {
    var androidPlatformChannelSpecifics;

    if (isOpen == null) {
      androidPlatformChannelSpecifics = createGenericChannel();
    }

    if (isOpen) {
      androidPlatformChannelSpecifics = createOpenChannel();
    } else {
      androidPlatformChannelSpecifics = createClosedChannel();
    }

    var iOSPlatformChannelSpecifics =
        IOSNotificationDetails(presentAlert: true);

    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        body.hashCode, title, body, platformChannelSpecifics);
  }

  bool isSectionOpen(String title) {
    if (!title.contains("open") && !title.contains("closed")) {
      return null;
    }

    return title.contains("open");
  }
}
