import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:uctflutter/core/lib.dart';

import '../ui/widgets/lib.dart';
import 'analytics/analytics.dart';
import 'analytics/analytics_keys.dart';

class NotificationRepo {
  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  AnalyticsLogger analyticsLogger;

  BuildContext? _buildContext;
  GlobalKey<ScaffoldState>? scaffoldKey;

  final String groupKey = "io.coursetrakr.section";


  NotificationRepo(this.analyticsLogger) {
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  void onMessage(Map<String, dynamic> message) {
    analyticsLogger.logEvent(AKeys.EVENT_FOREGROUND_NOTIFICATION, parameters: message);

    var title = message['notification']['title'];
    var body = message['notification']['body'];

    var isOpen = isSectionOpen(title);

    createSectionNotification(isOpen, title, body).then((a) {});

    // scaffoldKey?.currentState?.showSnackBar(Widgets.makeSnackBar(body));
  }

  Future onSelectNotification(NotificationResponse response) async {
    var parameters = {AKeys.IS_FOREGROUND: true};
    analyticsLogger.logEvent(AKeys.EVENT_FOREGROUND_NOTIFICATION, parameters: parameters);

    Navigator.of(_buildContext!).pushNamedAndRemoveUntil(UCTRoutes.home, (Route<dynamic> route) => false);
  }

  void register(GlobalKey<ScaffoldState> key) {
    scaffoldKey = key;
  }

  void registerContext(BuildContext context) {
    _buildContext = context;
  }

  AndroidNotificationDetails createClosedChannelDetail() {
    return new AndroidNotificationDetails('channel_section_closed', AppLocalizations.of(_buildContext!)!.closedChannelTitle,
        channelDescription: AppLocalizations.of(_buildContext!)!.closedChannelTitleDesc,
        groupKey: groupKey,
        enableVibration: true,
        color: Color(0xF44336),
        importance: Importance.defaultImportance,
        priority: Priority.high);
  }

  AndroidNotificationChannel createClosedChannel() {
    return new AndroidNotificationChannel('channel_section_closed', AppLocalizations.of(_buildContext!)!.closedChannelTitle,
        description: AppLocalizations.of(_buildContext!)!.closedChannelTitleDesc,
        groupId: groupKey,
        enableVibration: true,
        ledColor: Color(0xF44336),
        importance: Importance.defaultImportance);
  }

  AndroidNotificationDetails createOpenChannelDetail() {
    return new AndroidNotificationDetails('channel_section_open', AppLocalizations.of(_buildContext!)!.openChannelTitle,
        channelDescription: AppLocalizations.of(_buildContext!)!.openChannelTitleDesc,
        groupKey: groupKey,
        enableVibration: true,
        color: Color(0x4CAF50),
        importance: Importance.defaultImportance,
        priority: Priority.high);
  }

  AndroidNotificationChannel createOpenChannel() {
    return new AndroidNotificationChannel('channel_section_open', AppLocalizations.of(_buildContext!)!.openChannelTitle,
        description: AppLocalizations.of(_buildContext!)!.openChannelTitleDesc,
        groupId: groupKey,
        enableVibration: true,
        ledColor: Color(0x4CAF50),
        importance: Importance.defaultImportance);
  }

  AndroidNotificationDetails createGenericChannelDetail() {
    return new AndroidNotificationDetails('channel_generic', AppLocalizations.of(_buildContext!)!.genericChannelTitle,
        channelDescription: AppLocalizations.of(_buildContext!)!.genericChannelTitleDesc,
        groupKey: groupKey,
        enableVibration: false,
        color: Color(0x607D8B),
        importance: Importance.defaultImportance,
        priority: Priority.high);
  }

  AndroidNotificationChannel createGenericChannel() {
    return new AndroidNotificationChannel('channel_generic', AppLocalizations.of(_buildContext!)!.genericChannelTitle,
        description: AppLocalizations.of(_buildContext!)!.genericChannelTitleDesc,
        groupId: groupKey,
        enableVibration: false,
        ledColor: Color(0x607D8B),
        importance: Importance.defaultImportance);
  }

  Future createSectionNotification(bool? isOpen, String title, String body) async {
    var androidPlatformChannelSpecifics;

    if (isOpen == null) {
      androidPlatformChannelSpecifics = createGenericChannelDetail();
    }

    if (isOpen == true) {
      androidPlatformChannelSpecifics = createOpenChannelDetail();
    } else {
      androidPlatformChannelSpecifics = createClosedChannelDetail();
    }

    var platformChannelSpecifics = new NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(body.hashCode, title, body, platformChannelSpecifics);
  }

  /// Create a [AndroidNotificationChannel] for heads up notifications
  late AndroidNotificationChannel channel;

  bool isFlutterLocalNotificationsInitialized = false;

  Future<void> setupFlutterNotifications() async {
    await Firebase.initializeApp();

    if (isFlutterLocalNotificationsInitialized) {
      return;
    }

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid = new AndroidInitializationSettings('ic_notification');
    var isinitializationSettingsIOS = new DarwinInitializationSettings();
    var initializationSettings =
        new InitializationSettings(android: initializationSettingsAndroid, iOS: isinitializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onSelectNotification);

    var androidPlugin = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

    androidPlugin!.createNotificationChannel(createClosedChannel());
    androidPlugin.createNotificationChannel(createOpenChannel());
    androidPlugin.createNotificationChannel(createGenericChannel());

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    isFlutterLocalNotificationsInitialized = true;
  }

  void showFlutterNotification(RemoteMessage message) {
    onMessage(message.data);
  }

  bool? isSectionOpen(String title) {
    if (!title.contains("open") && !title.contains("closed")) {
      return null;
    }

    return title.contains("open");
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  Locator.init();
  NotificationRepo repo = Injector().get();
  repo.onMessage(message.data);
}
