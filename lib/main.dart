import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logging/logging.dart';

import 'core/lib.dart';
import 'ui/screens.dart';
import 'ui/widgets/lib.dart';

void main() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  Crashlytics.instance.enableInDevMode = true;

  FlutterError.onError = (FlutterErrorDetails details) {
      Crashlytics.instance.recordFlutterError(details);
  };

  Locator.init();
  FirebaseAnalytics analytics = new FirebaseAnalytics();

  var app = MaterialApp(
    title: 'Course Tracker',
    debugShowCheckedModeBanner: false,
    navigatorObservers: [
      new FirebaseAnalyticsObserver(analytics: analytics),
    ],
    localizationsDelegates: [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    localeResolutionCallback:
        S.delegate.resolution(fallback: new Locale("en", "")),
    supportedLocales: S.delegate.supportedLocales,
//    theme: _buildDarkTheme(),
    theme: new ThemeData(
      accentColor: Colors.black,
      indicatorColor: Colors.black,
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
  );

  runZoned<Future<Null>>(() async {
      runApp(app);
    }, onError: Crashlytics.instance.recordError);
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
