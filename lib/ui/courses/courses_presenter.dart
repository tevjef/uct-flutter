import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';
import 'courses_adapter.dart';

class CoursesPresenter extends BasePresenter<CoursesView> {
  UCTApiClient apiClient;
  SearchContext searchContext;
  RecentSelectionDao recentSelectionDatabase;
  AnalyticsLogger analyticsLogger;
  AdInitializer adInitializer;

  List<Course> courses;

  CoursesPresenter(CoursesView view) : super(view) {
    final injector = Injector.getInjector();
    analyticsLogger = injector.get();
    apiClient = injector.get();
    searchContext = injector.get();
    recentSelectionDatabase = injector.get();
    adInitializer = injector.get();

    adInitializer.showBanner(true);
  }

  @override
  void onInitState() {
    super.onInitState();
    loadCourses();
  }

  void loadCourses() async {
    try {
      var courses = await apiClient.courses(searchContext.subject.topicName);
      _updateCourseList(courses);
    } catch (e) {
      view.showErrorMessage(e, loadCourses);
    }
  }

  void _updateCourseList(List<Course> courses) async {
    var recent = await recentSelectionDatabase
        .getRecentCourseSelection(searchContext.subject.topicName);

    List<Item> adapterItems = List();

    var recentCourses = courses.where((it) {
      return recent.any((recentSelection) {
        return it.topicName == recentSelection.topicName;
      });
    });

    var courseClickCallback = (context, Course course) {
      searchContext.updateWith(course: course);
      addToRecent(course.topicName);

      var parameters = {AKeys.IS_RECENT: recentCourses.contains(course)};
      analyticsLogger.logEvent(AKeys.EVENT_COURSE_CLICKED,
          parameters: parameters);

      view.navigateToCourse();
    };

    var recentCourseItems = recentCourses.map((course) {
      return CourseTitleItem(course, courseClickCallback);
    });

    if (recentCourseItems.isNotEmpty && courses.length > 5) {
      adapterItems.add(HeaderItem(S.of(context).recents));
      adapterItems.addAll(recentCourseItems);
    }

    adapterItems
        .add(HeaderItem(S.of(context).allMeta(courses.length.toString())));

    final addItems = courses.map((course) {
      return CourseTitleItem(course, courseClickCallback);
    });

    adapterItems.addAll(addItems);
    view.setListData(adapterItems);
    view.showLoading(false);
  }

  void addToRecent(String courseTopicName) async {
    var recentSelection = RecentSelection();
    recentSelection.topicName = courseTopicName;
    recentSelection.parentTopicName = searchContext.subject.topicName;
    recentSelection =
        await recentSelectionDatabase.insertCourseSelection(recentSelection);
  }
}

abstract class CoursesView extends BaseView {
  void navigateToCourse();
}
