import 'package:flutter/material.dart';

import '../home/home_router.dart';
import '../rv.dart';
import '../widgets/stateful_listview.dart';
import 'subject_presenter.dart';

class SubjectPage extends StatefulWidget {
  final HomeRouter router;

  SubjectPage({Key key, this.router}) : super(key: key);

  @override
  SubjectListState createState() => new SubjectListState(router);
}

class SubjectListState extends State<SubjectPage> implements SubjectView {
  HomeRouter router;
  SubjectPresenter presenter;
  Adapter adapter = Adapter();
  bool isLoading;
  Widget list;

  SubjectListState(HomeRouter router) {
    this.router = router;
    presenter = new SubjectPresenter(this, router);
  }

  @override
  void initState() {
    super.initState();
    if (adapter.items.length == 0) {
      isLoading = true;
      presenter.loadSubjects("rutgers.universitynewark", "fall", "2018");
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;

    if (isLoading) {
      widget = new Center(
          child: new Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: new CircularProgressIndicator(
                  backgroundColor: Colors.black)));
    } else {
      if (list == null) {
        list = getListView();
      }
      widget = list;
    }

    return WillPopScope(
      onWillPop: () {
        router.pop(context);
      },
      child: Scaffold(
          appBar: new AppBar(
            title: new Text("RU-NK 2018"),
          ),
          body: widget),
    );
  }

  @override
  void onSubjectError(String message) {
    setState(() {
      this.isLoading = false;
    });
  }

  @override
  void onSubjectSuccess(List<Item> adapterItems) {
    setState(() {
      this.isLoading = false;
      this.adapter.swapData(adapterItems);
    });
  }

  Widget getListView() =>
      StatefulListView(adapter.items.length, adapter.onCreateWidget);
}
