import 'package:flutter/material.dart';
import 'package:uctflutter/ui/root_view.dart';

import 'ui/styles.dart';

void main() {
  runApp(new SampleApp());
}

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Sample App',
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
