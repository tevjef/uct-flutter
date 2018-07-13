import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../dependency_injection.dart';
import '../home/home_router.dart';
import '../rv.dart';
import '../search_context.dart';
import 'courses_presenter.dart';

class CoursesPage extends StatelessWidget {
  final String topicName;

  final HomeRouter router;
  final SearchContext searchContext = Injector().searchContext;

  CoursesPage({Key key, @required this.router, @required this.topicName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title =
        "${searchContext.subject.name} (${searchContext.subject.number})";
    return WillPopScope(
      onWillPop: () {
        router.pop(context);
      },
      child: new Scaffold(
        appBar: AppBar(
            leading: new IconButton(
                icon: new Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            title: new Text(title)),
        body: new _CourseList(router: router, topicName: topicName),
      ),
    );
  }
}

class _CourseList extends StatefulWidget {
  final String topicName;
  final HomeRouter router;

  _CourseList({Key key, @required this.router, @required this.topicName})
      : super(key: key);

  @override
  CourseListState createState() => new CourseListState(router, topicName);
}

class CourseListState extends State<_CourseList> implements CourseView {
  CoursePresenter presenter;
  Adapter adapter = Adapter();
  bool isLoading;
  String topicName;

  CourseListState(HomeRouter router, String topicName) {
    this.topicName = topicName;
    presenter = new CoursePresenter(this, router);
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    presenter.loadCourses(topicName);
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;

    if (isLoading) {
      widget = new Center(
          child: new Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: new CircularProgressIndicator()));
    } else {
      widget = getListView();
    }

    return widget;
  }

  @override
  void onCourseError(String message) {
    setState(() {
      this.isLoading = false;
    });
  }

  @override
  void onCourseSuccess(List<Item> adapterItems) {
    setState(() {
      this.isLoading = false;
      this.adapter.swapData(adapterItems);
    });
  }

  ListView getListView() {
    return new ListView.builder(
        itemCount: adapter.items.length,
        itemBuilder: (BuildContext context, int position) {
          return adapter.onCreateWidget(context, position);
        });
  }
}
