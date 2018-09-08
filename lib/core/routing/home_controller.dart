import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/lib.dart';
import '../../ui/screens.dart';
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
            builder: (_) => new HomePage(router: this),
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
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (_) => CoursePage(router: this)));
  }

  @override
  Future<bool> gotoSection(BuildContext context, SearchContext searchContext) {
    return Navigator.of(context).push(new MaterialPageRoute(
        builder: (_) =>
            SectionDetailsPage(router: this, searchContext: searchContext)));
  }

  @override
  Future<bool> gotoSubjects(BuildContext context) {
    return Navigator.of(context)
        .push(new MaterialPageRoute(builder: (_) => SubjectPage(router: this)));
  }

  @override
  Future<bool> pop(BuildContext context) async {
    return Navigator.of(context).pop(true);
  }

  @override
  Future<bool> gotoOptions(BuildContext context) {
    return Navigator.of(context)
        .push(new MaterialPageRoute(builder: (_) => OptionPage(router: this)));
  }
}
