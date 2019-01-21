import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../ui/widgets/lib.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationRepo {
  GlobalKey<ScaffoldState> scaffoldKey;

  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  final String groupKey = "io.crousetrakr.section";

  NotificationRepo() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('ic_notification');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        var title = message['notification']['title'];
        var body = message['notification']['body'];

        var isOpen = isSectionOpen(title);

        createSectionNotification(isOpen, title, body).then((a) {});

        scaffoldKey?.currentState
            ?.showSnackBar(Widgets.makeSnackBar("Message recieved $body"));
      },
      onLaunch: (Map<String, dynamic> message) async {
        // TODO analytics for notification click
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        // TODO analytics for notification click
        print("onResume: $message");
      },
    );
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      // TODO analytics for foreground notification click
    }
  }

  void register(GlobalKey<ScaffoldState> key) {
    scaffoldKey = key;
  }

  AndroidNotificationDetails createClosedChannel() {
    return new AndroidNotificationDetails('channel_section_closed',
        'Closed Sections', 'Notify when sections close',
        groupKey: groupKey,
        enableVibration: true,
        color: Color(0xF44336),
        importance: Importance.Max,
        priority: Priority.High);
  }

  AndroidNotificationDetails createOpenChannel() {
    return new AndroidNotificationDetails(
        'channel_section_open', 'Open Sections', 'Notify when sections open',
        groupKey: groupKey,
        enableVibration: true,
        color: Color(0x4CAF50),
        importance: Importance.Max,
        priority: Priority.High);
  }

  AndroidNotificationDetails createGenericChannel() {
    return new AndroidNotificationDetails(
        'channel_generic', 'Other', 'Announcements and app updates.',
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
