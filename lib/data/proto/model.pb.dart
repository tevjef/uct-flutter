///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library model;

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, override;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

class University extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('University')
    ..aInt64(1, 'id')
    ..aOS(2, 'name')
    ..aOS(3, 'abbr')
    ..aOS(4, 'homePage')
    ..aOS(5, 'registrationPage')
    ..aOS(6, 'mainColor')
    ..aOS(7, 'accentColor')
    ..aOS(8, 'topicName')
    ..aOS(9, 'topicId')
    ..a<ResolvedSemester>(10, 'resolvedSemesters', PbFieldType.OM, ResolvedSemester.getDefault, ResolvedSemester.create)
    ..pp<Subject>(11, 'subjects', PbFieldType.PM, Subject.$checkItem, Subject.create)
    ..pp<Semester>(12, 'availableSemesters', PbFieldType.PM, Semester.$checkItem, Semester.create)
    ..pp<Registration>(13, 'registrations', PbFieldType.PM, Registration.$checkItem, Registration.create)
    ..pp<Metadata>(14, 'metadata', PbFieldType.PM, Metadata.$checkItem, Metadata.create)
    ..hasRequiredFields = false
  ;

  University() : super();
  University.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  University.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  University clone() => new University()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static University create() => new University();
  static PbList<University> createRepeated() => new PbList<University>();
  static University getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyUniversity();
    return _defaultInstance;
  }
  static University _defaultInstance;
  static void $checkItem(University v) {
    if (v is! University) checkItemFailed(v, 'University');
  }

  Int64 get id => $_getI64(0);
  set id(Int64 v) { $_setInt64(0, v); }
  bool hasId() => $_has(0);
  void clearId() => clearField(1);

  String get name => $_getS(1, '');
  set name(String v) { $_setString(1, v); }
  bool hasName() => $_has(1);
  void clearName() => clearField(2);

  String get abbr => $_getS(2, '');
  set abbr(String v) { $_setString(2, v); }
  bool hasAbbr() => $_has(2);
  void clearAbbr() => clearField(3);

  String get homePage => $_getS(3, '');
  set homePage(String v) { $_setString(3, v); }
  bool hasHomePage() => $_has(3);
  void clearHomePage() => clearField(4);

  String get registrationPage => $_getS(4, '');
  set registrationPage(String v) { $_setString(4, v); }
  bool hasRegistrationPage() => $_has(4);
  void clearRegistrationPage() => clearField(5);

  String get mainColor => $_getS(5, '');
  set mainColor(String v) { $_setString(5, v); }
  bool hasMainColor() => $_has(5);
  void clearMainColor() => clearField(6);

  String get accentColor => $_getS(6, '');
  set accentColor(String v) { $_setString(6, v); }
  bool hasAccentColor() => $_has(6);
  void clearAccentColor() => clearField(7);

  String get topicName => $_getS(7, '');
  set topicName(String v) { $_setString(7, v); }
  bool hasTopicName() => $_has(7);
  void clearTopicName() => clearField(8);

  String get topicId => $_getS(8, '');
  set topicId(String v) { $_setString(8, v); }
  bool hasTopicId() => $_has(8);
  void clearTopicId() => clearField(9);

  ResolvedSemester get resolvedSemesters => $_getN(9);
  set resolvedSemesters(ResolvedSemester v) { setField(10, v); }
  bool hasResolvedSemesters() => $_has(9);
  void clearResolvedSemesters() => clearField(10);

  List<Subject> get subjects => $_getList(10);

  List<Semester> get availableSemesters => $_getList(11);

  List<Registration> get registrations => $_getList(12);

  List<Metadata> get metadata => $_getList(13);
}

class _ReadonlyUniversity extends University with ReadonlyMessageMixin {}

