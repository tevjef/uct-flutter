import 'data/UCTApiClient.dart';
import 'ui/search_context.dart';

class Injector {
  static final Injector _singleton = new Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  UCTApiClient get apiClient {
    return new UCTApiClient("https://api.coursetrakr.io/v2");
  }

  SearchContext _searchContextSingleton;

  SearchContext get searchContext {
    if (_searchContextSingleton == null) {
      _searchContextSingleton = new SearchContext();
    }
    return _searchContextSingleton;
  }
}
