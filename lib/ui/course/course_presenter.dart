import '../../data/UCTApiClient.dart';
import '../../data/proto/model.pb.dart';
import '../../dependency_injection.dart';
import '../routing/home_router.dart';
import '../rv.dart';
import '../search_context.dart';
import '../widgets/adapter.dart';

class CoursePresenter {
  CourseView view;
  UCTApiClient apiClient;
  SearchContext searchContext;
  HomeRouter router;
  Course course;

  CoursePresenter(this.view, this.router) {
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
          sectionItem.add(SectionItem(searchContext, section, router));
        } else if (all) {
          sectionItem.add(SectionItem(searchContext, section, router));
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
