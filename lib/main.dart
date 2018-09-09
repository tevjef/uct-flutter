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

  runApp(MaterialApp(
    title: 'Course Tracker',
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
