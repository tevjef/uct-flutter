import 'package:collection/collection.dart';

import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';

abstract class HomeView implements BaseView, ListOps {}

class HomePresenter {
  HomeView view;
  UCTRepo uctRepo;

  TrackedSectionDao trackedSectionDatabase;

  List<TrackedSection> trackedSections;

  Function sectionClickCallback;

  HomePresenter(this.view) {
    uctRepo = new Injector().uctRepo;
    trackedSectionDatabase = Injector().trackedSectionDatabase;
  }

  void loadTrackedSections() async {
    List<Item> adapterItems = List();

    List<TrackedSection> trackedSections;

    try {
      trackedSections = await uctRepo.refreshTrackedSections();
    } catch (e) {
      print(e);
      view.showErrorMessage("Could not refresh list.");
      return;
    }

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

      var group = GroupItem(subject.hashCode);

      var onDismissed = (SearchContext searchContext, SectionItem item,
          int position, int adapterPosition) {
        var removedItem = view.removeItem(item);
        var action = SnackBarAction(
            label: "Undo",
            onPressed: () {
              group.insert(position, removedItem);
              view.updateItem(group);
            });
        view.showMessage(
            "Unsubscried from ${searchContext.section.number} of ${searchContext.course.name}.",
            action);
      };

      group.addHeader(HeaderItem(
          "${subject.name} (${subject.number})".toUpperCase(),
          insets: const EdgeInsets.only(
              left: Dimens.spacingStandard,
              top: Dimens.spacingMedium,
              bottom: Dimens.spacingXsmall,
              right: Dimens.spacingStandard)));

      subjectGroup.forEach((searchContext) {
        group.addItem(SectionItem(searchContext,
            onNavigated: onNavigated,
            hasTitle: true,
            onDismissed: onDismissed));
      });

      adapterItems.add(group);
    });

    view.setListData(adapterItems);
  }
}
