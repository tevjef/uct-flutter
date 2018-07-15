import '../data/proto/model.pb.dart';

class SearchContext {

  University university;
  Semester semester;
  Subject subject;
  Course course;
  Section section;

  String get sectionTopicName => section.topicName;

  String get searchTopicName => "aaaaaaaaa";

//  String get searchTopicName => university.topicName +
//      semester.season +
//      semester.year.toString();
}
