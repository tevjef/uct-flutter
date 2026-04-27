import 'package:flutter/material.dart';

import '../core/lib.dart';
import '../data/lib.dart';
import '../ui/screens.dart';

class RootPage extends StatefulWidget {
  static const String routeName = '/';

  @override
  State<StatefulWidget> createState() => new RootPageState();
}

class RootPageState extends State<RootPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int currentIndex = 0;

  List<Widget> pages = <Widget>[
    new HomePage(),
    new HomeController(),
    new HomeController()
  ];

  @override
  Widget build(BuildContext context) {
    final injector = Injector();

    NotificationRepo notificationRepo = injector.get();
    notificationRepo.register(scaffoldKey);
    notificationRepo.registerContext(context);


    return new Scaffold(
        key: scaffoldKey,
        body: pages[currentIndex]);
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
