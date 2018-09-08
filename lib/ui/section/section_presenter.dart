import '../../data/UCTApiClient.dart';
import '../../data/UCTRepo.dart';
import '../../data/db/tracked.dart';
import '../../data/proto/model.pb.dart';
import '../../dependency_injection.dart';
import '../routing/home_router.dart';
import '../rv.dart';
import '../search_context.dart';
import '../styles.dart';
import '../tracked_status_provider.dart';
import '../widgets/adapter.dart';

class SectionPresenter {
  SectionView view;
  HomeRouter router;
  Section section;

  SearchContext searchContext;
  UCTApiClient apiClient;
  UCTRepo uctRepo;
  TrackedSectionDao trackedSectionDatabase;

  SectionPresenter(this.view, this.router, this.searchContext) {
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
    adapterItems.add(SectionItem(searchContext, section, router));
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
