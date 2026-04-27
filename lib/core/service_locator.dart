import 'package:get_it/get_it.dart';

import '../data/lib.dart';

final getIt = GetIt.instance;

class Locator {
  static void init() {
    getIt.registerLazySingleton<String>(
        () => "https://universitycoursetracker.firebaseapp.com/v2",
        instanceName: "apiUrl");

    getIt.registerLazySingleton<UCTApiClient>(
        () => UCTApiClient(getIt<String>(instanceName: "apiUrl")));

    getIt.registerLazySingleton<RecentSelectionDao>(() => RecentSelectionDao());

    getIt.registerLazySingleton<TrackedSectionDao>(() => TrackedSectionDao());

    getIt.registerLazySingleton<PreferenceDao>(() => PreferenceDao());

    getIt.registerLazySingleton<SearchContext>(() => SearchContext());

    getIt.registerLazySingleton<AnalyticsLogger>(() => AnalyticsLogger());

    getIt.registerLazySingleton<NotificationRepo>(
        () => NotificationRepo(getIt<AnalyticsLogger>()));

    getIt.registerLazySingleton<AdInitializer>(() => AdInitializer());

    getIt.registerLazySingleton<UCTRepo>(() => UCTRepo(
          getIt<SearchContext>(),
          getIt<UCTApiClient>(),
          getIt<TrackedSectionDao>(),
          getIt<RecentSelectionDao>(),
          getIt<NotificationRepo>(),
        ));
  }
}
