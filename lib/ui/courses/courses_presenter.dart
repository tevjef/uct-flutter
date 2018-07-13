import '../../data/UCTApiClient.dart';
import '../../dependency_injection.dart';
import 'courses_adapter.dart';
import '../rv.dart';
import '../widgets/adapter.dart';
import '../home/home_router.dart';

class CoursePresenter {
  CourseView view;
  UCTApiClient apiClient;
  HomeRouter router;

  CoursePresenter(this.view, this.router) {
    apiClient = new Injector().apiClient;
  }

  void loadCourses(String subjectTopicName) {
    apiClient.courses(subjectTopicName).then((courses) {
      List<Item> adapterItems = List();

      adapterItems.add(HeaderItem("RECENT"));
      adapterItems.add(CourseTitleItem(router,
          courses[0].name, courses[0].number, 0, 0, courses[0]));
      adapterItems.add(HeaderItem("ALL (${courses.length})"));
      final addItems = courses.map((course) {
        int total = course.sections.length;
        int open = 0;
        course.sections.forEach((section) {
          if (section.status == "Open") {
            open++;
          }
        });
        return CourseTitleItem(router, course.name, course.number, open, total, course);
      });

      adapterItems.addAll(addItems);
      view.onCourseSuccess(adapterItems);
    }).catchError((onError) {
      print(onError);
      view.onCourseError(onError.toString());
    });
  }
}

abstract class CourseView {
  void onCourseSuccess(List<Item> adapterItems);
  void onCourseError(String message);
}
