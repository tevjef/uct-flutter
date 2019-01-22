import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';

class SectionPresenter extends BasePresenter<SectionView> {
  SearchContext searchContext;
  UCTRepo uctRepo;
  TrackedSectionDao trackedSectionDatabase;
  AnalyticsLogger analyticsLogger;

  SectionPresenter(SectionView view) : super(view) {
    final injector = Injector.getInjector();
    trackedSectionDatabase = injector.get();
    analyticsLogger = injector.get();
    uctRepo = injector.get();
    searchContext = injector.get();
  }

  void loadSection() async {
    Section section = searchContext.section;

    List<Item> adapterItems = List();

    adapterItems.add(SubscribeItem(view, (value) {
      toggleSection(searchContext);
      var parameters = {AKeys.STATUS: searchContext.section.status};
      analyticsLogger.logEvent(AKeys.EVENT_SUBSCRIBE, parameters: parameters);
    }));

    adapterItems.add(SpaceItem(height: Dimens.spacingStandard));

    List<MetadataItem> metaItems = new List();
    if (section?.metadata?.isNotEmpty ?? false) {
      section.metadata.forEach((meta) {
        metaItems.add(MetadataItem(meta.title, meta.content));
      });
    }

    adapterItems.addAll(metaItems);
    adapterItems.add(SectionItem(searchContext));

    loadTrackedSectionCount();

    view.setListData(adapterItems);
    view.showLoading(false);
    loadStatus(section);
  }

  void loadStatus(Section section) async {
    var isTracked =
        await trackedSectionDatabase.isSectionTracked(section.topicName);

    view.setSectionStatus(isTracked);
  }

  void loadTrackedSectionCount() async {
    var numTrackedSections =
        (await trackedSectionDatabase.getAllTrackedSections()).length;
    view.setNumTrackedSections(numTrackedSections);
  }

  void toggleSection(SearchContext searchContext) async {
    try {
      var isTracked = await uctRepo.toggleSection(searchContext);
      view.setSectionStatus(isTracked);
    } catch (e) {
      view.showErrorMessage(e);
    }

    loadTrackedSectionCount();
  }

  void onTrackedSectionsClicked() {
    var parameters = {AKeys.STATUS: searchContext.section.status};
    analyticsLogger.logEvent(AKeys.EVENT_POP_TO_TRACKED_SECTIONS,
        parameters: parameters);

    view.onPopToTrackedSections();
  }
}

abstract class SectionView extends BaseView implements TrackedStatusProvider {
  void setSectionStatus(bool isTracked);
  void onPopToTrackedSections();
  void setNumTrackedSections(int numTrackedSections);
}
