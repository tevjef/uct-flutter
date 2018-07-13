import '../data/proto/model.pb.dart';

class SearchContext {

  University university;
  Semester semester;
  Subject subject;
  Course course;
  Section section;

  String get topicName => section.topicName;
}
