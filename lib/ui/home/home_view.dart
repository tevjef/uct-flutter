import '../../core/lib.dart';
import '../widgets/lib.dart';
import 'home_presenter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  HomeListState createState() => new HomeListState();
}

class HomeListState extends State<HomePage>
    with LDEViewMixin
    implements HomeView {
  HomePresenter presenter;
  Widget list;

  HomeListState() {
    presenter = new HomePresenter(this);
  }

  @override
  void initState() {
    super.initState();
    showLoading(true);
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;

    if (isLoading) {
      widget = Widgets.makeLoading();
    } else {
      widget = makeAnimatedListView();
    }

    return WillPopScope(
      onWillPop: () {
        return Future<bool>.value(true);
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          title: new Text(S.of(context).homeTitle),
          actions: <Widget>[
            Widgets.makeIconWithBadge("5", () {}),
          ],
        ),
        body: RefreshIndicator(
            key: refreshIndicatorKey, onRefresh: handleRefresh, child: widget),
        floatingActionButton: FloatingActionButton(
            child: new Icon(
              Icons.add,
              color: Colors.black,
            ),
            backgroundColor: AppColors.white,
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(UCTRoutes.subjects)
                  .then((changed) {
                presenter.loadTrackedSections();
              });
            }),
      ),
    );
  }

  @override
  void refreshData() {
    presenter.loadTrackedSections();
  }
}
