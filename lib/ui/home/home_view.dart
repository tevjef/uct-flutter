import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';
import 'home_presenter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  HomeListState createState() => new HomeListState();
}

class HomeListState extends State<HomePage> with LDEViewMixin implements HomeView {
  late HomePresenter presenter;
  late AdInitializer adInitializer;

  HomeListState() {
    final injector = Injector();
    adInitializer = injector.get();

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
          title: Text(AppLocalizations.of(context)!.homeTitle,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onBackground)),
        ),
        body: makeRefreshingList(context),
        floatingActionButton: FloatingActionButton(
            child: new Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
            onPressed: () {
              presenter.onFabClicked();
            }),
      ),
    );
  }

  @override
  void onRefreshData() {
    adInitializer.showBanner(context, false);
    presenter.loadTrackedSections();
  }

  Widget makeEmptyStateWidget(BuildContext context) {
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
            AppLocalizations.of(context)!.homeEmpty,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  @override
  void navigateToSubjects() {
    Navigator.of(context).pushNamed(UCTRoutes.subjects).then((changed) {
      refreshData();
    });
  }

  @override
  void navigateToSection() {
    Navigator.of(context).pushNamed(UCTRoutes.section, arguments: true).then((changed) {
      refreshData();
    });
  }
}
