import 'package:flutter/material.dart';

import '../home/home_router.dart';
import '../rv.dart';
import '../styles.dart';
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
  String title = "";

  SubjectListState(HomeRouter router) {
    this.router = router;
    presenter = new SubjectPresenter(this, router);
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    presenter.loadSubjects();
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;

    if (isLoading) {
      widget = new Center(
          child: new Padding(
              padding: const EdgeInsets.only(
                  left: Dimens.spacingStandard, right: Dimens.spacingStandard),
              child: new CircularProgressIndicator(
                  backgroundColor: Colors.black)));
    } else {
      widget = getListView();
    }

    return WillPopScope(
      onWillPop: () {
        router.pop(context);
      },
      child: Scaffold(
          appBar: new AppBar(
            title: new Text(title),
            actions: <Widget>[
              IconButton(
                  icon: new Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    router.gotoOptions(context).then((bool) {
                      presenter.loadSubjects();
                    });
                  }),
            ],
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

  Widget getListView() => ListView.builder(
      itemCount: adapter.items.length, itemBuilder: adapter.onCreateWidget);

  @override
  void onDefaultError() {
    router.gotoOptions(context);
  }

  @override
  void setTitle(String title) {
    setState(() {
      this.title = title;
    });
  }
}
