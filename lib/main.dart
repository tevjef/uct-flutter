import 'package:flutter/material.dart';

import 'ui/subject/subject_view.dart';

void main() {
  runApp(new SampleApp());
}

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Sample App',
      theme: new ThemeData(
        fontFamily: "ProductSans",
        primarySwatch: white,
      ),
      home: new SubjectPage(),
      routes: <String, WidgetBuilder>{
        '/subjects': (BuildContext context) => new SubjectPage(),
      },
    );
  }

  MaterialColor white = MaterialColor(0xFFFFFFFF, <int, Color>{
    50: const Color(0xFFFAFAFA),
    100: const Color(0xFFF5F5F5),
    200: const Color(0xFFEEEEEE),
    300: const Color(0xFFE0E0E0),
    350: const Color(
        0xFFD6D6D6), // only for raised button while pressed in light theme
    400: const Color(0xFFBDBDBD),
    500: const Color(0xFFFFFFFF),
    600: const Color(0xFF757575),
    700: const Color(0xFF616161),
    800: const Color(0xFF424242),
    850: const Color(0xFF303030), // only for background color in dark theme
    900: const Color(0xFF212121),
  });
}
//
//class SampleAppPage extends StatefulWidget {
//  SampleAppPage({Key key}) : super(key: key);
//
//  @override
//  _SampleAppPageState createState() => new _SampleAppPageState();
//}
//
//class _SampleAppPageState extends State<SampleAppPage> {
//  List<University> widgets = [];
//
//  @override
//  void initState() {
//    super.initState();
//    loadData();
//  }
//
//  showLoadingDialog() {
//    return widgets.length == 0;
//  }
//
//  getBody() {
//    if (showLoadingDialog()) {
//      return getProgressDialog();
//    } else {
//      return getListView();
//    }
//  }
//
//  getProgressDialog() {
//    return new Center(child: new CircularProgressIndicator());
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//        appBar: new AppBar(
//          title: new Text("Sample App"),
//        ),
//        body: getBody());
//  }
//
//  ListView getListView() => new ListView.builder(
//      itemCount: widgets.length,
//      itemBuilder: (BuildContext context, int position) {
//        return getRow(position);
//      });
//
//  Widget getRow(int i) {
//    return new Padding(
//        padding: new EdgeInsets.all(10.0),
//        child: new Text("${widgets[i].name}"));
//  }
//
//  loadData() async {
//    UCTApiClient("https://api.coursetrakr.io/v2")
//        .universities()
//        .then((unis) => setState(() {
//              widgets = unis;
//            }));
//  }
//}
