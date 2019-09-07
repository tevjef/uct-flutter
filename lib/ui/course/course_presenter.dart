import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';

class CoursePresenter extends BasePresenter<CourseView> {
  SearchContext searchContext;
  UCTApiClient apiClient;
  Course course;
  AnalyticsLogger analyticsLogger;

  bool all;

  CoursePresenter(CourseView view) : super(view) {
    final injector = Injector.getInjector();
    apiClient = injector.get();
    analyticsLogger = injector.get();
    searchContext = injector.get();
    course = searchContext.course;
  }

  void loadCourse() async {
    List<SubscriptionView> subscriptionViews = [];
    try {
      subscriptionViews = await apiClient.courseHotness(course.topicName);
    } catch (e) {
      view.showErrorMessage(e, loadCourse);
    }

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
        var subscriptionView = subscriptionViews.firstWhere(
            (subscrptionView) => subscrptionView.topicName == section.topicName,
            orElse: () => null);

        if (all == false && section.status == "Closed") {
          sectionItem.add(SectionItem(searchContext.copyWith(section: section),
              subscriptionView: subscriptionView,
              onSectionClicked: onSectionClicked, canSlide: false));
        } else if (all) {
          sectionItem.add(SectionItem(searchContext.copyWith(section: section),
              subscriptionView: subscriptionView,
              onSectionClicked: onSectionClicked, canSlide: false));
        }
      });
    }

    adapterItems.addAll(metaItems);
    adapterItems.addAll(sectionItem);

    view.setListData(adapterItems);
    view.showLoading(false);
  }

  void onSectionClicked(Section section) {
    var parameters = {
      AKeys.STATUS: section.status,
      AKeys.ORIGIN: AKeys.ORIGIN_COURSE_SECTION_LIST
    };
    analyticsLogger.logEvent(AKeys.EVENT_SECTION_CLICKED,
        parameters: parameters);

    view.navigateToSection();
  }

  void setMode(bool all) {
    this.all = all;
  }
}

abstract class CourseView extends BaseView {
  void navigateToSection();
}
