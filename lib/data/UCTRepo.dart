import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

import '../data/UCTApiClient.dart';
import '../data/admob/ad_mob.dart';
import '../data/db/recent.dart';
import '../data/db/tracked.dart';
import '../data/proto/model.pb.dart';
import '../data/search_context.dart';

class UCTRepo {
  SearchContext searchContext;
  UCTApiClient apiClient;
  TrackedSectionDao trackedSectionDatabase;
  RecentSelectionDao recentSelectionDatabase;
  AdInitializer adInitializer;

  DateTime lastRefresh;
  Duration minTimeBetweenRefresh = Duration(seconds: 5);

  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  UCTRepo(this.searchContext, this.apiClient, this.trackedSectionDatabase,
      this.recentSelectionDatabase, this.adInitializer) {}

  void unsubscribe(String topicName) async {
    var token = await _firebaseMessaging.getToken();

    var numDeleted = await trackedSectionDatabase
        .deleteTrackedSection(topicName);

    _firebaseMessaging.unsubscribeFromTopic(topicName);

    apiClient.subscription(false, topicName, token);
  }

  Future<bool> toggleSection(SearchContext searchContext) async {
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));

    var isTracked = await trackedSectionDatabase
        .isSectionTracked(searchContext.sectionTopicName);

    var token = await _firebaseMessaging.getToken();
    print("Push Messaging token: $token");

    if (isTracked) {
      await unsubscribe(searchContext.sectionTopicName);

      return !isTracked;
    } else {
      var trackedSection =
          await trackedSectionDatabase.insertSearchContext(searchContext);

      _firebaseMessaging.subscribeToTopic(trackedSection.topicName);

      apiClient.subscription(true, trackedSection.topicName, token);

      return !isTracked;
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
