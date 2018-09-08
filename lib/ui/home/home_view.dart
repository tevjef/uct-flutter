import 'dart:async';

import '../../core/lib.dart';
import '../widgets/lib.dart';
import 'home_presenter.dart';

class HomePage extends StatefulWidget {
  final HomeRouter router;

  HomePage({Key key, this.router}) : super(key: key);

  @override
  HomeListState createState() => new HomeListState(router);
}

class HomeListState extends State<HomePage> implements HomeView {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  bool isLoading;
  Completer<Null> completer;
  Adapter adapter = Adapter();

  HomeRouter router;
  HomePresenter presenter;
  Widget list;

  HomeListState(HomeRouter router) {
    this.router = router;
    presenter = new HomePresenter(this, router);
  }

  @override
  void initState() {
    super.initState();
    showLoading(true);
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
        key: _scaffoldKey,
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
        body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _handleRefresh,
            child: widget),
      ),
    );
  }

  Future<Null> _handleRefresh() {
    showLoading(true);

    presenter.loadTrackedSections();

    return completer.future;
  }

  Widget getListView() => ListView.builder(
      padding: EdgeInsets.only(top: Dimens.spacingMedium),
      itemCount: adapter.items.length,
      itemBuilder: adapter.onCreateWidget);

  @override
  void showLoading(bool isLoading) {
    this.isLoading = isLoading;
    if (!isLoading && completer != null) {
      completer.complete(null);
    }

    completer = new Completer();
  }

  @override
  void setListData(List<Item> adapterItems) {
    setState(() {
      showLoading(false);
      this.adapter.swapData(adapterItems);
    });
  }

  @override
  void showMessage(String message) {
    _scaffoldKey.currentState?.showSnackBar(Widgets.makeSnackBar(message));
  }

  @override
  void showErrorMessage(String message) {
    _scaffoldKey.currentState
        ?.showSnackBar(Widgets.makeSnackBar(message, SnackBarType.error));
  }
}
