import 'dart:async';

import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../../data/proto/model.pb.dart';
import '../../ui/search_context.dart';

final String tableTrackedSections = "tracked_sections";

final String columnId = "_id";
final String columnUniversityJson = "university_json";
final String columnSemesterJson = "semester_json";
final String columnSubjectJson = "subject_json";
final String columnCourseJson = "course_json";
final String columnSectionJson = "section_json";
final String columnTopicName = "topic_name";

class TrackedSection {
  int id;

  University university;
  Semester semester;
  Subject subject;
  Course course;
  Section section;
  String topicName;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {columnTopicName: topicName};

    if (university != null) {
      map[columnUniversityJson] = university.writeToJson();
    }

    if (semester != null) {
      map[columnSemesterJson] = semester.writeToJson();
    }

    if (subject != null) {
      map[columnSubjectJson] = subject.writeToJson();
    }

    if (course != null) {
      map[columnCourseJson] = course.writeToJson();
    }

    if (section != null) {
      map[columnSectionJson] = section.writeToJson();
    }

    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  TrackedSection();

  TrackedSection.fromMap(Map map) {
    id = map[columnId];
    university = University.fromJson(map[columnUniversityJson]);
    semester = Semester.fromJson(map[columnSemesterJson]);
    subject = Subject.fromJson(map[columnSubjectJson]);
    course = Course.fromJson(map[columnCourseJson]);
    section = Section.fromJson(map[columnSectionJson]);
    topicName = map[columnTopicName];
  }
}

class TrackedSectionDao {

  Database db;

  TrackedSectionDao() {
    open();
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
CREATE TABLE $tableTrackedSections ( 
  $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
  $columnUniversityJson TEXT NOT NULL,
  $columnSemesterJson TEXT NOT NULL,
  $columnSubjectJson TEXT NOT NULL,
  $columnCourseJson TEXT NOT NULL,
  $columnSectionJson TEXT NOT NULL,
  $columnTopicName TEXT NOT NULL
  )
''');
  }

  Future<TrackedSection> insertSearchContext(SearchContext searchContext) {
    TrackedSection trackedSection = TrackedSection();
    University _uni = University.create();
    _uni.name = "Some Name";

    Semester _sem = Semester.create();
    _sem.season = "Spring";
    _sem.year = 2016;

    trackedSection.university = _uni;
    trackedSection.semester = _sem;

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
        tableTrackedSections, trackedSection.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return trackedSection;
  }

  Future<int> deleteTrackedSection(String topicName) async {
    var db = await open();
    var rowsDeleted = await db.delete(tableTrackedSections,
        where: "$columnTopicName = ?", whereArgs: [topicName]);
    return rowsDeleted;
  }

  Future<bool> isSectionTracked(String topicName) async {
    var db = await open();
    List<Map> maps = await db.query(tableTrackedSections,
        columns: [columnId, columnTopicName],
        where: "$columnTopicName = ?",
        whereArgs: [topicName],
        limit: 1,
        orderBy: "rowid");
    return maps.length == 1;
  }

  Future<List<TrackedSection>> getAllTrackedSections() async {
    var db = await open();
    List<Map> maps = await db.query(tableTrackedSections,
        columns: [
          columnId,
          columnTopicName,
          columnUniversityJson,
          columnSemesterJson,
          columnSubjectJson,
          columnCourseJson,
          columnSectionJson
        ],
        orderBy: "rowid");

    if (maps.length > 0) {
      return maps.map((Map m) => TrackedSection.fromMap(m));
    }

    return List();
  }

  Future close() async => db.close();
}