class Subject extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Subject')
    ..aInt64(1, 'id')
    ..aInt64(2, 'universityId')
    ..aOS(3, 'name')
    ..aOS(4, 'number')
    ..aOS(5, 'season')
    ..aOS(6, 'year')
    ..aOS(7, 'topicName')
    ..aOS(8, 'topicId')
    ..pp<Course>(9, 'courses', PbFieldType.PM, Course.$checkItem, Course.create)
    ..pp<Metadata>(10, 'metadata', PbFieldType.PM, Metadata.$checkItem, Metadata.create)
    ..hasRequiredFields = false
  ;

  Subject() : super();
  Subject.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Subject.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Subject clone() => new Subject()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Subject create() => new Subject();
  static PbList<Subject> createRepeated() => new PbList<Subject>();
  static Subject getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySubject();
    return _defaultInstance;
  }
  static Subject _defaultInstance;
  static void $checkItem(Subject v) {
    if (v is! Subject) checkItemFailed(v, 'Subject');
  }

  Int64 get id => $_getI64(0);
  set id(Int64 v) { $_setInt64(0, v); }
  bool hasId() => $_has(0);
  void clearId() => clearField(1);

  Int64 get universityId => $_getI64(1);
  set universityId(Int64 v) { $_setInt64(1, v); }
  bool hasUniversityId() => $_has(1);
  void clearUniversityId() => clearField(2);

  String get name => $_getS(2, '');
  set name(String v) { $_setString(2, v); }
  bool hasName() => $_has(2);
  void clearName() => clearField(3);

  String get number => $_getS(3, '');
  set number(String v) { $_setString(3, v); }
  bool hasNumber() => $_has(3);
  void clearNumber() => clearField(4);

  String get season => $_getS(4, '');
  set season(String v) { $_setString(4, v); }
  bool hasSeason() => $_has(4);
  void clearSeason() => clearField(5);

  String get year => $_getS(5, '');
  set year(String v) { $_setString(5, v); }
  bool hasYear() => $_has(5);
  void clearYear() => clearField(6);

  String get topicName => $_getS(6, '');
  set topicName(String v) { $_setString(6, v); }
  bool hasTopicName() => $_has(6);
  void clearTopicName() => clearField(7);

  String get topicId => $_getS(7, '');
  set topicId(String v) { $_setString(7, v); }
  bool hasTopicId() => $_has(7);
  void clearTopicId() => clearField(8);

  List<Course> get courses => $_getList(8);

  List<Metadata> get metadata => $_getList(9);
}

class _ReadonlySubject extends Subject with ReadonlyMessageMixin {}

class Course extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Course')
    ..aInt64(1, 'id')
    ..aInt64(2, 'subjectId')
    ..aOS(3, 'name')
    ..aOS(4, 'number')
    ..aOS(5, 'synopsis')
    ..aOS(6, 'topicName')
    ..aOS(7, 'topicId')
    ..pp<Section>(8, 'sections', PbFieldType.PM, Section.$checkItem, Section.create)
    ..pp<Metadata>(9, 'metadata', PbFieldType.PM, Metadata.$checkItem, Metadata.create)
    ..hasRequiredFields = false
  ;

  Course() : super();
  Course.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Course.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Course clone() => new Course()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Course create() => new Course();
  static PbList<Course> createRepeated() => new PbList<Course>();
  static Course getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCourse();
    return _defaultInstance;
  }
  static Course _defaultInstance;
  static void $checkItem(Course v) {
    if (v is! Course) checkItemFailed(v, 'Course');
  }

  Int64 get id => $_getI64(0);
  set id(Int64 v) { $_setInt64(0, v); }
  bool hasId() => $_has(0);
  void clearId() => clearField(1);

  Int64 get subjectId => $_getI64(1);
  set subjectId(Int64 v) { $_setInt64(1, v); }
  bool hasSubjectId() => $_has(1);
  void clearSubjectId() => clearField(2);

  String get name => $_getS(2, '');
  set name(String v) { $_setString(2, v); }
  bool hasName() => $_has(2);
  void clearName() => clearField(3);

  String get number => $_getS(3, '');
  set number(String v) { $_setString(3, v); }
  bool hasNumber() => $_has(3);
  void clearNumber() => clearField(4);

  String get synopsis => $_getS(4, '');
  set synopsis(String v) { $_setString(4, v); }
  bool hasSynopsis() => $_has(4);
  void clearSynopsis() => clearField(5);

  String get topicName => $_getS(5, '');
  set topicName(String v) { $_setString(5, v); }
  bool hasTopicName() => $_has(5);
  void clearTopicName() => clearField(6);

  String get topicId => $_getS(6, '');
  set topicId(String v) { $_setString(6, v); }
  bool hasTopicId() => $_has(6);
  void clearTopicId() => clearField(7);

  List<Section> get sections => $_getList(7);

  List<Metadata> get metadata => $_getList(8);
}

