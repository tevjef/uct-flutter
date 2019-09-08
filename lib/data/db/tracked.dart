import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/proto/model.pb.dart';
import '../search_context.dart';

final String _tableTrackedSections = "tracked_sections";

final String _columnId = "_id";
final String _columnUniversityJson = "university_json";
final String _columnSemesterJson = "semester_json";
final String _columnSubjectJson = "subject_json";
final String _columnCourseJson = "course_json";
final String _columnSectionJson = "section_json";
final String _columnTopicName = "topic_name";

class TrackedSection {
  int id;

  University university;
  Semester semester;
  Subject subject;
  Course course;
  Section section;
  String topicName;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {_columnTopicName: topicName};

    if (university != null) {
      map[_columnUniversityJson] = university.writeToJson();
    }

    if (semester != null) {
      map[_columnSemesterJson] = semester.writeToJson();
    }

    if (subject != null) {
      map[_columnSubjectJson] = subject.writeToJson();
    }

    if (course != null) {
      map[_columnCourseJson] = course.writeToJson();
    }

    if (section != null) {
      map[_columnSectionJson] = section.writeToJson();
    }

    if (id != null) {
      map[_columnId] = id;
    }
    return map;
  }

  SearchContext toSearchContext() {
    var searchContext = SearchContext();

    searchContext.university = this.university;
    searchContext.semester = this.semester;
    searchContext.subject = this.subject;
    searchContext.course = this.course;
    searchContext.section = this.section;

    return searchContext;
  }

  TrackedSection();

  TrackedSection.fromMap(Map<String, dynamic> map) {
    id = map[_columnId];
    university = University.fromJson(map[_columnUniversityJson]);
    semester = Semester.fromJson(map[_columnSemesterJson]);
    subject = Subject.fromJson(map[_columnSubjectJson]);
    course = Course.fromJson(map[_columnCourseJson]);
    section = Section.fromJson(map[_columnSectionJson]);
    topicName = map[_columnTopicName];
  }
}

class TrackedSectionDao {
  Database db;

  TrackedSectionDao() {
  }

  Future<Database> open() async {
    if (db != null) {
      return db;
    }

    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(path.path, "tracked.db");

    db = await openDatabase(dbPath, version: 1, onCreate: this._create);

    return db;
  }

  Future _create(Database db, int version) async {
    // TODO set unique constraint on the the topic name.
    await db.execute('''
CREATE TABLE $_tableTrackedSections ( 
  $_columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
  $_columnUniversityJson TEXT NOT NULL,
  $_columnSemesterJson TEXT NOT NULL,
  $_columnSubjectJson TEXT NOT NULL,
  $_columnCourseJson TEXT NOT NULL,
  $_columnSectionJson TEXT NOT NULL,
  $_columnTopicName TEXT NOT NULL
  )
''');
  }

  Future<TrackedSection> insertSearchContext(SearchContext searchContext) {
    TrackedSection trackedSection = TrackedSection();

    trackedSection.university = searchContext.university;
    trackedSection.semester = searchContext.semester;

    trackedSection.subject = searchContext.subject;
    trackedSection.course = searchContext.course;
    trackedSection.section = searchContext.section;
    trackedSection.topicName = searchContext.sectionTopicName;

    return insertTrackedSection(trackedSection);
  }

  Future<TrackedSection> insertTrackedSection(
      TrackedSection trackedSection) async {
    var db = await open();
    trackedSection.id = await db.insert(
        _tableTrackedSections, trackedSection.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return trackedSection;
  }

  Future<int> deleteTrackedSection(String topicName) async {
    var db = await open();
    var rowsDeleted = await db.delete(_tableTrackedSections,
        where: "$_columnTopicName = ?", whereArgs: [topicName]);
    return rowsDeleted;
  }

  Future<bool> isSectionTracked(String topicName) async {
    var db = await open();
    List<Map> maps = await db.query(_tableTrackedSections,
        columns: [_columnId, _columnTopicName],
        where: "$_columnTopicName = ?",
        whereArgs: [topicName],
        limit: 1,
        orderBy: "rowid");
    return maps.length == 1;
  }

  Future<List<TrackedSection>> getAllTrackedSections() async {
    var db = await open();

    List<Map<String, dynamic>> maps = await db.query(_tableTrackedSections,
        columns: [
          _columnId,
          _columnTopicName,
          _columnUniversityJson,
          _columnSemesterJson,
          _columnSubjectJson,
          _columnCourseJson,
          _columnSectionJson
        ],
        orderBy: "rowid");

    if (maps.length > 0) {
      return maps
          .map((Map<String, dynamic> m) => TrackedSection.fromMap(m))
          .toList();
    }

    return List();
  }

  Future close() async => db.close();
}
