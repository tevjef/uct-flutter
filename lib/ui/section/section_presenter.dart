import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';

class SectionPresenter extends BasePresenter<SectionView> {
  SearchContext searchContext;
  UCTRepo uctRepo;
  TrackedSectionDao trackedSectionDatabase;

  SectionPresenter(SectionView view) : super(view) {
    final injector = Injector.getInjector();
    trackedSectionDatabase = injector.get();
    uctRepo = injector.get();
    searchContext = injector.get();
  }

  void loadSection() async {
    Section section = searchContext.section;

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
    view.setListData(adapterItems);
    loadStatus(section);
  }

  void loadStatus(Section section) async {
    var isTracked =
        await trackedSectionDatabase.isSectionTracked(section.topicName);

    view.setSectionStatus(isTracked);
  }

  void toggleSection(SearchContext searchContext) async {
    try {
      var isTracked = await uctRepo.toggleSection(searchContext);
      view.setSectionStatus(isTracked);
    } catch (e) {
      view.showErrorMessage(e);
    }
  }
}

abstract class SectionView extends BaseView implements TrackedStatusProvider {
  void setSectionStatus(bool isTracked);
}
