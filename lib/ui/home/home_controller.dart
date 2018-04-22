import 'package:flutter/material.dart';

import '../courses/courses_view.dart';
import '../subject/subject_view.dart';
import 'home_router.dart';

class HomeController extends StatefulWidget {
  @override
  HomeControllerState createState() => new HomeControllerState();
}

class HomeControllerState extends State<HomeController>
    with TickerProviderStateMixin
    implements HomeRouter {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      primary: false,
      body: new Navigator(
        onGenerateRoute: (RouteSettings settings) {
          return new MaterialPageRoute(
            builder: (_) => new SubjectPage(router: this),
          );
        },
      ),
    );
  }

  @override
  void gotoCourses(BuildContext context, String topicName) {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (_) => CoursePage(topicName: topicName)));
  }
}
