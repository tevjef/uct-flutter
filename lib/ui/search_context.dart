import '../data/proto/model.pb.dart';

class SearchContext {
  University university;
  Semester semester;
  Subject subject;
  Course course;
  Section section;

  String get sectionTopicName => section.topicName;

  String get searchTopicName =>
      university.topicName + semester.season + semester.year.toString();

  void reset() {
    university = null;
    semester = null;
    subject = null;
    course = null;
    section = null;
  }
}