class _ReadonlyCourse extends Course with ReadonlyMessageMixin {}

class Section extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Section')
    ..aInt64(1, 'id')
    ..aInt64(2, 'courseId')
    ..aOS(3, 'number')
    ..aOS(4, 'callNumber')
    ..aInt64(5, 'max')
    ..aInt64(6, 'now')
    ..aOS(7, 'status')
    ..aOS(8, 'credits')
    ..aOS(9, 'topicName')
    ..aOS(10, 'topicId')
    ..pp<Meeting>(11, 'meetings', PbFieldType.PM, Meeting.$checkItem, Meeting.create)
    ..pp<Instructor>(12, 'instructors', PbFieldType.PM, Instructor.$checkItem, Instructor.create)
    ..pp<Book>(13, 'books', PbFieldType.PM, Book.$checkItem, Book.create)
    ..pp<Metadata>(14, 'metadata', PbFieldType.PM, Metadata.$checkItem, Metadata.create)
    ..hasRequiredFields = false
  ;

  Section() : super();
  Section.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Section.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Section clone() => new Section()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Section create() => new Section();
  static PbList<Section> createRepeated() => new PbList<Section>();
  static Section getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySection();
    return _defaultInstance;
  }
  static Section _defaultInstance;
  static void $checkItem(Section v) {
    if (v is! Section) checkItemFailed(v, 'Section');
  }

  Int64 get id => $_getI64(0);
  set id(Int64 v) { $_setInt64(0, v); }
  bool hasId() => $_has(0);
  void clearId() => clearField(1);

  Int64 get courseId => $_getI64(1);
  set courseId(Int64 v) { $_setInt64(1, v); }
  bool hasCourseId() => $_has(1);
  void clearCourseId() => clearField(2);

  String get number => $_getS(2, '');
  set number(String v) { $_setString(2, v); }
  bool hasNumber() => $_has(2);
  void clearNumber() => clearField(3);

  String get callNumber => $_getS(3, '');
  set callNumber(String v) { $_setString(3, v); }
  bool hasCallNumber() => $_has(3);
  void clearCallNumber() => clearField(4);

  Int64 get max => $_getI64(4);
  set max(Int64 v) { $_setInt64(4, v); }
  bool hasMax() => $_has(4);
  void clearMax() => clearField(5);

  Int64 get now => $_getI64(5);
  set now(Int64 v) { $_setInt64(5, v); }
  bool hasNow() => $_has(5);
  void clearNow() => clearField(6);

  String get status => $_getS(6, '');
  set status(String v) { $_setString(6, v); }
  bool hasStatus() => $_has(6);
  void clearStatus() => clearField(7);

  String get credits => $_getS(7, '');
  set credits(String v) { $_setString(7, v); }
  bool hasCredits() => $_has(7);
  void clearCredits() => clearField(8);

  String get topicName => $_getS(8, '');
  set topicName(String v) { $_setString(8, v); }
  bool hasTopicName() => $_has(8);
  void clearTopicName() => clearField(9);

  String get topicId => $_getS(9, '');
  set topicId(String v) { $_setString(9, v); }
  bool hasTopicId() => $_has(9);
  void clearTopicId() => clearField(10);

  List<Meeting> get meetings => $_getList(10);

  List<Instructor> get instructors => $_getList(11);

  List<Book> get books => $_getList(12);

  List<Metadata> get metadata => $_getList(13);
}

class _ReadonlySection extends Section with ReadonlyMessageMixin {}

