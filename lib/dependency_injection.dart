import 'data/UCTApiClient.dart';
import 'data/UCTRepo.dart';
import 'ui/search_context.dart';
import 'data/db/recent.dart';
import 'data/db/tracked.dart';

class Injector {
  static final Injector _singleton = new Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  UCTApiClient get apiClient {
    return new UCTApiClient("https://api.staging.coursetrakr.io/v2");
  }

  SearchContext _searchContextSingleton;
  RecentSelectionDatabase _recentSelectionDatabase;
  TrackedSectionDatabase _trackedSectionDatabase;
  UCTRepo _uctRepo;

  SearchContext get searchContext {
    if (_searchContextSingleton == null) {
      _searchContextSingleton = new SearchContext();
    }
    return _searchContextSingleton;
  }

  RecentSelectionDatabase get recentSelectionDatabase {
    if (_recentSelectionDatabase == null) {
      _recentSelectionDatabase = new RecentSelectionDatabase();
    }
    return _recentSelectionDatabase;
  }

  TrackedSectionDatabase get trackedSectionDatabase {
    if (_trackedSectionDatabase == null) {
      _trackedSectionDatabase = new TrackedSectionDatabase();
    }
    return _trackedSectionDatabase;
  }

    UCTRepo get uctRepo {
    if (_uctRepo == null) {
      _uctRepo = new UCTRepo(searchContext, apiClient, trackedSectionDatabase, recentSelectionDatabase);
    }
    return _uctRepo;
  }
}
