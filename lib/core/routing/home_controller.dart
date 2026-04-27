import 'package:flutter/material.dart';

import '../../ui/screens.dart';

class HomeController extends StatefulWidget {
  const HomeController({super.key});

  @override
  HomeControllerState createState() => HomeControllerState();
}

class HomeControllerState extends State<HomeController>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: false,
      body: Navigator(
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            settings: settings,
            builder: (_) => const HomePage(),
          );
        },
      ),
    );
  }
}
