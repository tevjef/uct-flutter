import 'package:flutter_simple_dependency_injection/injector.dart';

import '../data/lib.dart';

class Locator {
  static void init() {
    final injector = Injector.getInjector();

    injector.map<String>((i) => "https://api.staging.coursetrakr.io/v2",
        key: "apiUrl");
    injector.map<UCTApiClient>(
        (i) => new UCTApiClient(i.get<String>(key: "apiUrl")),
        isSingleton: true);

    injector.map<RecentSelectionDao>((i) => new RecentSelectionDao(),
        isSingleton: true);

    injector.map<TrackedSectionDao>((i) => new TrackedSectionDao(),
        isSingleton: true);

    injector.map<PreferenceDao>((i) => new PreferenceDao(), isSingleton: true);

    injector.map<SearchContext>((i) => new SearchContext(), isSingleton: true);

    injector.map<AnalyticsLogger>((i) => new AnalyticsLogger(),
        isSingleton: true);

    injector.map<NotificationRepo>((i) => new NotificationRepo(i.get()),
        isSingleton: true);

    injector.map<AdInitializer>((i) => new AdInitializer(), isSingleton: true);

    injector.map<UCTRepo>(
        (i) => new UCTRepo(
              i.get(),
              i.get(),
              i.get(),
              i.get(),
              i.get(),
            ),
        isSingleton: true);
  }
}
