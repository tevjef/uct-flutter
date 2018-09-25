import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';
import 'courses_presenter.dart';

class CoursesPage extends StatefulWidget {
  CoursesPage({Key key}) : super(key: key);

  @override
  CoursesListState createState() => new CoursesListState();
}

class CoursesListState extends State<CoursesPage>
    with LDEViewMixin
    implements CoursesView {
  CoursePresenter presenter;

  CoursesListState() {
    presenter = new CoursePresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    final SearchContext searchContext = Injector.getInjector().get();

    var title = S.of(context).headerMessage(
        searchContext.subject.name, searchContext.subject.number);

    return WillPopScope(
      onWillPop: () {
        return Future<bool>.value(true);
      },
      child: new Scaffold(
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
        body: makeRefreshingList(),
      ),
    );
  }

  @override
  void refreshData() {
    presenter.loadCourses();
  }
}
