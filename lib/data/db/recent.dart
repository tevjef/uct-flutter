import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final String tableRecentSubject = "recent_subject";
final String tableRecentCourse = "recent_course";

final String columnId = "_id";
final String columnParentTopicName = "parent_topic_name";
final String columnTopicName = "topic_name";
final String columnUpdatedAt = "updated_at";

class RecentSelection {
  int id;
  String parentTopicName;
  String topicName;
  String updatedAt = DateTime.now().millisecondsSinceEpoch.toString();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      columnParentTopicName: parentTopicName,
      columnTopicName: topicName,
      columnUpdatedAt: updatedAt
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  RecentSelection();

  RecentSelection.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    parentTopicName = map[columnParentTopicName];
    topicName = map[columnTopicName];
    updatedAt = map[columnUpdatedAt];
  }
}

class RecentSelectionDatabase {
  Database db;

  RecentSelectionDatabase() {
    open();
  }

  Future<Database> open() async {
    if (db != null) {
      return db;
    }

    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(path.path, "recents.db");

    db = await openDatabase(dbPath, version: 1, onCreate: this._create);

    return db;
  }

  Future _create(Database db, int version) async {
    await db.execute('''
CREATE TABLE $tableRecentSubject ( 
  $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
  $columnParentTopicName TEXT NOT NULL,
  $columnTopicName TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  UNIQUE($columnParentTopicName, $columnTopicName) ON CONFLICT REPLACE)

''');

    await db.execute('''
CREATE TABLE $tableRecentCourse ( 
  $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
  $columnParentTopicName TEXT NOT NULL,
  $columnTopicName TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  UNIQUE($columnParentTopicName, $columnTopicName) ON CONFLICT REPLACE)
''');
  }

  Future<RecentSelection> insertSubjectSelection(
      RecentSelection recentSelection) async {
    var db = await open();

    recentSelection.id =
        await db.insert(tableRecentSubject, recentSelection.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace);
    return recentSelection;
  }

  Future<RecentSelection> insertCourseSelection(
      RecentSelection recentSelection) async {
    var db = await open();

    recentSelection.id =
        await db.insert(tableRecentCourse, recentSelection.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace);
    return recentSelection;
  }

  Future<List<RecentSelection>> getRecentSubjectSelection(
      String topicName) async {
    return _getRecentSelection(tableRecentSubject, topicName);
  }

  Future<List<RecentSelection>> getRecentCourseSelection(
      String topicName) async {
    return _getRecentSelection(tableRecentCourse, topicName);
  }

  Future<List<RecentSelection>> _getRecentSelection(
      String table, String topicName) async {
    var db = await open();

    List<RecentSelection> recentSelections = List();

    List<Map<String, dynamic>> maps = await db.query(table,
        columns: [columnId, columnParentTopicName, columnTopicName, columnUpdatedAt],
        where: "$columnParentTopicName = ?",
        whereArgs: [topicName],
        limit: 3,
        orderBy: "$columnUpdatedAt DESC");
    if (maps.length > 0) {
      maps.forEach((Map<String, dynamic> m) =>
          recentSelections.add(RecentSelection.fromMap(m)));
    }

    return recentSelections.reversed.toList();
  }

  Future<int> clearRecentSubject() async {
    return _clearRecents(tableRecentSubject);
  }

  Future<int> clearRecentCourse() async {
    return _clearRecents(tableRecentCourse);
  }

  Future<int> _clearRecents(String table) async {
    var db = await open();

    return await db.delete(table, where: "$columnParentTopicName IS NOT NULL");
  }

  Future close() async => db.close();
}
