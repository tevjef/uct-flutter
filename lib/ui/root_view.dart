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
    final injector = Injector.getInjector();

    NotificationRepo notificationRepo = injector.get();
    notificationRepo.register(scaffoldKey);

    final BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
              icon: new Icon(Icons.home), title: new Text("Home")),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.timeline), title: new Text("Timeline")),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.schedule), title: new Text("Schedule"))
        ],
        fixedColor: Colors.black,
        currentIndex: currentIndex,
        onTap: onTabTapped);

    return new Scaffold(
        key: scaffoldKey,
//        bottomNavigationBar: bottomNavigationBar,
        body: pages[currentIndex]);
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
