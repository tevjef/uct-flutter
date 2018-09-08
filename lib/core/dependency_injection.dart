import '../data/lib.dart';

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

  RecentSelectionDao _recentSelectionDao;
  TrackedSectionDao _trackedSectionDao;
  PreferenceDao _preferenceDao;

  UCTRepo _uctRepo;

  SearchContext get searchContext {
    if (_searchContextSingleton == null) {
      _searchContextSingleton = new SearchContext();
    }
    return _searchContextSingleton;
  }

  RecentSelectionDao get recentSelectionDatabase {
    if (_recentSelectionDao == null) {
      _recentSelectionDao = new RecentSelectionDao();
    }
    return _recentSelectionDao;
  }

  TrackedSectionDao get trackedSectionDatabase {
    if (_trackedSectionDao == null) {
      _trackedSectionDao = new TrackedSectionDao();
    }
    return _trackedSectionDao;
  }

  PreferenceDao get preferenceDao {
    if (_preferenceDao == null) {
      _preferenceDao = new PreferenceDao();
    }
    return _preferenceDao;
  }

  UCTRepo get uctRepo {
    if (_uctRepo == null) {
      _uctRepo = new UCTRepo(searchContext, apiClient, trackedSectionDatabase,
          recentSelectionDatabase);
    }
    return _uctRepo;
  }
}
