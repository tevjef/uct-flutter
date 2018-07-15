import '../../data/UCTApiClient.dart';
import '../../data/proto/model.pb.dart';
import '../../data/db/recent.dart';
import '../../dependency_injection.dart';
import '../home/home_router.dart';
import '../rv.dart';
import '../search_context.dart';
import '../widgets/adapter.dart';
import 'courses_adapter.dart';

class CoursePresenter {
  CourseView view;
  UCTApiClient apiClient;
  HomeRouter router;
  SearchContext searchContext;
  RecentSelectionDatabase recentSelectionDatabase;
  Function courseClickCallback;
  List<Course> courses;

  CoursePresenter(this.view, this.router) {
    apiClient = new Injector().apiClient;
    searchContext = new Injector().searchContext;
    recentSelectionDatabase = new Injector().recentSelectionDatabase;

    courseClickCallback = (context, Course course) {
      searchContext.course = course;
      addToRecent(course.topicName);
      router.gotoCourse(context, course);
      updateCourseList();
    };
  }

  void loadCourses(String courseTopicName) {
    apiClient.courses(courseTopicName).then((courses) {
      this.courses = courses;
      updateCourseList();
    }).catchError((onError) {
      print(onError);
      view.onCourseError(onError.toString());
    });
  }

  void updateCourseList() async {
    var recent = await recentSelectionDatabase
        .getRecentCourseSelection(searchContext.subject.topicName);

    List<Item> adapterItems = List();

    var recentCourses = courses.where((it) {
      return recent.any((recentSelection) {
        return it.topicName == recentSelection.topicName;
      });
    });

    var recentCourseItems = recentCourses.map((course) {
      return CourseTitleItem(course, courseClickCallback);
    });

    if (recentCourseItems.isNotEmpty && courses.length > 5) {
      adapterItems.add(HeaderItem("RECENT"));
      adapterItems.addAll(recentCourseItems);
    }

    adapterItems.add(HeaderItem("ALL (${courses.length})"));

    final addItems = courses.map((course) {
      return CourseTitleItem(course, courseClickCallback);
    });

    adapterItems.addAll(addItems);
    view.onCourseSuccess(adapterItems);
  }

  void addToRecent(String courseTopicName) async {
    var recentSelection = RecentSelection();
    recentSelection.topicName = courseTopicName;
    recentSelection.parentTopicName = searchContext.subject.topicName;
    recentSelection =
        await recentSelectionDatabase.insertCourseSelection(recentSelection);
  }
}

abstract class CourseView {
  void onCourseSuccess(List<Item> adapterItems);

  void onCourseError(String message);
}
