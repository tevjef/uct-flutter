import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../dependency_injection.dart';
import '../search_context.dart';
import 'courses_adapter.dart';
import 'courses_presenter.dart';

class CoursePage extends StatelessWidget {
  final String topicName;

  final SearchContext searchContext = Injector().searchContext;

  CoursePage({Key key, @required this.topicName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title =
        "${searchContext.subject.name} (${searchContext.subject.number})";
    return new Scaffold(
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
        body: new CourseList(topicName: topicName));
  }
}

class CourseList extends StatefulWidget {
  final String topicName;

  CourseList({Key key, @required this.topicName}) : super(key: key);

  @override
  CourseListState createState() => new CourseListState(topicName);
}

class CourseListState extends State<CourseList> implements CourseView {
  CoursePresenter presenter;
  CourseAdapter adapter;
  bool isLoading;
  String topicName;

  CourseListState(String topicName) {
    this.topicName = topicName;
    presenter = new CoursePresenter(this);
    adapter = CourseAdapter();
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
  void onCourseSuccess(List<CourseItem> adapterItems) {
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
