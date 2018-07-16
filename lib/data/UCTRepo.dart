import 'dart:async';

import '../data/UCTApiClient.dart';
import '../data/db/recent.dart';
import '../data/db/tracked.dart';
import '../ui/search_context.dart';

class UCTRepo {
  SearchContext searchContext;
  UCTApiClient apiClient;
  TrackedSectionDao trackedSectionDatabase;
  RecentSelectionDao recentSelectionDatabase;

  UCTRepo(this.searchContext, this.apiClient, this.trackedSectionDatabase,
      this.recentSelectionDatabase);

  Future<bool> toggleSection(SearchContext searchContext) async {
    var isTracked = await trackedSectionDatabase.isSectionTracked(searchContext.sectionTopicName);

    if (isTracked) {
      return  trackedSectionDatabase
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
}
