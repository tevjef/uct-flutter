import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';
import 'courses_adapter.dart';

class CoursePresenter extends BasePresenter<CoursesView> {
  UCTApiClient apiClient;
  SearchContext searchContext;
  RecentSelectionDao recentSelectionDatabase;

  List<Course> courses;

  CoursePresenter(CoursesView view) : super(view) {
    final injector = Injector.getInjector();
    apiClient = injector.get();
    searchContext = injector.get();
    recentSelectionDatabase = injector.get();
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

      Navigator.of(context).pushNamed(UCTRoutes.course).then((changed) {
        loadCourses();
      });
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
  }

  void addToRecent(String courseTopicName) async {
    var recentSelection = RecentSelection();
    recentSelection.topicName = courseTopicName;
    recentSelection.parentTopicName = searchContext.subject.topicName;
    recentSelection =
        await recentSelectionDatabase.insertCourseSelection(recentSelection);
  }
}

abstract class CoursesView extends BaseView {}
