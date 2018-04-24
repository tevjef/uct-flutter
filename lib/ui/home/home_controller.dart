import 'package:flutter/material.dart';
import 'package:uctflutter/data/proto/model.pb.dart';

import '../course/course_view.dart';
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
            builder: (_) => new SubjectPage(router: this),
          );
        },
      ),
    );
  }

  @override
  void gotoCourses(BuildContext context, String topicName) {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (_) => CoursesPage(router: this, topicName: topicName)));
  }

  @override
  void gotoCourse(BuildContext context, Course course) {
    Navigator
        .of(context)
        .push(new MaterialPageRoute(builder: (_) => CoursePage()));
  }
}
