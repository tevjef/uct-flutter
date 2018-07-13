import '../../data/UCTApiClient.dart';
import '../../data/UCTRepo.dart';
import '../../data/db/recent.dart';
import '../../data/db/tracked.dart';
import '../../data/proto/model.pb.dart';
import '../../dependency_injection.dart';
import '../home/home_router.dart';
import '../rv.dart';
import '../search_context.dart';
import '../widgets/adapter.dart';
import '../tracked_status_provider.dart';
import '../styles.dart';

class SectionPresenter {
  SectionView view;
  HomeRouter router;
  Section section;

  SearchContext searchContext;
  UCTApiClient apiClient;
  UCTRepo uctRepo;
  TrackedSectionDatabase trackedSectionDatabase;
  RecentSelectionDatabase recentSelectionDatabase;

  SectionPresenter(this.view, this.router) {
    searchContext = Injector().searchContext;
    trackedSectionDatabase = Injector().trackedSectionDatabase;
    recentSelectionDatabase = Injector().recentSelectionDatabase;
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
    if (section.metadata.isNotEmpty) {
      section.metadata.forEach((meta) {
        metaItems.add(MetadataItem(meta.title, meta.content));
      });
    }

    adapterItems.addAll(metaItems);
    adapterItems.add(SectionItem(section, router));
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
      print(isTracked);
      view.setSectionStatus(isTracked);
    });
  }
}

abstract class SectionView implements TrackedStatusProvider {
  void onSectionSuccess(List<Item> adapterItems);

  void onSectionError(String message);

  void setSectionStatus(bool isTracked);
}



