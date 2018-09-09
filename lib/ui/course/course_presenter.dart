import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';

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
    List<Item> adapterItems = List();

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
          sectionItem.add(SectionItem(searchContext.copyWith(section: section),
              slidable: true));
        } else if (all) {
          sectionItem.add(SectionItem(searchContext.copyWith(section: section),
              slidable: true));
        }
      });
    }

    adapterItems.addAll(metaItems);
    adapterItems.addAll(sectionItem);
    view.onCourseSuccess(adapterItems);
  }
}

abstract class CourseView {
  void onCourseSuccess(List<Item> adapterItems);

  void onCourseError(String message);
}
