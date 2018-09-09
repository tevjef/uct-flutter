import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

import 'proto/model.pb.dart';

abstract class UCTApi {
  Future<List<University>> universities();

  Future<List<Course>> courses(String subjectTopicName);

  Future<Section> section(String sectionTopicName);

  Future<List<Subject>> subjects(
      String universityTopicName, String season, String year);

  Future<bool> acknowledgeNotification(String receiveAt, String topicName,
      String fcmToken, String notificationId);

  Future<bool> subscription(
      bool isSubscribed, String topicName, String fcmToken);
}

class UCTApiClient implements UCTApi {
  String baseUrl;

  UCTApiClient(this.baseUrl);

  final Logger log = new Logger('UCTApiClient');

  @override
  Future<List<University>> universities() {
    return getResponse("/universities").then((Response response) {
      return response.data.universities;
    });
  }

  @override
  Future<List<Course>> courses(String subjectTopicName) {
    return getResponse("/courses/$subjectTopicName").then((Response response) {
      return response.data.courses;
    });
  }

  @override
  Future<Section> section(String sectionTopicName) {
    return getResponse("/section/$sectionTopicName").then((Response response) {
      return response.data.section;
    });
  }

  @override
  Future<List<Subject>> subjects(
      String universityTopicName, String season, String year) {
    return getResponse("/subjects/$universityTopicName/$season/$year")
        .then((Response response) {
      return response.data.subjects;
    });
  }

  Future<Response> getResponse(String url) {
    return http.get("$baseUrl" + "$url").then((http.Response response) {
      logHttp(response);
      final statusCode = response.statusCode;
      if (statusCode < 200 || statusCode >= 300) {
        throw new Exception(
            "Error while getting response [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
      }
      return Response.fromBuffer(response.bodyBytes);
    });
  }

  void logHttp(http.Response response) {
    log.info(response.request.toString());
    log.info(response.headers.toString());
  }

  @override
  Future<bool> acknowledgeNotification(String receiveAt, String topicName,
      String fcmToken, String notificationId) {
    return http.post(
      "$baseUrl" + "/notification",
      body: {
        'receiveAt': receiveAt,
        'topicName': topicName,
        'fcmToken': fcmToken,
        'notificationId': notificationId,
      },
    ).then((response) {
      final statusCode = response.statusCode;
      if (statusCode < 200 || statusCode >= 300) {
        throw new Exception(
            "Error while getting contacts [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
      }

      return true;
    });
  }

  @override
  Future<bool> subscription(
      bool isSubscribed, String topicName, String fcmToken) {
    return http.post(
      "$baseUrl" + "/subscription",
      body: {
        'isSubscribed': isSubscribed,
        'topicName': topicName,
        'fcmToken': fcmToken,
      },
    ).then((response) {
      final statusCode = response.statusCode;
      if (statusCode < 200 || statusCode >= 300) {
        throw new Exception(
            "Error while getting contacts [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
      }

      return true;
    });
  }
}
