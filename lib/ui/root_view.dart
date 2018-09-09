import 'package:flutter/material.dart';

import '../core/lib.dart';
import '../ui/screens.dart';

class RootPage extends StatefulWidget {
  static const String routeName = '/';

  @override
  State<StatefulWidget> createState() => new RootPageState();
}

class RootPageState extends State<RootPage> {
  int currentIndex = 0;

  List<Widget> pages = <Widget>[
    new HomePage(),
    new HomeController(),
    new HomeController()
  ];

  @override
  Widget build(BuildContext context) {
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
        bottomNavigationBar: bottomNavigationBar, body: pages[currentIndex]);
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
