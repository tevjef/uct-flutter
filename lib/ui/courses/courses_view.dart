import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';
import 'courses_presenter.dart';

class CoursesPage extends StatefulWidget {
  CoursesPage({Key? key}) : super(key: key);

  @override
  CoursesListState createState() => new CoursesListState();
}

class CoursesListState extends State<CoursesPage>
    with LDEViewMixin
    implements CoursesView {
  late CoursesPresenter presenter;

  CoursesListState() {
    presenter = new CoursesPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    final SearchContext searchContext = Injector().get();

    var title = AppLocalizations.of(context)!.headerMessage(
        searchContext.subject!.name, searchContext.subject!.number);

    return WillPopScope(
      onWillPop: () {
        return Future<bool>.value(true);
      },
      child: new Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
            leading: new IconButton(
                icon: new Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            title: Text(title, style: Theme.of(context).textTheme.titleLarge!
                  .copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onBackground)),
            ),
        body: AdSafeArea(child: makeRefreshingList(context)),
      ),
    );
  }

  @override
  void onRefreshData() {
    presenter.loadCourses();
  }

  @override
  void navigateToCourse() {
    Navigator.of(context).pushNamed(UCTRoutes.course).then((changed) {
      showLoading(true);
    });
  }
}
