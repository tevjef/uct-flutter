import 'dart:async';
import 'dart:io';

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
    return ErrorTransformer.transform(
        http.get("$baseUrl" + "$url").then((http.Response response) {
      logHttp(response);
      final statusCode = response.statusCode;
      if (statusCode < 200 || statusCode >= 300) {
        throw new Exception(
            "Error while getting response [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
      }
      return Response.fromBuffer(response.bodyBytes);
    }));
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
      logHttp(response);
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
    var body = {
      'isSubscribed': isSubscribed.toString(),
      'topicName': topicName,
      'fcmToken': fcmToken,
    };

    return http.post(
      "$baseUrl" + "/subscription",
      body: body,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
    ).then((response) {
      logHttp(response);
      final statusCode = response.statusCode;
      if (statusCode < 200 || statusCode >= 300) {
        throw new Exception(
            "Error while getting contacts [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
      }

      return true;
    });
  }
}

class ErrorTransformer<T> {
  static Future<T> transform<T>(Future<T> f) {
    return f.catchError((error) {
      if (error is IOException) {
        throw NetworkError(
            "Could not connect to Course Trakr servers.", true, error);
      }
      throw GenericError("Opps! Something went wrong.", error);
    });
  }
}

abstract class Retryable {
  bool canRetry();
}

class NetworkError implements Exception, Retryable {
  final String message;
  final bool isRetryable;
  final Exception cause;

  const NetworkError(this.message, this.isRetryable, this.cause);

  @override
  String toString() => message;

  @override
  bool canRetry() => isRetryable;
}

class GenericError implements Exception, Retryable {
  final String message;
  final Exception cause;

  const GenericError(this.message, this.cause);

  @override
  String toString() => message;

  @override
  bool canRetry() => false;
}
