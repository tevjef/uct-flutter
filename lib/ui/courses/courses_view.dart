import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';
import 'courses_presenter.dart';

class CoursesPage extends StatelessWidget {
  CoursesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SearchContext searchContext = Injector.getInjector().get();

    final title =
        "${searchContext.subject.name} (${searchContext.subject.number})";
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
        body: new _CourseList(),
      ),
    );
  }
}

class _CourseList extends StatefulWidget {
  _CourseList({Key key}) : super(key: key);

  @override
  CourseListState createState() => new CourseListState();
}

class CourseListState extends State<_CourseList> implements CourseView {
  SearchContext searchContext;
  CoursePresenter presenter;
  Adapter adapter = Adapter();
  bool isLoading;

  CourseListState() {
    searchContext = Injector.getInjector().get();
    presenter = new CoursePresenter(this, searchContext.subject.topicName);
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    presenter.loadCourses();
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

  Widget getListView() =>
      StatefulListView(adapter.getItemCount(), adapter.onCreateWidget);
}
