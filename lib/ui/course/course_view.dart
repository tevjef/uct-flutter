import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';
import 'course_presenter.dart';

class CoursePage extends StatelessWidget {
  final SearchContext searchContext = Injector.getInjector().get();

  CoursePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = S
        .of(context)
        .headerMessage(searchContext.course.name, searchContext.course.number);

    var allSections = 0;
    var closedSections = 0;
    searchContext.course.sections.forEach((Section section) {
      if (section.status == S.of(context).closedStatus) {
        closedSections++;
      }
      allSections++;
    });

    return WillPopScope(
      onWillPop: () {
        Future<bool>.value(true);
      },
      child: new DefaultTabController(
        length: 2,
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
            actions: <Widget>[
              // TODO implemnet add all courses.
              // new IconButton(
              //     icon: new Icon(
              //       Icons.playlist_add,
              //       color: Colors.black,
              //     ),
              //     onPressed: () {
              //       Navigator.of(context).pop();
              //     }),
            ],
            title: new Container(
              child: new Text(title),
            ),
            bottom: new TabBar(
              labelStyle: Styles.sectionHeader,
              unselectedLabelStyle: Styles.sectionHeader,
              tabs: [
                new Tab(
                    text: S.of(context).allSections(allSections.toString())),
                new Tab(
                    text: S
                        .of(context)
                        .closedSections(closedSections.toString())),
              ],
            ),
          ),
          body: new TabBarView(
            children: [
              new _CourseList(all: true),
              new _CourseList(all: false),
            ],
          ),
        ),
      ),
    );
  }
}

class _CourseList extends StatefulWidget {
  final bool all;

  _CourseList({Key key, @required this.all}) : super(key: key);

  @override
  _CourseListState createState() => new _CourseListState(all);
}

class _CourseListState extends State<_CourseList>
    with LDEViewMixin<_CourseList>
    implements CourseView {
  CoursePresenter presenter;
  bool _all;

  _CourseListState(bool all) {
    _all = all;
    presenter = new CoursePresenter(this);
  }

  @override
  void initState() {
    super.initState();
    presenter.loadCourse(_all);
  }

  @override
  Widget build(BuildContext context) {
    return AdSafeArea(child: makeListView());
  }

  @override
  void onRefreshData() {
    presenter.loadCourse(_all);
  }

  @override
  Widget makeEmptyStateWidget() {
    return Container();
  }

  @override
  void navigateToSection() {
    Navigator.of(context).pushNamed(UCTRoutes.section).then((changed) {
      // handleRefresh();
    });
  }
}
