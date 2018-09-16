import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'core/lib.dart';
import 'ui/screens.dart';
import 'ui/widgets/lib.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  FirebaseAnalytics analytics = new FirebaseAnalytics();

  runApp(MaterialApp(
    title: 'Course Tracker',
    navigatorObservers: [
      new FirebaseAnalyticsObserver(analytics: analytics),
    ],
//    theme: _buildDarkTheme(),
    theme: new ThemeData(
      accentColor: Colors.black,
      indicatorColor: Colors.black,
      fontFamily: "ProductSans",
      primarySwatch: AppColors.white,
    ),
    routes: <String, WidgetBuilder>{
      UCTRoutes.home: (BuildContext context) => HomePage(),
      UCTRoutes.subjects: (BuildContext context) => new SubjectPage(),
      UCTRoutes.options: (BuildContext context) => new OptionPage(),
      UCTRoutes.courses: (BuildContext context) => new CoursesPage(),
      UCTRoutes.course: (BuildContext context) => new CoursePage(),
      UCTRoutes.section: (BuildContext context) => new SectionDetailsPage(),
    },
    home: RootPage(),
  ));
}

TextTheme _buildTextTheme(TextTheme base) {
  return base.copyWith(
    title: base.title.copyWith(
      fontFamily: 'GoogleSans',
    ),
  );
}

ThemeData _buildDarkTheme() {
  const Color primaryColor = Color(0xFF0175c2);
  final ThemeData base = new ThemeData.dark();
  return base.copyWith(
    primaryColor: primaryColor,
    buttonColor: primaryColor,
    indicatorColor: Colors.white,
    accentColor: const Color(0xFF13B9FD),
    canvasColor: const Color(0xFF202124),
    scaffoldBackgroundColor: const Color(0xFF202124),
    backgroundColor: const Color(0xFF202124),
    errorColor: const Color(0xFFB00020),
    buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildTextTheme(base.accentTextTheme),
  );
}

ThemeData _buildLightTheme() {
  const Color primaryColor = Color(0xFF0175c2);
  final ThemeData base = new ThemeData.light();
  return base.copyWith(
    primaryColor: primaryColor,
    buttonColor: primaryColor,
    indicatorColor: Colors.white,
    splashColor: Colors.white24,
    splashFactory: InkRipple.splashFactory,
    accentColor: const Color(0xFF13B9FD),
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    errorColor: const Color(0xFFB00020),
    buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildTextTheme(base.accentTextTheme),
  );
}
