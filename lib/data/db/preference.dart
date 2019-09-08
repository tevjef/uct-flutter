import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../proto/model.pb.dart';

final String _tableDefaultUniversity = "default_university";
final String _tableDefaultSemester = "default_semester";

final String _columnId = "_id";
final String _columnUniversity = "default_university";
final String _columnSemester = "default_semester";

class DefaultUniversity {
  String id = "default_university_key";
  University university;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      _columnUniversity: university.writeToJson(),
    };

    if (id != null) {
      map[_columnId] = id;
    }
    return map;
  }

  DefaultUniversity();

  DefaultUniversity.fromMap(Map<String, dynamic> map) {
    id = map[_columnId];
    university = University.fromJson(map[_columnUniversity]);
  }
}

class DefaultSemester {
  String id = "default_semester_key";
  Semester semester;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      _columnSemester: semester.writeToJson(),
    };

    if (id != null) {
      map[_columnId] = id;
    }
    return map;
  }

  DefaultSemester();

  DefaultSemester.fromMap(Map<String, dynamic> map) {
    id = map[_columnId];
    semester = Semester.fromJson(map[_columnSemester]);
  }
}

class PreferenceDao {
  Database db;

  PreferenceDao() {
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
CREATE TABLE $_tableDefaultUniversity ( 
  $_columnId STRING PRIMARY KEY, 
  $_columnUniversity TEXT NOT NULL)
''');

    await db.execute('''
CREATE TABLE $_tableDefaultSemester ( 
  $_columnId STRING PRIMARY KEY, 
  $_columnSemester TEXT NOT NULL)
''');
  }

  Future<DefaultUniversity> insertUniversity(University university) async {
    var db = await open();

    DefaultUniversity defaultUniversity = DefaultUniversity();
    defaultUniversity.university = university;
    await db.insert(_tableDefaultUniversity, defaultUniversity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return defaultUniversity;
  }

  Future<DefaultSemester> insertSemester(Semester semester) async {
    var db = await open();

    DefaultSemester defaultSemester = DefaultSemester();
    defaultSemester.semester = semester;
    await db.insert(_tableDefaultSemester, defaultSemester.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return defaultSemester;
  }

  Future<DefaultUniversity> getDefaultUniversity() async {
    var db = await open();

    List<DefaultUniversity> universities = new List();

    List<Map<String, dynamic>> maps = await db.query(_tableDefaultUniversity,
        columns: [
          _columnId,
          _columnUniversity,
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

    List<Map<String, dynamic>> maps = await db.query(_tableDefaultSemester,
        columns: [
          _columnId,
          _columnSemester,
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
