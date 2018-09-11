import 'dart:async';

import '../data/UCTApiClient.dart';
import '../data/db/recent.dart';
import '../data/db/tracked.dart';
import '../data/proto/model.pb.dart';
import '../data/search_context.dart';

class UCTRepo {
  SearchContext searchContext;
  UCTApiClient apiClient;
  TrackedSectionDao trackedSectionDatabase;
  RecentSelectionDao recentSelectionDatabase;

  DateTime lastRefresh;
  Duration minTimeBetweenRefresh = Duration(seconds: 5);

  UCTRepo(this.searchContext, this.apiClient, this.trackedSectionDatabase,
      this.recentSelectionDatabase);

  Future<bool> toggleSection(SearchContext searchContext) async {
    var isTracked = await trackedSectionDatabase
        .isSectionTracked(searchContext.sectionTopicName);

    if (isTracked) {
      return trackedSectionDatabase
          .deleteTrackedSection(searchContext.sectionTopicName)
          .then((trackedSection) {
        return !isTracked;
      });
      ;
//          .then((didDelete) {
//        if (didDelete) {
//          apiClient.subscription(
//              false, searchContext.topicName, "aaaaaasaaaaaaaa");
//        }
      // Unregister from FCM
    } else {
      return trackedSectionDatabase
          .insertSearchContext(searchContext)
          .then((trackedSection) {
        return !isTracked;
      });
//          .then((trackedSection) {
//        apiClient.subscription(
//            true, searchContext.topicName, "aaaaaasaaaaaaaa");
//      });
      // Register to FCM
    }
  }

  Future<List<TrackedSection>> refreshTrackedSections() async {
    var allTrackedSections =
        await trackedSectionDatabase.getAllTrackedSections();

    if (!showRefresh()) {
      return allTrackedSections;
    }

    List<Future<TrackedSection>> allCalls =
        allTrackedSections.map((trackedSection) {
      return Future(() async {
        var section = await apiClient.section(trackedSection.section.topicName);

        if (section != trackedSection.section) {
          var newTrackedSection = trackedSection;
          newTrackedSection.section = section;
          trackedSectionDatabase.insertTrackedSection(newTrackedSection);

          return newTrackedSection;
        }

        return trackedSection;
      });
    }).toList();

    List<TrackedSection> newTrackedSections = await Future.wait(allCalls);

    return newTrackedSections;
  }

  bool showRefresh() {
    var currentTime = DateTime.now();

    if (lastRefresh == null) {
      lastRefresh = currentTime;
      return true;
    }

    var shouldRefresh = currentTime.millisecondsSinceEpoch -
            lastRefresh.millisecondsSinceEpoch >
        minTimeBetweenRefresh.inMilliseconds;

    if (shouldRefresh) {
      lastRefresh = currentTime;
    }
    return shouldRefresh;
  }
}

class SectionResult {
  Section section;
  TrackedSection trackedSection;

  SectionResult(this.section, this.trackedSection);
}
