import 'package:collection/collection.dart';

import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';

abstract class HomeView implements BaseView {}

class HomePresenter {
  HomeView view;
  UCTApiClient apiClient;

  TrackedSectionDao trackedSectionDatabase;

  List<TrackedSection> trackedSections;

  Function sectionClickCallback;

  HomePresenter(this.view) {
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
    }).toList();

    mergeSort(searchContexts, compare: (SearchContext a, SearchContext b) {
      return a.subject.name.compareTo(b.subject.name);
    });

    Map<String, List<SearchContext>> subjectGroups =
        groupBy(searchContexts, (SearchContext context) {
      return context.subject.name;
    });

    subjectGroups.forEach((number, subjectGroup) {
      var subject = subjectGroup[0].subject;
      adapterItems.add(HeaderItem(
        "${subject.name} (${subject.number})".toUpperCase(),
      ));
      subjectGroup.forEach((searchContext) {
        adapterItems.add(SectionItem(searchContext,
            onNavigated: onNavigated, hasTitle: true));
      });
    });

    view.setListData(adapterItems);
  }
}
