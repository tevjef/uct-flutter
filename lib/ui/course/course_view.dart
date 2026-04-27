import 'dart:ui';

import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';
import 'course_presenter.dart';

class CoursePage extends StatelessWidget {
  final SearchContext searchContext = Injector().get();

  CoursePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = AppLocalizations.of(context)!.headerMessage(searchContext.course!.name, searchContext.course!.number);

    var allSections = 0;
    var closedSections = 0;
    searchContext.course!.sections.forEach((Section section) {
      if (section.status == AppLocalizations.of(context)!.closedStatus) {
        closedSections++;
      }
      allSections++;
    });

    return WillPopScope(
      onWillPop: () {
        return Future<bool>.value(true);
      },
      child: new DefaultTabController(
        length: 2,
        child: new Scaffold(
          appBar: AppBar(
            leading: new IconButton(
                icon: new Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.onBackground,
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
              child: Text(title,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onBackground)),
            ),
            bottom: new TabBar(
              labelStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
              unselectedLabelStyle: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.bold),
              tabs: [
                new Tab(text: AppLocalizations.of(context)!.allSections(allSections.toString())),
                new Tab(text: AppLocalizations.of(context)!.closedSections(closedSections.toString())),
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

  _CourseList({Key? key, required this.all}) : super(key: key);

  @override
  _CourseListState createState() => new _CourseListState(all);
}

class _CourseListState extends State<_CourseList> with LDEViewMixin<_CourseList> implements CourseView {
  late CoursePresenter presenter;
  bool all;

  _CourseListState(this.all) {
    presenter = new CoursePresenter(this);
  }

  @override
  void initState() {
    super.initState();
    presenter.setMode(all);
    presenter.loadCourse();
  }

  @override
  Widget build(BuildContext context) {
    return AdSafeArea(child: makeRefreshingList(context));
  }

  @override
  void onRefreshData() {
    presenter.loadCourse();
  }

  @override
  Widget makeEmptyStateWidget(BuildContext context) {
    return Container();
  }

  @override
  void navigateToSection() {
    Navigator.of(context).pushNamed(UCTRoutes.section).then((changed) {
      showLoading(true);
    });
  }
}