class Meeting extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Meeting')
    ..aInt64(1, 'id')
    ..aInt64(2, 'sectionId')
    ..aOS(3, 'room')
    ..aOS(4, 'day')
    ..aOS(5, 'startTime')
    ..aOS(6, 'endTime')
    ..aOS(7, 'classType')
    ..a<int>(8, 'index', PbFieldType.O3)
    ..pp<Metadata>(9, 'metadata', PbFieldType.PM, Metadata.$checkItem, Metadata.create)
    ..hasRequiredFields = false
  ;

  Meeting() : super();
  Meeting.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Meeting.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Meeting clone() => new Meeting()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Meeting create() => new Meeting();
  static PbList<Meeting> createRepeated() => new PbList<Meeting>();
  static Meeting getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyMeeting();
    return _defaultInstance;
  }
  static Meeting _defaultInstance;
  static void $checkItem(Meeting v) {
    if (v is! Meeting) checkItemFailed(v, 'Meeting');
  }

  Int64 get id => $_getI64(0);
  set id(Int64 v) { $_setInt64(0, v); }
  bool hasId() => $_has(0);
  void clearId() => clearField(1);

  Int64 get sectionId => $_getI64(1);
  set sectionId(Int64 v) { $_setInt64(1, v); }
  bool hasSectionId() => $_has(1);
  void clearSectionId() => clearField(2);

  String get room => $_getS(2, '');
  set room(String v) { $_setString(2, v); }
  bool hasRoom() => $_has(2);
  void clearRoom() => clearField(3);

  String get day => $_getS(3, '');
  set day(String v) { $_setString(3, v); }
  bool hasDay() => $_has(3);
  void clearDay() => clearField(4);

  String get startTime => $_getS(4, '');
  set startTime(String v) { $_setString(4, v); }
  bool hasStartTime() => $_has(4);
  void clearStartTime() => clearField(5);

  String get endTime => $_getS(5, '');
  set endTime(String v) { $_setString(5, v); }
  bool hasEndTime() => $_has(5);
  void clearEndTime() => clearField(6);

  String get classType => $_getS(6, '');
  set classType(String v) { $_setString(6, v); }
  bool hasClassType() => $_has(6);
  void clearClassType() => clearField(7);

  int get index => $_get(7, 0);
  set index(int v) { $_setUnsignedInt32(7, v); }
  bool hasIndex() => $_has(7);
  void clearIndex() => clearField(8);

  List<Metadata> get metadata => $_getList(8);
}

class _ReadonlyMeeting extends Meeting with ReadonlyMessageMixin {}

class Instructor extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Instructor')
    ..aInt64(1, 'id')
    ..aInt64(2, 'sectionId')
    ..aOS(3, 'name')
    ..a<int>(4, 'index', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  Instructor() : super();
  Instructor.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Instructor.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Instructor clone() => new Instructor()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Instructor create() => new Instructor();
  static PbList<Instructor> createRepeated() => new PbList<Instructor>();
  static Instructor getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyInstructor();
    return _defaultInstance;
  }
  static Instructor _defaultInstance;
  static void $checkItem(Instructor v) {
    if (v is! Instructor) checkItemFailed(v, 'Instructor');
  }

  Int64 get id => $_getI64(0);
  set id(Int64 v) { $_setInt64(0, v); }
  bool hasId() => $_has(0);
  void clearId() => clearField(1);

  Int64 get sectionId => $_getI64(1);
  set sectionId(Int64 v) { $_setInt64(1, v); }
  bool hasSectionId() => $_has(1);
  void clearSectionId() => clearField(2);

  String get name => $_getS(2, '');
  set name(String v) { $_setString(2, v); }
  bool hasName() => $_has(2);
  void clearName() => clearField(3);

  int get index => $_get(3, 0);
  set index(int v) { $_setUnsignedInt32(3, v); }
  bool hasIndex() => $_has(3);
  void clearIndex() => clearField(4);
}

class _ReadonlyInstructor extends Instructor with ReadonlyMessageMixin {}

class Book extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Book')
    ..aInt64(1, 'id')
    ..aInt64(2, 'sectionId')
    ..aOS(3, 'title')
    ..aOS(4, 'url')
    ..hasRequiredFields = false
  ;

  Book() : super();
  Book.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Book.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Book clone() => new Book()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Book create() => new Book();
  static PbList<Book> createRepeated() => new PbList<Book>();
  static Book getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyBook();
    return _defaultInstance;
  }
  static Book _defaultInstance;
  static void $checkItem(Book v) {
    if (v is! Book) checkItemFailed(v, 'Book');
  }

  Int64 get id => $_getI64(0);
  set id(Int64 v) { $_setInt64(0, v); }
  bool hasId() => $_has(0);
  void clearId() => clearField(1);

  Int64 get sectionId => $_getI64(1);
  set sectionId(Int64 v) { $_setInt64(1, v); }
  bool hasSectionId() => $_has(1);
  void clearSectionId() => clearField(2);

  String get title => $_getS(2, '');
  set title(String v) { $_setString(2, v); }
  bool hasTitle() => $_has(2);
  void clearTitle() => clearField(3);

  String get url => $_getS(3, '');
  set url(String v) { $_setString(3, v); }
  bool hasUrl() => $_has(3);
  void clearUrl() => clearField(4);
}

