import 'package:flutter/material.dart';

import 'subject_adapter.dart';
import 'subject_presenter.dart';

class SubjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("RU-NK 2018"),
        ),
        body: new SubjectList());
  }
}

class SubjectList extends StatefulWidget {
  SubjectList({Key key}) : super(key: key);

  @override
  SubjectListState createState() => new SubjectListState();
}

class SubjectListState extends State<SubjectList> implements SubjectView {
  SubjectPresenter presenter;
  SubjectAdapter adapter;
  bool isLoading;

  SubjectListState() {
    presenter = new SubjectPresenter(this);
    adapter = SubjectAdapter();
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    presenter.loadSubjects("rutgers.universitynew.brunswick", "spring", "2018");
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
  void onSubjectError(String message) {
    setState(() {
      this.isLoading = false;
    });
  }

  @override
  void onSubjectSuccess(List<SubjectItem> adapterItems) {
    setState(() {
      this.isLoading = false;
      this.adapter.swapData(adapterItems);
    });
  }

  ListView getListView() {
    return new ListView.builder(
        itemCount: adapter.items.length,
        itemBuilder: (BuildContext context, int position) {
          return adapter.onCreateWidget(position);
        });
  }
}
