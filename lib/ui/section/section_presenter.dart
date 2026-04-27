import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';

class SectionPresenter extends BasePresenter<SectionView> {
  late SearchContext searchContext;
  late UCTRepo uctRepo;
  late TrackedSectionDao trackedSectionDatabase;
  late AnalyticsLogger analyticsLogger;
  late AdInitializer adInitializer;

  SectionPresenter(SectionView view) : super(view) {
    final injector = Injector();
    trackedSectionDatabase = injector.get();
    analyticsLogger = injector.get();
    uctRepo = injector.get();
    searchContext = injector.get();
    adInitializer = injector.get();
  }

  @override
  void onInitState() {
    super.onInitState();
    adInitializer.showBanner(context, true);
    loadSection();
  }

  void loadSection() async {
    Section section = searchContext.section!;

    List<Item> adapterItems = [];

    adapterItems.add(SubscribeItem(view, (value) {
      toggleSection(searchContext);
      var parameters = {AKeys.STATUS: searchContext.section!.status};
      analyticsLogger.logEvent(AKeys.EVENT_SUBSCRIBE, parameters: parameters);
    }));

    adapterItems.add(SpaceItem(height: Dimens.spacingStandard));

    List<MetadataItem> metaItems = [];
    if (section.metadata.isNotEmpty) {
      section.metadata.forEach((meta) {
        metaItems.add(MetadataItem(meta.title, meta.content));
      });
    }

    adapterItems.addAll(metaItems);
    adapterItems.add(SectionItem(searchContext, onItemDismissed: () => {}, onSectionClicked: (Section) => {}));

    loadTrackedSectionCount();

    view.setListData(adapterItems);
    view.showLoading(false);
    loadStatus(section);
  }

  void loadStatus(Section section) async {
    var isTracked = await trackedSectionDatabase.isSectionTracked(section.topicName);

    view.setSectionStatus(isTracked);
  }

  void loadTrackedSectionCount() async {
    var numTrackedSections = (await trackedSectionDatabase.getAllTrackedSections()).length;
    view.setNumTrackedSections(numTrackedSections);
  }

  void toggleSection(SearchContext searchContext) async {
    var currentSemester = searchContext.university!.resolvedSemesters.current;
    if (int.parse(searchContext.subject!.year) < currentSemester.year && searchContext.subject!.season != "winter") {
      view.showPastSemesterDialog(searchContext.subject!);
    }
    
    try {
      var isTracked = await uctRepo.toggleSection(searchContext);
      view.setSectionStatus(isTracked);
    } on Exception catch (e) {
      view.showErrorMessage(e);
    }

    loadTrackedSectionCount();
  }

  void onTrackedSectionsClicked() {
    var parameters = {AKeys.STATUS: searchContext.section!.status};
    analyticsLogger.logEvent(AKeys.EVENT_POP_TO_TRACKED_SECTIONS, parameters: parameters);

    view.onPopToTrackedSections();
  }
}

abstract class SectionView extends BaseView implements TrackedStatusProvider {
  void setSectionStatus(bool isTracked);
  void onPopToTrackedSections();
  void setNumTrackedSections(int numTrackedSections);
  void showPastSemesterDialog(Subject subject);
}