class _ReadonlyBook extends Book with ReadonlyMessageMixin {}

class Metadata extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Metadata')
    ..aInt64(1, 'id')
    ..aInt64(2, 'universityId')
    ..aInt64(3, 'subjectId')
    ..aInt64(4, 'courseId')
    ..aInt64(5, 'sectionId')
    ..aInt64(6, 'meetingId')
    ..aOS(7, 'title')
    ..aOS(8, 'content')
    ..hasRequiredFields = false
  ;

  Metadata() : super();
  Metadata.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Metadata.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Metadata clone() => new Metadata()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Metadata create() => new Metadata();
  static PbList<Metadata> createRepeated() => new PbList<Metadata>();
  static Metadata getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyMetadata();
    return _defaultInstance;
  }
  static Metadata _defaultInstance;
  static void $checkItem(Metadata v) {
    if (v is! Metadata) checkItemFailed(v, 'Metadata');
  }

  Int64 get id => $_getI64(0);
  set id(Int64 v) { $_setInt64(0, v); }
  bool hasId() => $_has(0);
  void clearId() => clearField(1);

  Int64 get universityId => $_getI64(1);
  set universityId(Int64 v) { $_setInt64(1, v); }
  bool hasUniversityId() => $_has(1);
  void clearUniversityId() => clearField(2);

  Int64 get subjectId => $_getI64(2);
  set subjectId(Int64 v) { $_setInt64(2, v); }
  bool hasSubjectId() => $_has(2);
  void clearSubjectId() => clearField(3);

  Int64 get courseId => $_getI64(3);
  set courseId(Int64 v) { $_setInt64(3, v); }
  bool hasCourseId() => $_has(3);
  void clearCourseId() => clearField(4);

  Int64 get sectionId => $_getI64(4);
  set sectionId(Int64 v) { $_setInt64(4, v); }
  bool hasSectionId() => $_has(4);
  void clearSectionId() => clearField(5);

  Int64 get meetingId => $_getI64(5);
  set meetingId(Int64 v) { $_setInt64(5, v); }
  bool hasMeetingId() => $_has(5);
  void clearMeetingId() => clearField(6);

  String get title => $_getS(6, '');
  set title(String v) { $_setString(6, v); }
  bool hasTitle() => $_has(6);
  void clearTitle() => clearField(7);

  String get content => $_getS(7, '');
  set content(String v) { $_setString(7, v); }
  bool hasContent() => $_has(7);
  void clearContent() => clearField(8);
}

class _ReadonlyMetadata extends Metadata with ReadonlyMessageMixin {}

class Registration extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Registration')
    ..aInt64(1, 'id')
    ..aInt64(2, 'universityId')
    ..aOS(3, 'period')
    ..aInt64(4, 'periodDate')
    ..hasRequiredFields = false
  ;

  Registration() : super();
  Registration.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Registration.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Registration clone() => new Registration()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Registration create() => new Registration();
  static PbList<Registration> createRepeated() => new PbList<Registration>();
  static Registration getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRegistration();
    return _defaultInstance;
  }
  static Registration _defaultInstance;
  static void $checkItem(Registration v) {
    if (v is! Registration) checkItemFailed(v, 'Registration');
  }

  Int64 get id => $_getI64(0);
  set id(Int64 v) { $_setInt64(0, v); }
  bool hasId() => $_has(0);
  void clearId() => clearField(1);

  Int64 get universityId => $_getI64(1);
  set universityId(Int64 v) { $_setInt64(1, v); }
  bool hasUniversityId() => $_has(1);
  void clearUniversityId() => clearField(2);

  String get period => $_getS(2, '');
  set period(String v) { $_setString(2, v); }
  bool hasPeriod() => $_has(2);
  void clearPeriod() => clearField(3);

  Int64 get periodDate => $_getI64(3);
  set periodDate(Int64 v) { $_setInt64(3, v); }
  bool hasPeriodDate() => $_has(3);
  void clearPeriodDate() => clearField(4);
}

