import 'package:flutter/material.dart';

import '../../ui/screens.dart';

class HomeController extends StatefulWidget {
  @override
  HomeControllerState createState() => new HomeControllerState();
}

class HomeControllerState extends State<HomeController>
    with TickerProviderStateMixin {
  @override
  void initState() {
    MaterialPageRoute.debugEnableFadingRoutes = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      primary: false,
      body: new Navigator(
        onGenerateRoute: (RouteSettings settings) {
          return new MaterialPageRoute(
            settings: settings,
            builder: (_) => new HomePage(),
          );
        },
      ),
    );
  }
}
