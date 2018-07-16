import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../proto/model.pb.dart';

final String tableDefaultUniversity = "default_university";
final String tableDefaultSemester = "default_semester";

final String columnId = "_id";
final String columnUniversity = "default_university";
final String columnSemester = "default_semester";

class DefaultUniversity {
  String id = "default_university_key";
  University university;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      columnUniversity: university.writeToJson(),
    };

    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  DefaultUniversity();

  DefaultUniversity.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    university = University.fromJson(map[columnUniversity]);
  }
}

class DefaultSemester {
  String id = "default_semester_key";
  Semester semester;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      columnSemester: semester.writeToJson(),
    };

    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  DefaultSemester();

  DefaultSemester.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    semester = Semester.fromJson(map[columnSemester]);
  }
}

class PreferenceDao {
  Database db;

  PreferenceDao() {
    open();
  }

  Future<Database> open() async {
    if (db != null) {
      return db;
    }

    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(path.path, "preference.db");

    db = await openDatabase(dbPath, version: 1, onCreate: this._create);

    return db;
  }

  Future _create(Database db, int version) async {
    await db.execute('''
CREATE TABLE $tableDefaultUniversity ( 
  $columnId STRING PRIMARY KEY, 
  $columnUniversity TEXT NOT NULL)
''');

    await db.execute('''
CREATE TABLE $tableDefaultSemester ( 
  $columnId STRING PRIMARY KEY, 
  $columnSemester TEXT NOT NULL)
''');
  }

  Future<DefaultUniversity> insertUniversity(University university) async {
    var db = await open();

    DefaultUniversity defaultUniversity = DefaultUniversity();
    defaultUniversity.university = university;
    await db.insert(tableDefaultUniversity, defaultUniversity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return defaultUniversity;
  }

  Future<DefaultSemester> insertSemester(Semester semester) async {
    var db = await open();

    DefaultSemester defaultSemester = DefaultSemester();
    defaultSemester.semester = semester;
    await db.insert(tableDefaultSemester, defaultSemester.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return defaultSemester;
  }

  Future<DefaultUniversity> getDefaultUniversity() async {
    var db = await open();

    List<DefaultUniversity> universities = new List();

    List<Map<String, dynamic>> maps = await db.query(tableDefaultUniversity,
        columns: [
          columnId,
          columnUniversity,
        ],
        limit: 1);
    if (maps.length > 0) {
      maps.forEach((Map<String, dynamic> m) =>
          universities.add(DefaultUniversity.fromMap(m)));
    }

    if (universities.isEmpty) {
      return null;
    }

    return universities[0];
  }

  Future<DefaultSemester> getDefaultSemester() async {
    var db = await open();

    List<DefaultSemester> semesters = new List();

    List<Map<String, dynamic>> maps = await db.query(tableDefaultSemester,
        columns: [
          columnId,
          columnSemester,
        ],
        limit: 1);
    if (maps.length > 0) {
      maps.forEach((Map<String, dynamic> m) =>
          semesters.add(DefaultSemester.fromMap(m)));
    }

    if (semesters.isEmpty) {
      return null;
    }

    return semesters[0];
  }

  Future close() async => db.close();
}
