import 'package:flutter/material.dart';

import '../routing/home_router.dart';
import '../rv.dart';
import '../styles.dart';
import 'home_presenter.dart';

class HomePage extends StatefulWidget {
  final HomeRouter router;

  HomePage({Key key, this.router}) : super(key: key);

  @override
  HomeListState createState() => new HomeListState(router);
}

class HomeListState extends State<HomePage> implements HomeView {
  HomeRouter router;
  HomePresenter presenter;
  Adapter adapter = Adapter();
  bool isLoading;
  Widget list;

  HomeListState(HomeRouter router) {
    this.router = router;
    presenter = new HomePresenter(this, router);
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    presenter.loadTrackedSections();
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
        return router.pop(context);
      },
      child: Scaffold(
          appBar: new AppBar(
            title: new Text("Tracked Sections"),
            actions: <Widget>[
              IconButton(
                  icon: new Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    router.gotoSubjects(context).then((changed) {
                      presenter.loadTrackedSections();
                    });
                  }),
            ],
          ),
          body: widget),
    );
  }

  @override
  void onHomeError(String message) {
    setState(() {
      this.isLoading = false;
    });
  }

  @override
  void onHomeSuccess(List<Item> adapterItems) {
    setState(() {
      this.isLoading = false;
      this.adapter.swapData(adapterItems);
    });
  }

  Widget getListView() => ListView.builder(
      padding: EdgeInsets.only(top: Dimens.spacingMedium),
      itemCount: adapter.items.length,
      itemBuilder: adapter.onCreateWidget);

  @override
  void onDefaultError() {
    router.gotoOptions(context);
  }
}
