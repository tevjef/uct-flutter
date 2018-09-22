import 'package:collection/collection.dart';

import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';

abstract class HomeView implements BaseView, ListOps {}

class HomePresenter {
  HomeView view;

  UCTRepo uctRepo;
  TrackedSectionDao trackedSectionDatabase;

  HomePresenter(this.view) {
    final injector = Injector.getInjector();
    uctRepo = injector.get();
    trackedSectionDatabase = injector.get();
  }

  void onInitState() {
    view.showLoading(true);
    loadTrackedSections();
  }

  void loadTrackedSections() async {
    List<Item> adapterItems = List();

    // Try refreshing all tracked sections.
    List<TrackedSection> trackedSections;
    try {
      trackedSections = await uctRepo.refreshTrackedSections();
    } catch (e) {
      view.showErrorMessage(e, loadTrackedSections);
      return;
    }

    // Convert data model to "display" model
    var searchContexts = trackedSections.map((trackedSections) {
      return trackedSections.toSearchContext();
    }).toList();

    // Sort the data
    mergeSort(searchContexts, compare: (SearchContext a, SearchContext b) {
      return a.subject.name.compareTo(b.subject.name);
    });

    // Create groups of data
    Map<String, List<SearchContext>> subjectGroups =
        groupBy(searchContexts, (SearchContext context) {
      return context.subject.name;
    });

    // For each one of the groups
    subjectGroups.forEach((number, subjectGroup) {
      var subject = subjectGroup[0].subject;

      // Create the group
      var group = GroupItem(subject.topicName);

      // Add a header to the group.
      group.addHeader(HeaderItem(
          S
              .of(view.getContext())
              .headerMessage(subject.name, subject.number)
              .toUpperCase(),
          insets: const EdgeInsets.only(
              left: Dimens.spacingStandard,
              top: Dimens.spacingMedium,
              bottom: Dimens.spacingXsmall,
              right: Dimens.spacingStandard)));

      // For each item in the group
      subjectGroup.forEach((searchContext) {
        // Add the display cell of the data
        group.addItem(SectionItem(searchContext,
            hasTitle: true,
            onReturnFromNavigation: onReturnFromNavigation,
            onItemDismissed: onSectionItemDismissed(group)));
      });

      // Add the group to the running list of cells.
      adapterItems.add(group);
    });

    // Update the UI with the
    view.setListData(adapterItems);
  }

  Function onSectionItemDismissed(GroupItem group) {
    return (SearchContext searchContext, SectionItem item, int position,
        int adapterPosition) {
      // Remove the item from the list.
      var removedItem = view.removeItem(item);

      // Create an undo action.
      var action = SnackBarAction(
          label: S.of(view.getContext()).undo,
          onPressed: () {
            group.insert(position, removedItem);
            view.updateItem(group);
          });

      // Show a message when an item is removed.
      view.showMessage(
          S.of(view.getContext()).unsubscribeMessage(
              searchContext.section.number, searchContext.course.name),
          action);
    };
  }

  void onReturnFromNavigation(bool changed) {
    view.showLoading(true);
    loadTrackedSections();
  }
}
