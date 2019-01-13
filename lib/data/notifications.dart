import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../ui/widgets/lib.dart';

class NotificationRepo {
  GlobalKey<ScaffoldState> scaffoldKey;

  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  NotificationRepo() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");

        var body = message['notification']['body'];
        scaffoldKey?.currentState
            ?.showSnackBar(Widgets.makeSnackBar("Message recieved $body"));
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      print('notification payload: ' + payload);
    }
  }

  void register(GlobalKey<ScaffoldState> key) {
    scaffoldKey = key;
  }
}
