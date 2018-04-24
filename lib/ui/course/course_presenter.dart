import '../../data/UCTApiClient.dart';
import '../../data/proto/model.pb.dart';
import '../../dependency_injection.dart';
import '../search_context.dart';
import 'course_adapter.dart';

class CoursePresenter {
  CourseView view;
  UCTApiClient apiClient;
  SearchContext searchContext;
  Course course;

  CoursePresenter(this.view) {
    searchContext = new Injector().searchContext;
    course = searchContext.course;
  }

  void loadCourse(bool all) {
    List<CourseItem> adapterItems = List();

    List<MetadataItem> metaItems = new List();
    if (course.metadata.isNotEmpty) {
      course.metadata.forEach((meta) {
        metaItems.add(MetadataItem(meta.title, meta.content));
      });
    }

    List<SectionItem> sectionItem = new List();
    if (course.sections.isNotEmpty) {
      course.sections.forEach((section) {
        if (all == false && section.status == "Closed") {
          sectionItem.add(SectionItem(section));
        } else if (all) {
          sectionItem.add(SectionItem(section));
        }
      });
    }

    adapterItems.addAll(metaItems);
    adapterItems.addAll(sectionItem);
    view.onCourseSuccess(adapterItems);
  }
}

abstract class CourseView {
  void onCourseSuccess(List<CourseItem> adapterItems);

  void onCourseError(String message);
}
