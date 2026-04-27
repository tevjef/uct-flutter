import 'package:flutter/material.dart';

import '../core/lib.dart';
import '../data/lib.dart';
import '../ui/screens.dart';

class RootPage extends StatefulWidget {
  static const String routeName = '/';

  const RootPage({super.key});

  @override
  State<StatefulWidget> createState() => RootPageState();
}

class RootPageState extends State<RootPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int currentIndex = 0;

  List<Widget> pages = <Widget>[
    const HomePage(),
    const HomeController(),
    const HomeController()
  ];

  @override
  Widget build(BuildContext context) {
    NotificationRepo notificationRepo = getIt<NotificationRepo>();
    notificationRepo.register(scaffoldKey);
    notificationRepo.registerContext(context);

    return Scaffold(key: scaffoldKey, body: pages[currentIndex]);
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