class _ReadonlyRegistration extends Registration with ReadonlyMessageMixin {}

class ResolvedSemester extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ResolvedSemester')
    ..a<Semester>(1, 'current', PbFieldType.OM, Semester.getDefault, Semester.create)
    ..a<Semester>(2, 'last', PbFieldType.OM, Semester.getDefault, Semester.create)
    ..a<Semester>(3, 'next', PbFieldType.OM, Semester.getDefault, Semester.create)
    ..hasRequiredFields = false
  ;

  ResolvedSemester() : super();
  ResolvedSemester.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ResolvedSemester.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ResolvedSemester clone() => new ResolvedSemester()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ResolvedSemester create() => new ResolvedSemester();
  static PbList<ResolvedSemester> createRepeated() => new PbList<ResolvedSemester>();
  static ResolvedSemester getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyResolvedSemester();
    return _defaultInstance;
  }
  static ResolvedSemester _defaultInstance;
  static void $checkItem(ResolvedSemester v) {
    if (v is! ResolvedSemester) checkItemFailed(v, 'ResolvedSemester');
  }

  Semester get current => $_getN(0);
  set current(Semester v) { setField(1, v); }
  bool hasCurrent() => $_has(0);
  void clearCurrent() => clearField(1);

  Semester get last => $_getN(1);
  set last(Semester v) { setField(2, v); }
  bool hasLast() => $_has(1);
  void clearLast() => clearField(2);

  Semester get next => $_getN(2);
  set next(Semester v) { setField(3, v); }
  bool hasNext() => $_has(2);
  void clearNext() => clearField(3);
}

class _ReadonlyResolvedSemester extends ResolvedSemester with ReadonlyMessageMixin {}

class Semester extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Semester')
    ..a<int>(1, 'year', PbFieldType.O3)
    ..aOS(2, 'season')
    ..hasRequiredFields = false
  ;

  Semester() : super();
  Semester.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Semester.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Semester clone() => new Semester()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Semester create() => new Semester();
  static PbList<Semester> createRepeated() => new PbList<Semester>();
  static Semester getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySemester();
    return _defaultInstance;
  }
  static Semester _defaultInstance;
  static void $checkItem(Semester v) {
    if (v is! Semester) checkItemFailed(v, 'Semester');
  }

  int get year => $_get(0, 0);
  set year(int v) { $_setUnsignedInt32(0, v); }
  bool hasYear() => $_has(0);
  void clearYear() => clearField(1);

  String get season => $_getS(1, '');
  set season(String v) { $_setString(1, v); }
  bool hasSeason() => $_has(1);
  void clearSeason() => clearField(2);
}

class _ReadonlySemester extends Semester with ReadonlyMessageMixin {}

class UCTNotification extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('UCTNotification')
    ..aInt64(1, 'notificationId')
    ..aOS(2, 'topicName')
    ..aOS(3, 'status')
    ..a<University>(4, 'university', PbFieldType.OM, University.getDefault, University.create)
    ..hasRequiredFields = false
  ;

  UCTNotification() : super();
  UCTNotification.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  UCTNotification.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  UCTNotification clone() => new UCTNotification()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static UCTNotification create() => new UCTNotification();
  static PbList<UCTNotification> createRepeated() => new PbList<UCTNotification>();
  static UCTNotification getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyUCTNotification();
    return _defaultInstance;
  }
  static UCTNotification _defaultInstance;
  static void $checkItem(UCTNotification v) {
    if (v is! UCTNotification) checkItemFailed(v, 'UCTNotification');
  }

  Int64 get notificationId => $_getI64(0);
  set notificationId(Int64 v) { $_setInt64(0, v); }
  bool hasNotificationId() => $_has(0);
  void clearNotificationId() => clearField(1);

  String get topicName => $_getS(1, '');
  set topicName(String v) { $_setString(1, v); }
  bool hasTopicName() => $_has(1);
  void clearTopicName() => clearField(2);

  String get status => $_getS(2, '');
  set status(String v) { $_setString(2, v); }
  bool hasStatus() => $_has(2);
  void clearStatus() => clearField(3);

  University get university => $_getN(3);
  set university(University v) { setField(4, v); }
  bool hasUniversity() => $_has(3);
  void clearUniversity() => clearField(4);
}

