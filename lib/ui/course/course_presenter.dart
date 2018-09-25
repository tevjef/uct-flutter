import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';

class CoursePresenter extends BasePresenter<CourseView> {
  SearchContext searchContext;
  Course course;

  CoursePresenter(CourseView view) : super(view) {
    final injector = Injector.getInjector();
    searchContext = injector.get();
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
              canSlide: true));
        } else if (all) {
          sectionItem.add(SectionItem(searchContext.copyWith(section: section),
              canSlide: true));
        }
      });
    }

    adapterItems.addAll(metaItems);
    adapterItems.addAll(sectionItem);

    view.setListData(adapterItems);
  }
}

abstract class CourseView extends BaseView {}
