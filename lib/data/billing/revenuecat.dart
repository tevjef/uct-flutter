import 'package:purchases_flutter/purchases_flutter.dart';

Future<void> initPlatformState() async {
  await Purchases.setDebugLogsEnabled(true);
  await Purchases.setup("CYlafDPgroAQJzEJjPKwqwWEMxnnfzXO", appUserId: "test_id");
}
