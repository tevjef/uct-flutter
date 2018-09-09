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

  SearchContext updateWithAnother(SearchContext anotherSearchContent) {
    return this.updateWith(
      university: anotherSearchContent.university,
      semester: anotherSearchContent.semester,
      subject: anotherSearchContent.subject,
      course: anotherSearchContent.course,
      section: anotherSearchContent.section,
    );
  }

  SearchContext updateWith(
      {University university,
      Semester semester,
      Subject subject,
      Course course,
      Section section}) {
    this.university = university ?? this.university;
    this.semester = semester ?? this.semester;
    this.subject = subject ?? this.subject;
    this.course = course ?? this.course;
    this.section = section ?? this.section;
    return this;
  }

  SearchContext copyWith(
      {University university,
      Semester semester,
      Subject subject,
      Course course,
      Section section}) {
    var newSearchContext = SearchContext();
    newSearchContext.university = university ?? this.university;
    newSearchContext.semester = semester ?? this.semester;
    newSearchContext.subject = subject ?? this.subject;
    newSearchContext.course = course ?? this.course;
    newSearchContext.section = section ?? this.section;
    return newSearchContext;
  }

  void reset() {
    university = null;
    semester = null;
    subject = null;
    course = null;
    section = null;
  }
}
