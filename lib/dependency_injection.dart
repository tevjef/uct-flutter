import 'data/UCTApiClient.dart';

class Injector {
  static final Injector _singleton = new Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  UCTApiClient get apiClient {
    return UCTApiClient("https://api.coursetrakr.io/v2");
  }
}
