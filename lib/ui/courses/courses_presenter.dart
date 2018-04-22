import '../../data/UCTApiClient.dart';
import '../../dependency_injection.dart';
import 'courses_adapter.dart';

class CoursePresenter {
  CourseView view;
  UCTApiClient apiClient;

  CoursePresenter(this.view) {
    apiClient = new Injector().apiClient;
  }

  void loadCourses(String subjectTopicName) {
    apiClient.courses(subjectTopicName).then((courses) {
      List<CourseItem> adapterItems = List();

      adapterItems.add(HeaderItem("RECENT"));
      adapterItems
          .add(CourseTitleItem(courses[0].name, courses[0].number, 0, 0));
      adapterItems.add(HeaderItem("ALL (${courses.length})"));
      final addItems = courses.map((course) {
        int total = course.sections.length;
        int open = 0;
        course.sections.forEach((section) {
          if (section.status == "Open") {
            open++;
          }
        });
        return CourseTitleItem(course.name, course.number, open, total);
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
  void onCourseSuccess(List<CourseItem> adapterItems);
  void onCourseError(String message);
}
