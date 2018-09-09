import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';

class SectionPresenter {
  SectionView view;
  Section section;

  SearchContext searchContext;
  UCTApiClient apiClient;
  UCTRepo uctRepo;
  TrackedSectionDao trackedSectionDatabase;

  SectionPresenter(this.view, this.searchContext) {
    trackedSectionDatabase = Injector().trackedSectionDatabase;
    uctRepo = Injector().uctRepo;
    section = searchContext.section;
  }

  void loadSection() async {
    List<Item> adapterItems = List();

    adapterItems.add(SubscribeItem(view, (value) {
      toggleSection(searchContext);
    }));

    adapterItems.add(SpaceItem(height: Dimens.spacingStandard));

    List<MetadataItem> metaItems = new List();
    if (section?.metadata?.isNotEmpty ?? false) {
      section.metadata.forEach((meta) {
        metaItems.add(MetadataItem(meta.title, meta.content));
      });
    }

    adapterItems.addAll(metaItems);
    adapterItems.add(SectionItem(searchContext, navigates: false));
    view.onSectionSuccess(adapterItems);
    loadStatus();
  }

  void loadStatus() {
    trackedSectionDatabase
        .isSectionTracked(section.topicName)
        .then((isTracked) {
      view.setSectionStatus(isTracked);
    });
  }

  void toggleSection(SearchContext searchContext) {
    uctRepo.toggleSection(searchContext).then((isTracked) {
      view.setSectionStatus(isTracked);
    });
  }
}

abstract class SectionView implements TrackedStatusProvider {
  void onSectionSuccess(List<Item> adapterItems);

  void onSectionError(String message);

  void setSectionStatus(bool isTracked);
}
