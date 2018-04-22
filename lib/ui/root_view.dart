import 'package:flutter/material.dart';

import 'home/home_controller.dart';

class RootPage extends StatefulWidget {
  static const String routeName = '/';

  @override
  State<StatefulWidget> createState() => new RootPageState();
}

class RootPageState extends State<RootPage> {
  int currentIndex = 0;

  List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = <Widget>[
      new HomeController(),
      new HomeController(),
      new HomeController()
    ];
  }

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
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        });

    return new Scaffold(
        bottomNavigationBar: bottomNavigationBar, body: pages[currentIndex]);
  }
}
