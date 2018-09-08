import 'package:collection/collection.dart';

import '../../data/UCTApiClient.dart';
import '../../data/db/tracked.dart';
import '../../dependency_injection.dart';
import '../routing/home_router.dart';
import '../rv.dart';
import '../search_context.dart';
import '../widgets/adapter.dart';

class HomePresenter {
  HomeView view;
  UCTApiClient apiClient;
  HomeRouter router;

  TrackedSectionDao trackedSectionDatabase;

  List<TrackedSection> trackedSections;

  Function sectionClickCallback;

  HomePresenter(this.view, this.router) {
    apiClient = new Injector().apiClient;
    trackedSectionDatabase = Injector().trackedSectionDatabase;
  }

  void loadTrackedSections() async {
    List<Item> adapterItems = List();

    var trackedSections = await trackedSectionDatabase.getAllTrackedSections();

    var onNavigated = (bool changed) {
      loadTrackedSections();
    };

    var searchContexts = trackedSections.map((trackedSections) {
      return trackedSections.toSearchContext();
    });

    Map<String, List<SearchContext>> subjectGroups =
        groupBy(searchContexts, (SearchContext context) {
      return context.subject.number;
    });

    subjectGroups.forEach((number, subjectGroup) {
      var subject = subjectGroup[0].subject;
      adapterItems.add(HeaderItem(
        "${subject.name} (${subject.number})".toUpperCase(),
      ));
      subjectGroup.forEach((searchContext) {
        adapterItems.add(SectionItem(
            searchContext, searchContext.section, router,
            onNavigated: onNavigated, hasTitle: true));
      });
    });

    view.onHomeSuccess(adapterItems);
  }
}

abstract class HomeView {
  void onDefaultError();

  void onHomeSuccess(List<Item> adapterItems);

  void onHomeError(String message);
}
