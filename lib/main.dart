import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'ui/screens.dart';
import 'ui/widgets/lib.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  runApp(new SampleApp());
}

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Course Tracker',
      theme: new ThemeData(
        accentColor: Colors.black,
        indicatorColor: Colors.black,
        fontFamily: "ProductSans",
        primarySwatch: AppColors.white,
      ),
      home: new RootPage(),
    );
  }
}
