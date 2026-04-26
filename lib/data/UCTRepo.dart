import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:uctflutter/data/lib.dart';

class UCTRepo {
  SearchContext searchContext;
  UCTApiClient apiClient;
  TrackedSectionDao trackedSectionDatabase;
  RecentSelectionDao recentSelectionDatabase;
  NotificationRepo notificationRepo;

  DateTime? lastRefresh;
  Duration minTimeBetweenRefresh = Duration(seconds: 5);

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  UCTRepo(this.searchContext, this.apiClient, this.trackedSectionDatabase,
      this.recentSelectionDatabase, this.notificationRepo) {}

  Future<bool> unsubscribe(String topicName) async {
    var token = await _firebaseMessaging.getToken();

    if (token == null) {
      return Future.value(false);
    }

    var _ = await trackedSectionDatabase
        .deleteTrackedSection(topicName);

    _firebaseMessaging.unsubscribeFromTopic(topicName);

    return await apiClient.subscription(false, topicName, token);
  }

  Future<bool> toggleSection(SearchContext searchContext) async {
    await notificationRepo.setupFlutterNotifications();

    var isTracked = await trackedSectionDatabase
        .isSectionTracked(searchContext.sectionTopicName);

    var token = await _firebaseMessaging.getToken();

    print("Push Messaging token: $token");

    if (isTracked) {
      unsubscribe(searchContext.sectionTopicName);

      return !isTracked;
    } else {
      var trackedSection =
          await trackedSectionDatabase.insertSearchContext(searchContext);

      _firebaseMessaging.subscribeToTopic(trackedSection.topicName!);

      await apiClient.subscription(true, trackedSection.topicName!, token!);

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
        var section = await apiClient.section(trackedSection.section!.topicName);

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
            lastRefresh!.millisecondsSinceEpoch >
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
