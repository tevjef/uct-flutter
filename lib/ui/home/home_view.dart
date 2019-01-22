import '../../core/lib.dart';
import '../../data/lib.dart';
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

  HomeListState() {
    presenter = new HomePresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future<bool>.value(true);
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          title: new Text(S.of(context).homeTitle),
        ),
        body: makeRefreshingList(),
        floatingActionButton: FloatingActionButton(
            child: new Icon(
              Icons.add,
              color: Colors.black,
            ),
            backgroundColor: AppColors.white,
            onPressed: () {
              presenter.onFabClicked();
            }),
      ),
    );
  }

  @override
  void refreshData() {
    presenter.loadTrackedSections();
  }

  Widget makeEmptyStateWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: Dimens.spacingXxxlarge),
          child: Image.asset("res/images/board.webp"),
        ),
        Container(
          padding: EdgeInsets.only(
              left: Dimens.spacingXlarge,
              right: Dimens.spacingXlarge,
              top: Dimens.spacingXlarge,
              bottom: Dimens.spacingXxxlarge),
          child: Text(
            S.of(context).homeEmpty,
            style: Styles.sectionLargeHeader.copyWith(fontSize: 18.0),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  @override
  void navigateToSubjects() {
    Navigator.of(context).pushNamed(UCTRoutes.subjects).then((changed) {
      handleRefresh();
    });
  }

  @override
  void navigateToSection() {
    Navigator.of(context).pushNamed(UCTRoutes.section).then((changed) {
      handleRefresh();
    });
  }
}