class _ReadonlyUCTNotification extends UCTNotification with ReadonlyMessageMixin {}

class Response extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Response')
    ..a<Meta>(1, 'meta', PbFieldType.OM, Meta.getDefault, Meta.create)
    ..a<Data>(2, 'data', PbFieldType.OM, Data.getDefault, Data.create)
    ..hasRequiredFields = false
  ;

  Response() : super();
  Response.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Response.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Response clone() => new Response()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Response create() => new Response();
  static PbList<Response> createRepeated() => new PbList<Response>();
  static Response getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyResponse();
    return _defaultInstance;
  }
  static Response _defaultInstance;
  static void $checkItem(Response v) {
    if (v is! Response) checkItemFailed(v, 'Response');
  }

  Meta get meta => $_getN(0);
  set meta(Meta v) { setField(1, v); }
  bool hasMeta() => $_has(0);
  void clearMeta() => clearField(1);

  Data get data => $_getN(1);
  set data(Data v) { setField(2, v); }
  bool hasData() => $_has(1);
  void clearData() => clearField(2);
}

class _ReadonlyResponse extends Response with ReadonlyMessageMixin {}

class Meta extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Meta')
    ..a<int>(1, 'code', PbFieldType.O3)
    ..aOS(2, 'message')
    ..hasRequiredFields = false
  ;

  Meta() : super();
  Meta.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Meta.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Meta clone() => new Meta()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Meta create() => new Meta();
  static PbList<Meta> createRepeated() => new PbList<Meta>();
  static Meta getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyMeta();
    return _defaultInstance;
  }
  static Meta _defaultInstance;
  static void $checkItem(Meta v) {
    if (v is! Meta) checkItemFailed(v, 'Meta');
  }

  int get code => $_get(0, 0);
  set code(int v) { $_setUnsignedInt32(0, v); }
  bool hasCode() => $_has(0);
  void clearCode() => clearField(1);

  String get message => $_getS(1, '');
  set message(String v) { $_setString(1, v); }
  bool hasMessage() => $_has(1);
  void clearMessage() => clearField(2);
}

class _ReadonlyMeta extends Meta with ReadonlyMessageMixin {}

class Data extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Data')
    ..pp<University>(1, 'universities', PbFieldType.PM, University.$checkItem, University.create)
    ..pp<Subject>(2, 'subjects', PbFieldType.PM, Subject.$checkItem, Subject.create)
    ..pp<Course>(3, 'courses', PbFieldType.PM, Course.$checkItem, Course.create)
    ..pp<Section>(4, 'sections', PbFieldType.PM, Section.$checkItem, Section.create)
    ..a<University>(5, 'university', PbFieldType.OM, University.getDefault, University.create)
    ..a<Subject>(6, 'subject', PbFieldType.OM, Subject.getDefault, Subject.create)
    ..a<Course>(7, 'course', PbFieldType.OM, Course.getDefault, Course.create)
    ..a<Section>(8, 'section', PbFieldType.OM, Section.getDefault, Section.create)
    ..hasRequiredFields = false
  ;

  Data() : super();
  Data.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Data.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Data clone() => new Data()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Data create() => new Data();
  static PbList<Data> createRepeated() => new PbList<Data>();
  static Data getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyData();
    return _defaultInstance;
  }
  static Data _defaultInstance;
  static void $checkItem(Data v) {
    if (v is! Data) checkItemFailed(v, 'Data');
  }

  List<University> get universities => $_getList(0);

  List<Subject> get subjects => $_getList(1);

  List<Course> get courses => $_getList(2);

  List<Section> get sections => $_getList(3);

  University get university => $_getN(4);
  set university(University v) { setField(5, v); }
  bool hasUniversity() => $_has(4);
  void clearUniversity() => clearField(5);

  Subject get subject => $_getN(5);
  set subject(Subject v) { setField(6, v); }
  bool hasSubject() => $_has(5);
  void clearSubject() => clearField(6);

  Course get course => $_getN(6);
  set course(Course v) { setField(7, v); }
  bool hasCourse() => $_has(6);
  void clearCourse() => clearField(7);

  Section get section => $_getN(7);
  set section(Section v) { setField(8, v); }
  bool hasSection() => $_has(7);
  void clearSection() => clearField(8);
}

class _ReadonlyData extends Data with ReadonlyMessageMixin {}

