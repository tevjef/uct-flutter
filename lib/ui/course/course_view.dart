import 'package:flutter/material.dart';

import '../../dependency_injection.dart';
import '../search_context.dart';
import 'course_adapter.dart';
import 'course_presenter.dart';

class CoursePage extends StatelessWidget {
  final SearchContext searchContext = Injector().searchContext;

  CoursePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title =
        "${searchContext.course.name} (${searchContext.course.number})";
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
        body: new _CourseList());
  }
}

class _CourseList extends StatefulWidget {
  _CourseList({Key key}) : super(key: key);

  @override
  _CourseListState createState() => new _CourseListState();
}

class _CourseListState extends State<_CourseList> implements CourseView {
  CoursePresenter presenter;
  CourseAdapter adapter;
  bool isLoading;

  _CourseListState() {
    presenter = new CoursePresenter(this);
    adapter = CourseAdapter();
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    presenter.loadCourse();
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
