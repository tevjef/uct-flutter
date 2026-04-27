//
//  Generated code. Do not modify.
//  source: model.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class University extends $pb.GeneratedMessage {
  factory University({
    $fixnum.Int64? id,
    $core.String? name,
    $core.String? abbr,
    $core.String? homePage,
    $core.String? registrationPage,
    $core.String? mainColor,
    $core.String? accentColor,
    $core.String? topicName,
    $core.String? topicId,
    ResolvedSemester? resolvedSemesters,
    $core.Iterable<Subject>? subjects,
    $core.Iterable<Semester>? availableSemesters,
    $core.Iterable<Registration>? registrations,
    $core.Iterable<Metadata>? metadata,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (abbr != null) {
      $result.abbr = abbr;
    }
    if (homePage != null) {
      $result.homePage = homePage;
    }
    if (registrationPage != null) {
      $result.registrationPage = registrationPage;
    }
    if (mainColor != null) {
      $result.mainColor = mainColor;
    }
    if (accentColor != null) {
      $result.accentColor = accentColor;
    }
    if (topicName != null) {
      $result.topicName = topicName;
    }
    if (topicId != null) {
      $result.topicId = topicId;
    }
    if (resolvedSemesters != null) {
      $result.resolvedSemesters = resolvedSemesters;
    }
    if (subjects != null) {
      $result.subjects.addAll(subjects);
    }
    if (availableSemesters != null) {
      $result.availableSemesters.addAll(availableSemesters);
    }
    if (registrations != null) {
      $result.registrations.addAll(registrations);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  University._() : super();
  factory University.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory University.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'University',
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'abbr')
    ..aOS(4, _omitFieldNames ? '' : 'homePage')
    ..aOS(5, _omitFieldNames ? '' : 'registrationPage')
    ..aOS(6, _omitFieldNames ? '' : 'mainColor')
    ..aOS(7, _omitFieldNames ? '' : 'accentColor')
    ..aOS(8, _omitFieldNames ? '' : 'topicName')
    ..aOS(9, _omitFieldNames ? '' : 'topicId')
    ..aOM<ResolvedSemester>(10, _omitFieldNames ? '' : 'resolvedSemesters',
        subBuilder: ResolvedSemester.create)
    ..pc<Subject>(11, _omitFieldNames ? '' : 'subjects', $pb.PbFieldType.PM,
        subBuilder: Subject.create)
    ..pc<Semester>(
        12, _omitFieldNames ? '' : 'availableSemesters', $pb.PbFieldType.PM,
        subBuilder: Semester.create)
    ..pc<Registration>(
        13, _omitFieldNames ? '' : 'registrations', $pb.PbFieldType.PM,
        subBuilder: Registration.create)
    ..pc<Metadata>(14, _omitFieldNames ? '' : 'metadata', $pb.PbFieldType.PM,
        subBuilder: Metadata.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  University clone() => University()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  University copyWith(void Function(University) updates) =>
      super.copyWith((message) => updates(message as University)) as University;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static University create() => University._();
  University createEmptyInstance() => create();
  static $pb.PbList<University> createRepeated() => $pb.PbList<University>();
  @$core.pragma('dart2js:noInline')
  static University getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<University>(create);
  static University? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get abbr => $_getSZ(2);
  @$pb.TagNumber(3)
  set abbr($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasAbbr() => $_has(2);
  @$pb.TagNumber(3)
  void clearAbbr() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get homePage => $_getSZ(3);
  @$pb.TagNumber(4)
  set homePage($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasHomePage() => $_has(3);
  @$pb.TagNumber(4)
  void clearHomePage() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get registrationPage => $_getSZ(4);
  @$pb.TagNumber(5)
  set registrationPage($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasRegistrationPage() => $_has(4);
  @$pb.TagNumber(5)
  void clearRegistrationPage() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get mainColor => $_getSZ(5);
  @$pb.TagNumber(6)
  set mainColor($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasMainColor() => $_has(5);
  @$pb.TagNumber(6)
  void clearMainColor() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get accentColor => $_getSZ(6);
  @$pb.TagNumber(7)
  set accentColor($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasAccentColor() => $_has(6);
  @$pb.TagNumber(7)
  void clearAccentColor() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get topicName => $_getSZ(7);
  @$pb.TagNumber(8)
  set topicName($core.String v) {
    $_setString(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasTopicName() => $_has(7);
  @$pb.TagNumber(8)
  void clearTopicName() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get topicId => $_getSZ(8);
  @$pb.TagNumber(9)
  set topicId($core.String v) {
    $_setString(8, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasTopicId() => $_has(8);
  @$pb.TagNumber(9)
  void clearTopicId() => clearField(9);

  @$pb.TagNumber(10)
  ResolvedSemester get resolvedSemesters => $_getN(9);
  @$pb.TagNumber(10)
  set resolvedSemesters(ResolvedSemester v) {
    setField(10, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasResolvedSemesters() => $_has(9);
  @$pb.TagNumber(10)
  void clearResolvedSemesters() => clearField(10);
  @$pb.TagNumber(10)
  ResolvedSemester ensureResolvedSemesters() => $_ensure(9);

  @$pb.TagNumber(11)
  $core.List<Subject> get subjects => $_getList(10);

  @$pb.TagNumber(12)
  $core.List<Semester> get availableSemesters => $_getList(11);

  @$pb.TagNumber(13)
  $core.List<Registration> get registrations => $_getList(12);

  @$pb.TagNumber(14)
  $core.List<Metadata> get metadata => $_getList(13);
}

class Subject extends $pb.GeneratedMessage {
  factory Subject({
    $fixnum.Int64? id,
    $fixnum.Int64? universityId,
    $core.String? name,
    $core.String? number,
    $core.String? season,
    $core.String? year,
    $core.String? topicName,
    $core.String? topicId,
    $core.Iterable<Course>? courses,
    $core.Iterable<Metadata>? metadata,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (universityId != null) {
      $result.universityId = universityId;
    }
    if (name != null) {
      $result.name = name;
    }
    if (number != null) {
      $result.number = number;
    }
    if (season != null) {
      $result.season = season;
    }
    if (year != null) {
      $result.year = year;
    }
    if (topicName != null) {
      $result.topicName = topicName;
    }
    if (topicId != null) {
      $result.topicId = topicId;
    }
    if (courses != null) {
      $result.courses.addAll(courses);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  Subject._() : super();
  factory Subject.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Subject.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Subject',
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aInt64(2, _omitFieldNames ? '' : 'universityId')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aOS(4, _omitFieldNames ? '' : 'number')
    ..aOS(5, _omitFieldNames ? '' : 'season')
    ..aOS(6, _omitFieldNames ? '' : 'year')
    ..aOS(7, _omitFieldNames ? '' : 'topicName')
    ..aOS(8, _omitFieldNames ? '' : 'topicId')
    ..pc<Course>(9, _omitFieldNames ? '' : 'courses', $pb.PbFieldType.PM,
        subBuilder: Course.create)
    ..pc<Metadata>(10, _omitFieldNames ? '' : 'metadata', $pb.PbFieldType.PM,
        subBuilder: Metadata.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Subject clone() => Subject()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Subject copyWith(void Function(Subject) updates) =>
      super.copyWith((message) => updates(message as Subject)) as Subject;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Subject create() => Subject._();
  Subject createEmptyInstance() => create();
  static $pb.PbList<Subject> createRepeated() => $pb.PbList<Subject>();
  @$core.pragma('dart2js:noInline')
  static Subject getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Subject>(create);
  static Subject? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get universityId => $_getI64(1);
  @$pb.TagNumber(2)
  set universityId($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasUniversityId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUniversityId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get number => $_getSZ(3);
  @$pb.TagNumber(4)
  set number($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearNumber() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get season => $_getSZ(4);
  @$pb.TagNumber(5)
  set season($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasSeason() => $_has(4);
  @$pb.TagNumber(5)
  void clearSeason() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get year => $_getSZ(5);
  @$pb.TagNumber(6)
  set year($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasYear() => $_has(5);
  @$pb.TagNumber(6)
  void clearYear() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get topicName => $_getSZ(6);
  @$pb.TagNumber(7)
  set topicName($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasTopicName() => $_has(6);
  @$pb.TagNumber(7)
  void clearTopicName() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get topicId => $_getSZ(7);
  @$pb.TagNumber(8)
  set topicId($core.String v) {
    $_setString(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasTopicId() => $_has(7);
  @$pb.TagNumber(8)
  void clearTopicId() => clearField(8);

  @$pb.TagNumber(9)
  $core.List<Course> get courses => $_getList(8);

  @$pb.TagNumber(10)
  $core.List<Metadata> get metadata => $_getList(9);
}

class Course extends $pb.GeneratedMessage {
  factory Course({
    $fixnum.Int64? id,
    $fixnum.Int64? subjectId,
    $core.String? name,
    $core.String? number,
    $core.String? synopsis,
    $core.String? topicName,
    $core.String? topicId,
    $core.Iterable<Section>? sections,
    $core.Iterable<Metadata>? metadata,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (subjectId != null) {
      $result.subjectId = subjectId;
    }
    if (name != null) {
      $result.name = name;
    }
    if (number != null) {
      $result.number = number;
    }
    if (synopsis != null) {
      $result.synopsis = synopsis;
    }
    if (topicName != null) {
      $result.topicName = topicName;
    }
    if (topicId != null) {
      $result.topicId = topicId;
    }
    if (sections != null) {
      $result.sections.addAll(sections);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  Course._() : super();
  factory Course.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Course.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Course',
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aInt64(2, _omitFieldNames ? '' : 'subjectId')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aOS(4, _omitFieldNames ? '' : 'number')
    ..aOS(5, _omitFieldNames ? '' : 'synopsis')
    ..aOS(6, _omitFieldNames ? '' : 'topicName')
    ..aOS(7, _omitFieldNames ? '' : 'topicId')
    ..pc<Section>(8, _omitFieldNames ? '' : 'sections', $pb.PbFieldType.PM,
        subBuilder: Section.create)
    ..pc<Metadata>(9, _omitFieldNames ? '' : 'metadata', $pb.PbFieldType.PM,
        subBuilder: Metadata.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Course clone() => Course()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Course copyWith(void Function(Course) updates) =>
      super.copyWith((message) => updates(message as Course)) as Course;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Course create() => Course._();
  Course createEmptyInstance() => create();
  static $pb.PbList<Course> createRepeated() => $pb.PbList<Course>();
  @$core.pragma('dart2js:noInline')
  static Course getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Course>(create);
  static Course? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get subjectId => $_getI64(1);
  @$pb.TagNumber(2)
  set subjectId($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSubjectId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSubjectId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get number => $_getSZ(3);
  @$pb.TagNumber(4)
  set number($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearNumber() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get synopsis => $_getSZ(4);
  @$pb.TagNumber(5)
  set synopsis($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasSynopsis() => $_has(4);
  @$pb.TagNumber(5)
  void clearSynopsis() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get topicName => $_getSZ(5);
  @$pb.TagNumber(6)
  set topicName($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasTopicName() => $_has(5);
  @$pb.TagNumber(6)
  void clearTopicName() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get topicId => $_getSZ(6);
  @$pb.TagNumber(7)
  set topicId($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasTopicId() => $_has(6);
  @$pb.TagNumber(7)
  void clearTopicId() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<Section> get sections => $_getList(7);

  @$pb.TagNumber(9)
  $core.List<Metadata> get metadata => $_getList(8);
}

class Section extends $pb.GeneratedMessage {
  factory Section({
    $fixnum.Int64? id,
    $fixnum.Int64? courseId,
    $core.String? number,
    $core.String? callNumber,
    $fixnum.Int64? max,
    $fixnum.Int64? now,
    $core.String? status,
    $core.String? credits,
    $core.String? topicName,
    $core.String? topicId,
    $core.Iterable<Meeting>? meetings,
    $core.Iterable<Instructor>? instructors,
    $core.Iterable<Book>? books,
    $core.Iterable<Metadata>? metadata,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (courseId != null) {
      $result.courseId = courseId;
    }
    if (number != null) {
      $result.number = number;
    }
    if (callNumber != null) {
      $result.callNumber = callNumber;
    }
    if (max != null) {
      $result.max = max;
    }
    if (now != null) {
      $result.now = now;
    }
    if (status != null) {
      $result.status = status;
    }
    if (credits != null) {
      $result.credits = credits;
    }
    if (topicName != null) {
      $result.topicName = topicName;
    }
    if (topicId != null) {
      $result.topicId = topicId;
    }
    if (meetings != null) {
      $result.meetings.addAll(meetings);
    }
    if (instructors != null) {
      $result.instructors.addAll(instructors);
    }
    if (books != null) {
      $result.books.addAll(books);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  Section._() : super();
  factory Section.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Section.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Section',
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aInt64(2, _omitFieldNames ? '' : 'courseId')
    ..aOS(3, _omitFieldNames ? '' : 'number')
    ..aOS(4, _omitFieldNames ? '' : 'callNumber')
    ..aInt64(5, _omitFieldNames ? '' : 'max')
    ..aInt64(6, _omitFieldNames ? '' : 'now')
    ..aOS(7, _omitFieldNames ? '' : 'status')
    ..aOS(8, _omitFieldNames ? '' : 'credits')
    ..aOS(9, _omitFieldNames ? '' : 'topicName')
    ..aOS(10, _omitFieldNames ? '' : 'topicId')
    ..pc<Meeting>(11, _omitFieldNames ? '' : 'meetings', $pb.PbFieldType.PM,
        subBuilder: Meeting.create)
    ..pc<Instructor>(
        12, _omitFieldNames ? '' : 'instructors', $pb.PbFieldType.PM,
        subBuilder: Instructor.create)
    ..pc<Book>(13, _omitFieldNames ? '' : 'books', $pb.PbFieldType.PM,
        subBuilder: Book.create)
    ..pc<Metadata>(14, _omitFieldNames ? '' : 'metadata', $pb.PbFieldType.PM,
        subBuilder: Metadata.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Section clone() => Section()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Section copyWith(void Function(Section) updates) =>
      super.copyWith((message) => updates(message as Section)) as Section;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Section create() => Section._();
  Section createEmptyInstance() => create();
  static $pb.PbList<Section> createRepeated() => $pb.PbList<Section>();
  @$core.pragma('dart2js:noInline')
  static Section getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Section>(create);
  static Section? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get courseId => $_getI64(1);
  @$pb.TagNumber(2)
  set courseId($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasCourseId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCourseId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get number => $_getSZ(2);
  @$pb.TagNumber(3)
  set number($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearNumber() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get callNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set callNumber($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasCallNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearCallNumber() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get max => $_getI64(4);
  @$pb.TagNumber(5)
  set max($fixnum.Int64 v) {
    $_setInt64(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasMax() => $_has(4);
  @$pb.TagNumber(5)
  void clearMax() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get now => $_getI64(5);
  @$pb.TagNumber(6)
  set now($fixnum.Int64 v) {
    $_setInt64(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasNow() => $_has(5);
  @$pb.TagNumber(6)
  void clearNow() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get status => $_getSZ(6);
  @$pb.TagNumber(7)
  set status($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get credits => $_getSZ(7);
  @$pb.TagNumber(8)
  set credits($core.String v) {
    $_setString(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasCredits() => $_has(7);
  @$pb.TagNumber(8)
  void clearCredits() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get topicName => $_getSZ(8);
  @$pb.TagNumber(9)
  set topicName($core.String v) {
    $_setString(8, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasTopicName() => $_has(8);
  @$pb.TagNumber(9)
  void clearTopicName() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get topicId => $_getSZ(9);
  @$pb.TagNumber(10)
  set topicId($core.String v) {
    $_setString(9, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasTopicId() => $_has(9);
  @$pb.TagNumber(10)
  void clearTopicId() => clearField(10);

  @$pb.TagNumber(11)
  $core.List<Meeting> get meetings => $_getList(10);

  @$pb.TagNumber(12)
  $core.List<Instructor> get instructors => $_getList(11);

  @$pb.TagNumber(13)
  $core.List<Book> get books => $_getList(12);

  @$pb.TagNumber(14)
  $core.List<Metadata> get metadata => $_getList(13);
}

class Meeting extends $pb.GeneratedMessage {
  factory Meeting({
    $fixnum.Int64? id,
    $fixnum.Int64? sectionId,
    $core.String? room,
    $core.String? day,
    $core.String? startTime,
    $core.String? endTime,
    $core.String? classType,
    $core.int? index,
    $core.Iterable<Metadata>? metadata,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (sectionId != null) {
      $result.sectionId = sectionId;
    }
    if (room != null) {
      $result.room = room;
    }
    if (day != null) {
      $result.day = day;
    }
    if (startTime != null) {
      $result.startTime = startTime;
    }
    if (endTime != null) {
      $result.endTime = endTime;
    }
    if (classType != null) {
      $result.classType = classType;
    }
    if (index != null) {
      $result.index = index;
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  Meeting._() : super();
  factory Meeting.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Meeting.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Meeting',
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aInt64(2, _omitFieldNames ? '' : 'sectionId')
    ..aOS(3, _omitFieldNames ? '' : 'room')
    ..aOS(4, _omitFieldNames ? '' : 'day')
    ..aOS(5, _omitFieldNames ? '' : 'startTime')
    ..aOS(6, _omitFieldNames ? '' : 'endTime')
    ..aOS(7, _omitFieldNames ? '' : 'classType')
    ..a<$core.int>(8, _omitFieldNames ? '' : 'index', $pb.PbFieldType.O3)
    ..pc<Metadata>(9, _omitFieldNames ? '' : 'metadata', $pb.PbFieldType.PM,
        subBuilder: Metadata.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Meeting clone() => Meeting()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Meeting copyWith(void Function(Meeting) updates) =>
      super.copyWith((message) => updates(message as Meeting)) as Meeting;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Meeting create() => Meeting._();
  Meeting createEmptyInstance() => create();
  static $pb.PbList<Meeting> createRepeated() => $pb.PbList<Meeting>();
  @$core.pragma('dart2js:noInline')
  static Meeting getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Meeting>(create);
  static Meeting? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get sectionId => $_getI64(1);
  @$pb.TagNumber(2)
  set sectionId($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSectionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSectionId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get room => $_getSZ(2);
  @$pb.TagNumber(3)
  set room($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasRoom() => $_has(2);
  @$pb.TagNumber(3)
  void clearRoom() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get day => $_getSZ(3);
  @$pb.TagNumber(4)
  set day($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasDay() => $_has(3);
  @$pb.TagNumber(4)
  void clearDay() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get startTime => $_getSZ(4);
  @$pb.TagNumber(5)
  set startTime($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasStartTime() => $_has(4);
  @$pb.TagNumber(5)
  void clearStartTime() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get endTime => $_getSZ(5);
  @$pb.TagNumber(6)
  set endTime($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasEndTime() => $_has(5);
  @$pb.TagNumber(6)
  void clearEndTime() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get classType => $_getSZ(6);
  @$pb.TagNumber(7)
  set classType($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasClassType() => $_has(6);
  @$pb.TagNumber(7)
  void clearClassType() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get index => $_getIZ(7);
  @$pb.TagNumber(8)
  set index($core.int v) {
    $_setSignedInt32(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasIndex() => $_has(7);
  @$pb.TagNumber(8)
  void clearIndex() => clearField(8);

  @$pb.TagNumber(9)
  $core.List<Metadata> get metadata => $_getList(8);
}

class Instructor extends $pb.GeneratedMessage {
  factory Instructor({
    $fixnum.Int64? id,
    $fixnum.Int64? sectionId,
    $core.String? name,
    $core.int? index,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (sectionId != null) {
      $result.sectionId = sectionId;
    }
    if (name != null) {
      $result.name = name;
    }
    if (index != null) {
      $result.index = index;
    }
    return $result;
  }
  Instructor._() : super();
  factory Instructor.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Instructor.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Instructor',
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aInt64(2, _omitFieldNames ? '' : 'sectionId')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'index', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Instructor clone() => Instructor()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Instructor copyWith(void Function(Instructor) updates) =>
      super.copyWith((message) => updates(message as Instructor)) as Instructor;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Instructor create() => Instructor._();
  Instructor createEmptyInstance() => create();
  static $pb.PbList<Instructor> createRepeated() => $pb.PbList<Instructor>();
  @$core.pragma('dart2js:noInline')
  static Instructor getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Instructor>(create);
  static Instructor? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get sectionId => $_getI64(1);
  @$pb.TagNumber(2)
  set sectionId($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSectionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSectionId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get index => $_getIZ(3);
  @$pb.TagNumber(4)
  set index($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasIndex() => $_has(3);
  @$pb.TagNumber(4)
  void clearIndex() => clearField(4);
}

class Book extends $pb.GeneratedMessage {
  factory Book({
    $fixnum.Int64? id,
    $fixnum.Int64? sectionId,
    $core.String? title,
    $core.String? url,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (sectionId != null) {
      $result.sectionId = sectionId;
    }
    if (title != null) {
      $result.title = title;
    }
    if (url != null) {
      $result.url = url;
    }
    return $result;
  }
  Book._() : super();
  factory Book.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Book.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Book',
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aInt64(2, _omitFieldNames ? '' : 'sectionId')
    ..aOS(3, _omitFieldNames ? '' : 'title')
    ..aOS(4, _omitFieldNames ? '' : 'url')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Book clone() => Book()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Book copyWith(void Function(Book) updates) =>
      super.copyWith((message) => updates(message as Book)) as Book;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Book create() => Book._();
  Book createEmptyInstance() => create();
  static $pb.PbList<Book> createRepeated() => $pb.PbList<Book>();
  @$core.pragma('dart2js:noInline')
  static Book getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Book>(create);
  static Book? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get sectionId => $_getI64(1);
  @$pb.TagNumber(2)
  set sectionId($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSectionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSectionId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get url => $_getSZ(3);
  @$pb.TagNumber(4)
  set url($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearUrl() => clearField(4);
}

class Metadata extends $pb.GeneratedMessage {
  factory Metadata({
    $fixnum.Int64? id,
    $fixnum.Int64? universityId,
    $fixnum.Int64? subjectId,
    $fixnum.Int64? courseId,
    $fixnum.Int64? sectionId,
    $fixnum.Int64? meetingId,
    $core.String? title,
    $core.String? content,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (universityId != null) {
      $result.universityId = universityId;
    }
    if (subjectId != null) {
      $result.subjectId = subjectId;
    }
    if (courseId != null) {
      $result.courseId = courseId;
    }
    if (sectionId != null) {
      $result.sectionId = sectionId;
    }
    if (meetingId != null) {
      $result.meetingId = meetingId;
    }
    if (title != null) {
      $result.title = title;
    }
    if (content != null) {
      $result.content = content;
    }
    return $result;
  }
  Metadata._() : super();
  factory Metadata.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Metadata.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Metadata',
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aInt64(2, _omitFieldNames ? '' : 'universityId')
    ..aInt64(3, _omitFieldNames ? '' : 'subjectId')
    ..aInt64(4, _omitFieldNames ? '' : 'courseId')
    ..aInt64(5, _omitFieldNames ? '' : 'sectionId')
    ..aInt64(6, _omitFieldNames ? '' : 'meetingId')
    ..aOS(7, _omitFieldNames ? '' : 'title')
    ..aOS(8, _omitFieldNames ? '' : 'content')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Metadata clone() => Metadata()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Metadata copyWith(void Function(Metadata) updates) =>
      super.copyWith((message) => updates(message as Metadata)) as Metadata;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Metadata create() => Metadata._();
  Metadata createEmptyInstance() => create();
  static $pb.PbList<Metadata> createRepeated() => $pb.PbList<Metadata>();
  @$core.pragma('dart2js:noInline')
  static Metadata getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Metadata>(create);
  static Metadata? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get universityId => $_getI64(1);
  @$pb.TagNumber(2)
  set universityId($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasUniversityId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUniversityId() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get subjectId => $_getI64(2);
  @$pb.TagNumber(3)
  set subjectId($fixnum.Int64 v) {
    $_setInt64(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasSubjectId() => $_has(2);
  @$pb.TagNumber(3)
  void clearSubjectId() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get courseId => $_getI64(3);
  @$pb.TagNumber(4)
  set courseId($fixnum.Int64 v) {
    $_setInt64(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasCourseId() => $_has(3);
  @$pb.TagNumber(4)
  void clearCourseId() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get sectionId => $_getI64(4);
  @$pb.TagNumber(5)
  set sectionId($fixnum.Int64 v) {
    $_setInt64(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasSectionId() => $_has(4);
  @$pb.TagNumber(5)
  void clearSectionId() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get meetingId => $_getI64(5);
  @$pb.TagNumber(6)
  set meetingId($fixnum.Int64 v) {
    $_setInt64(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasMeetingId() => $_has(5);
  @$pb.TagNumber(6)
  void clearMeetingId() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get title => $_getSZ(6);
  @$pb.TagNumber(7)
  set title($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasTitle() => $_has(6);
  @$pb.TagNumber(7)
  void clearTitle() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get content => $_getSZ(7);
  @$pb.TagNumber(8)
  set content($core.String v) {
    $_setString(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasContent() => $_has(7);
  @$pb.TagNumber(8)
  void clearContent() => clearField(8);
}

class Registration extends $pb.GeneratedMessage {
  factory Registration({
    $fixnum.Int64? id,
    $fixnum.Int64? universityId,
    $core.String? period,
    $fixnum.Int64? periodDate,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (universityId != null) {
      $result.universityId = universityId;
    }
    if (period != null) {
      $result.period = period;
    }
    if (periodDate != null) {
      $result.periodDate = periodDate;
    }
    return $result;
  }
  Registration._() : super();
  factory Registration.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Registration.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Registration',
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aInt64(2, _omitFieldNames ? '' : 'universityId')
    ..aOS(3, _omitFieldNames ? '' : 'period')
    ..aInt64(4, _omitFieldNames ? '' : 'periodDate')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Registration clone() => Registration()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Registration copyWith(void Function(Registration) updates) =>
      super.copyWith((message) => updates(message as Registration))
          as Registration;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Registration create() => Registration._();
  Registration createEmptyInstance() => create();
  static $pb.PbList<Registration> createRepeated() =>
      $pb.PbList<Registration>();
  @$core.pragma('dart2js:noInline')
  static Registration getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Registration>(create);
  static Registration? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get universityId => $_getI64(1);
  @$pb.TagNumber(2)
  set universityId($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasUniversityId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUniversityId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get period => $_getSZ(2);
  @$pb.TagNumber(3)
  set period($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasPeriod() => $_has(2);
  @$pb.TagNumber(3)
  void clearPeriod() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get periodDate => $_getI64(3);
  @$pb.TagNumber(4)
  set periodDate($fixnum.Int64 v) {
    $_setInt64(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasPeriodDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearPeriodDate() => clearField(4);
}

class ResolvedSemester extends $pb.GeneratedMessage {
  factory ResolvedSemester({
    Semester? current,
    Semester? last,
    Semester? next,
  }) {
    final $result = create();
    if (current != null) {
      $result.current = current;
    }
    if (last != null) {
      $result.last = last;
    }
    if (next != null) {
      $result.next = next;
    }
    return $result;
  }
  ResolvedSemester._() : super();
  factory ResolvedSemester.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ResolvedSemester.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResolvedSemester',
      createEmptyInstance: create)
    ..aOM<Semester>(1, _omitFieldNames ? '' : 'current',
        subBuilder: Semester.create)
    ..aOM<Semester>(2, _omitFieldNames ? '' : 'last',
        subBuilder: Semester.create)
    ..aOM<Semester>(3, _omitFieldNames ? '' : 'next',
        subBuilder: Semester.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ResolvedSemester clone() => ResolvedSemester()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ResolvedSemester copyWith(void Function(ResolvedSemester) updates) =>
      super.copyWith((message) => updates(message as ResolvedSemester))
          as ResolvedSemester;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResolvedSemester create() => ResolvedSemester._();
  ResolvedSemester createEmptyInstance() => create();
  static $pb.PbList<ResolvedSemester> createRepeated() =>
      $pb.PbList<ResolvedSemester>();
  @$core.pragma('dart2js:noInline')
  static ResolvedSemester getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResolvedSemester>(create);
  static ResolvedSemester? _defaultInstance;

  @$pb.TagNumber(1)
  Semester get current => $_getN(0);
  @$pb.TagNumber(1)
  set current(Semester v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCurrent() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrent() => clearField(1);
  @$pb.TagNumber(1)
  Semester ensureCurrent() => $_ensure(0);

  @$pb.TagNumber(2)
  Semester get last => $_getN(1);
  @$pb.TagNumber(2)
  set last(Semester v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasLast() => $_has(1);
  @$pb.TagNumber(2)
  void clearLast() => clearField(2);
  @$pb.TagNumber(2)
  Semester ensureLast() => $_ensure(1);

  @$pb.TagNumber(3)
  Semester get next => $_getN(2);
  @$pb.TagNumber(3)
  set next(Semester v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasNext() => $_has(2);
  @$pb.TagNumber(3)
  void clearNext() => clearField(3);
  @$pb.TagNumber(3)
  Semester ensureNext() => $_ensure(2);
}

class Semester extends $pb.GeneratedMessage {
  factory Semester({
    $core.int? year,
    $core.String? season,
  }) {
    final $result = create();
    if (year != null) {
      $result.year = year;
    }
    if (season != null) {
      $result.season = season;
    }
    return $result;
  }
  Semester._() : super();
  factory Semester.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Semester.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Semester',
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'year', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'season')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Semester clone() => Semester()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Semester copyWith(void Function(Semester) updates) =>
      super.copyWith((message) => updates(message as Semester)) as Semester;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Semester create() => Semester._();
  Semester createEmptyInstance() => create();
  static $pb.PbList<Semester> createRepeated() => $pb.PbList<Semester>();
  @$core.pragma('dart2js:noInline')
  static Semester getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Semester>(create);
  static Semester? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get year => $_getIZ(0);
  @$pb.TagNumber(1)
  set year($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasYear() => $_has(0);
  @$pb.TagNumber(1)
  void clearYear() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get season => $_getSZ(1);
  @$pb.TagNumber(2)
  set season($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSeason() => $_has(1);
  @$pb.TagNumber(2)
  void clearSeason() => clearField(2);
}

class UCTNotification extends $pb.GeneratedMessage {
  factory UCTNotification({
    $fixnum.Int64? notificationId,
    $core.String? topicName,
    $core.String? status,
    University? university,
  }) {
    final $result = create();
    if (notificationId != null) {
      $result.notificationId = notificationId;
    }
    if (topicName != null) {
      $result.topicName = topicName;
    }
    if (status != null) {
      $result.status = status;
    }
    if (university != null) {
      $result.university = university;
    }
    return $result;
  }
  UCTNotification._() : super();
  factory UCTNotification.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UCTNotification.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UCTNotification',
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'notificationId')
    ..aOS(2, _omitFieldNames ? '' : 'topicName')
    ..aOS(3, _omitFieldNames ? '' : 'status')
    ..aOM<University>(4, _omitFieldNames ? '' : 'university',
        subBuilder: University.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UCTNotification clone() => UCTNotification()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UCTNotification copyWith(void Function(UCTNotification) updates) =>
      super.copyWith((message) => updates(message as UCTNotification))
          as UCTNotification;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UCTNotification create() => UCTNotification._();
  UCTNotification createEmptyInstance() => create();
  static $pb.PbList<UCTNotification> createRepeated() =>
      $pb.PbList<UCTNotification>();
  @$core.pragma('dart2js:noInline')
  static UCTNotification getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UCTNotification>(create);
  static UCTNotification? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get notificationId => $_getI64(0);
  @$pb.TagNumber(1)
  set notificationId($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasNotificationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearNotificationId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get topicName => $_getSZ(1);
  @$pb.TagNumber(2)
  set topicName($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasTopicName() => $_has(1);
  @$pb.TagNumber(2)
  void clearTopicName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);

  @$pb.TagNumber(4)
  University get university => $_getN(3);
  @$pb.TagNumber(4)
  set university(University v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasUniversity() => $_has(3);
  @$pb.TagNumber(4)
  void clearUniversity() => clearField(4);
  @$pb.TagNumber(4)
  University ensureUniversity() => $_ensure(3);
}

class Response extends $pb.GeneratedMessage {
  factory Response({
    Meta? meta,
    Data? data,
  }) {
    final $result = create();
    if (meta != null) {
      $result.meta = meta;
    }
    if (data != null) {
      $result.data = data;
    }
    return $result;
  }
  Response._() : super();
  factory Response.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Response.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Response',
      createEmptyInstance: create)
    ..aOM<Meta>(1, _omitFieldNames ? '' : 'meta', subBuilder: Meta.create)
    ..aOM<Data>(2, _omitFieldNames ? '' : 'data', subBuilder: Data.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Response clone() => Response()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Response copyWith(void Function(Response) updates) =>
      super.copyWith((message) => updates(message as Response)) as Response;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Response create() => Response._();
  Response createEmptyInstance() => create();
  static $pb.PbList<Response> createRepeated() => $pb.PbList<Response>();
  @$core.pragma('dart2js:noInline')
  static Response getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Response>(create);
  static Response? _defaultInstance;

  @$pb.TagNumber(1)
  Meta get meta => $_getN(0);
  @$pb.TagNumber(1)
  set meta(Meta v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasMeta() => $_has(0);
  @$pb.TagNumber(1)
  void clearMeta() => clearField(1);
  @$pb.TagNumber(1)
  Meta ensureMeta() => $_ensure(0);

  @$pb.TagNumber(2)
  Data get data => $_getN(1);
  @$pb.TagNumber(2)
  set data(Data v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => clearField(2);
  @$pb.TagNumber(2)
  Data ensureData() => $_ensure(1);
}

class Meta extends $pb.GeneratedMessage {
  factory Meta({
    $core.int? code,
    $core.String? message,
  }) {
    final $result = create();
    if (code != null) {
      $result.code = code;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  Meta._() : super();
  factory Meta.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Meta.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Meta',
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'code', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Meta clone() => Meta()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Meta copyWith(void Function(Meta) updates) =>
      super.copyWith((message) => updates(message as Meta)) as Meta;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Meta create() => Meta._();
  Meta createEmptyInstance() => create();
  static $pb.PbList<Meta> createRepeated() => $pb.PbList<Meta>();
  @$core.pragma('dart2js:noInline')
  static Meta getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Meta>(create);
  static Meta? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get code => $_getIZ(0);
  @$pb.TagNumber(1)
  set code($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class Data extends $pb.GeneratedMessage {
  factory Data({
    $core.Iterable<University>? universities,
    $core.Iterable<Subject>? subjects,
    $core.Iterable<Course>? courses,
    $core.Iterable<Section>? sections,
    University? university,
    Subject? subject,
    Course? course,
    Section? section,
    $core.Iterable<SubscriptionView>? subscriptionView,
  }) {
    final $result = create();
    if (universities != null) {
      $result.universities.addAll(universities);
    }
    if (subjects != null) {
      $result.subjects.addAll(subjects);
    }
    if (courses != null) {
      $result.courses.addAll(courses);
    }
    if (sections != null) {
      $result.sections.addAll(sections);
    }
    if (university != null) {
      $result.university = university;
    }
    if (subject != null) {
      $result.subject = subject;
    }
    if (course != null) {
      $result.course = course;
    }
    if (section != null) {
      $result.section = section;
    }
    if (subscriptionView != null) {
      $result.subscriptionView.addAll(subscriptionView);
    }
    return $result;
  }
  Data._() : super();
  factory Data.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Data.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Data',
      createEmptyInstance: create)
    ..pc<University>(
        1, _omitFieldNames ? '' : 'universities', $pb.PbFieldType.PM,
        subBuilder: University.create)
    ..pc<Subject>(2, _omitFieldNames ? '' : 'subjects', $pb.PbFieldType.PM,
        subBuilder: Subject.create)
    ..pc<Course>(3, _omitFieldNames ? '' : 'courses', $pb.PbFieldType.PM,
        subBuilder: Course.create)
    ..pc<Section>(4, _omitFieldNames ? '' : 'sections', $pb.PbFieldType.PM,
        subBuilder: Section.create)
    ..aOM<University>(5, _omitFieldNames ? '' : 'university',
        subBuilder: University.create)
    ..aOM<Subject>(6, _omitFieldNames ? '' : 'subject',
        subBuilder: Subject.create)
    ..aOM<Course>(7, _omitFieldNames ? '' : 'course', subBuilder: Course.create)
    ..aOM<Section>(8, _omitFieldNames ? '' : 'section',
        subBuilder: Section.create)
    ..pc<SubscriptionView>(
        9, _omitFieldNames ? '' : 'subscriptionView', $pb.PbFieldType.PM,
        subBuilder: SubscriptionView.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Data clone() => Data()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Data copyWith(void Function(Data) updates) =>
      super.copyWith((message) => updates(message as Data)) as Data;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Data create() => Data._();
  Data createEmptyInstance() => create();
  static $pb.PbList<Data> createRepeated() => $pb.PbList<Data>();
  @$core.pragma('dart2js:noInline')
  static Data getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Data>(create);
  static Data? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<University> get universities => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<Subject> get subjects => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<Course> get courses => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<Section> get sections => $_getList(3);

  @$pb.TagNumber(5)
  University get university => $_getN(4);
  @$pb.TagNumber(5)
  set university(University v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasUniversity() => $_has(4);
  @$pb.TagNumber(5)
  void clearUniversity() => clearField(5);
  @$pb.TagNumber(5)
  University ensureUniversity() => $_ensure(4);

  @$pb.TagNumber(6)
  Subject get subject => $_getN(5);
  @$pb.TagNumber(6)
  set subject(Subject v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasSubject() => $_has(5);
  @$pb.TagNumber(6)
  void clearSubject() => clearField(6);
  @$pb.TagNumber(6)
  Subject ensureSubject() => $_ensure(5);

  @$pb.TagNumber(7)
  Course get course => $_getN(6);
  @$pb.TagNumber(7)
  set course(Course v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasCourse() => $_has(6);
  @$pb.TagNumber(7)
  void clearCourse() => clearField(7);
  @$pb.TagNumber(7)
  Course ensureCourse() => $_ensure(6);

  @$pb.TagNumber(8)
  Section get section => $_getN(7);
  @$pb.TagNumber(8)
  set section(Section v) {
    setField(8, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasSection() => $_has(7);
  @$pb.TagNumber(8)
  void clearSection() => clearField(8);
  @$pb.TagNumber(8)
  Section ensureSection() => $_ensure(7);

  @$pb.TagNumber(9)
  $core.List<SubscriptionView> get subscriptionView => $_getList(8);
}

class Subscription extends $pb.GeneratedMessage {
  factory Subscription({
    $core.String? id,
    $core.String? os,
    $core.String? isSubscribed,
    $core.String? topicName,
    $core.String? fcmToken,
    $core.String? createdAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (os != null) {
      $result.os = os;
    }
    if (isSubscribed != null) {
      $result.isSubscribed = isSubscribed;
    }
    if (topicName != null) {
      $result.topicName = topicName;
    }
    if (fcmToken != null) {
      $result.fcmToken = fcmToken;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    return $result;
  }
  Subscription._() : super();
  factory Subscription.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Subscription.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Subscription',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'os')
    ..aOS(3, _omitFieldNames ? '' : 'isSubscribed')
    ..aOS(4, _omitFieldNames ? '' : 'topicName')
    ..aOS(5, _omitFieldNames ? '' : 'fcmToken')
    ..aOS(6, _omitFieldNames ? '' : 'createdAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Subscription clone() => Subscription()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Subscription copyWith(void Function(Subscription) updates) =>
      super.copyWith((message) => updates(message as Subscription))
          as Subscription;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Subscription create() => Subscription._();
  Subscription createEmptyInstance() => create();
  static $pb.PbList<Subscription> createRepeated() =>
      $pb.PbList<Subscription>();
  @$core.pragma('dart2js:noInline')
  static Subscription getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Subscription>(create);
  static Subscription? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get os => $_getSZ(1);
  @$pb.TagNumber(2)
  set os($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasOs() => $_has(1);
  @$pb.TagNumber(2)
  void clearOs() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get isSubscribed => $_getSZ(2);
  @$pb.TagNumber(3)
  set isSubscribed($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasIsSubscribed() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsSubscribed() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get topicName => $_getSZ(3);
  @$pb.TagNumber(4)
  set topicName($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasTopicName() => $_has(3);
  @$pb.TagNumber(4)
  void clearTopicName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get fcmToken => $_getSZ(4);
  @$pb.TagNumber(5)
  set fcmToken($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasFcmToken() => $_has(4);
  @$pb.TagNumber(5)
  void clearFcmToken() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get createdAt => $_getSZ(5);
  @$pb.TagNumber(6)
  set createdAt($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasCreatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreatedAt() => clearField(6);
}

class SubscriptionView extends $pb.GeneratedMessage {
  factory SubscriptionView({
    $core.String? topicName,
    $fixnum.Int64? subscribers,
    $core.bool? isHot,
  }) {
    final $result = create();
    if (topicName != null) {
      $result.topicName = topicName;
    }
    if (subscribers != null) {
      $result.subscribers = subscribers;
    }
    if (isHot != null) {
      $result.isHot = isHot;
    }
    return $result;
  }
  SubscriptionView._() : super();
  factory SubscriptionView.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SubscriptionView.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubscriptionView',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'topicName')
    ..aInt64(2, _omitFieldNames ? '' : 'subscribers')
    ..aOB(3, _omitFieldNames ? '' : 'isHot')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SubscriptionView clone() => SubscriptionView()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SubscriptionView copyWith(void Function(SubscriptionView) updates) =>
      super.copyWith((message) => updates(message as SubscriptionView))
          as SubscriptionView;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubscriptionView create() => SubscriptionView._();
  SubscriptionView createEmptyInstance() => create();
  static $pb.PbList<SubscriptionView> createRepeated() =>
      $pb.PbList<SubscriptionView>();
  @$core.pragma('dart2js:noInline')
  static SubscriptionView getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubscriptionView>(create);
  static SubscriptionView? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get topicName => $_getSZ(0);
  @$pb.TagNumber(1)
  set topicName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasTopicName() => $_has(0);
  @$pb.TagNumber(1)
  void clearTopicName() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get subscribers => $_getI64(1);
  @$pb.TagNumber(2)
  set subscribers($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSubscribers() => $_has(1);
  @$pb.TagNumber(2)
  void clearSubscribers() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get isHot => $_getBF(2);
  @$pb.TagNumber(3)
  set isHot($core.bool v) {
    $_setBool(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasIsHot() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsHot() => clearField(3);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
