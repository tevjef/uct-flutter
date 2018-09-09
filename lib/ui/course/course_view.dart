import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';
import 'course_presenter.dart';

class CoursePage extends StatelessWidget {
  final SearchContext searchContext = Injector().searchContext;

  CoursePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title =
        "${searchContext.course.name} (${searchContext.course.number})";

    var allSections = 0;
    var closedSections = 0;
    searchContext.course.sections.forEach((Section section) {
      if (section.status == "Closed") {
        closedSections++;
      }
      allSections++;
    });

    return new DefaultTabController(
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
            new IconButton(
                icon: new Icon(
                  Icons.playlist_add,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
          title: new Container(
            child: new Text(title),
          ),
          bottom: new TabBar(
            labelStyle: Styles.sectionHeader,
            unselectedLabelStyle: Styles.sectionHeader,
            tabs: [
              new Tab(text: "ALL SECTIONS ($allSections)"),
              new Tab(text: "CLOSED ($closedSections)"),
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
    );
  }
}

class _CourseList extends StatefulWidget {
  final bool all;

  _CourseList({Key key, @required this.all}) : super(key: key);

  @override
  _CourseListState createState() => new _CourseListState(all);
}

class _CourseListState extends State<_CourseList> implements CourseView {
  CoursePresenter presenter;
  Adapter adapter = Adapter();
  bool isLoading;
  bool _all;

  _CourseListState(bool all) {
    _all = all;
    presenter = new CoursePresenter(this);
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    presenter.loadCourse(_all);
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;

    if (isLoading) {
      widget = new Center(
          child: new Padding(
              padding: const EdgeInsets.only(
                  left: Dimens.spacingStandard, right: Dimens.spacingStandard),
              child: new CircularProgressIndicator()));
    } else {
      widget = getListView();
    }

    return widget;
  }

  @override
  void onCourseError(String message) {
    setState(() {
      this.isLoading = false;
    });
  }

  @override
  void onCourseSuccess(List<Item> adapterItems) {
    setState(() {
      this.isLoading = false;
      this.adapter.swapData(adapterItems);
    });
  }

  Widget getListView() => StatefulListView(
        adapter.items.length,
        adapter.onCreateWidget,
        padding: new EdgeInsets.only(top: Dimens.spacingStandard),
      );
}
