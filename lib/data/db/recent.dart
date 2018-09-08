import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final String _tableRecentSubject = "recent_subject";
final String _tableRecentCourse = "recent_course";

final String _columnId = "_id";
final String _columnParentTopicName = "parent_topic_name";
final String _columnTopicName = "topic_name";
final String _columnUpdatedAt = "updated_at";

class RecentSelection {
  int id;
  String parentTopicName;
  String topicName;
  String updatedAt = DateTime.now().millisecondsSinceEpoch.toString();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      _columnParentTopicName: parentTopicName,
      _columnTopicName: topicName,
      _columnUpdatedAt: updatedAt
    };
    if (id != null) {
      map[_columnId] = id;
    }
    return map;
  }

  RecentSelection();

  RecentSelection.fromMap(Map<String, dynamic> map) {
    id = map[_columnId];
    parentTopicName = map[_columnParentTopicName];
    topicName = map[_columnTopicName];
    updatedAt = map[_columnUpdatedAt];
  }
}

class RecentSelectionDao {
  Database db;

  RecentSelectionDao() {
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
CREATE TABLE $_tableRecentSubject ( 
  $_columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
  $_columnParentTopicName TEXT NOT NULL,
  $_columnTopicName TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  UNIQUE($_columnParentTopicName, $_columnTopicName) ON CONFLICT REPLACE)

''');

    await db.execute('''
CREATE TABLE $_tableRecentCourse ( 
  $_columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
  $_columnParentTopicName TEXT NOT NULL,
  $_columnTopicName TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  UNIQUE($_columnParentTopicName, $_columnTopicName) ON CONFLICT REPLACE)
''');
  }

  Future<RecentSelection> insertSubjectSelection(
      RecentSelection recentSelection) async {
    var db = await open();

    recentSelection.id = await db.insert(
        _tableRecentSubject, recentSelection.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return recentSelection;
  }

  Future<RecentSelection> insertCourseSelection(
      RecentSelection recentSelection) async {
    var db = await open();

    recentSelection.id = await db.insert(
        _tableRecentCourse, recentSelection.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return recentSelection;
  }

  Future<List<RecentSelection>> getRecentSubjectSelection(
      String topicName) async {
    return _getRecentSelection(_tableRecentSubject, topicName);
  }

  Future<List<RecentSelection>> getRecentCourseSelection(
      String topicName) async {
    return _getRecentSelection(_tableRecentCourse, topicName);
  }

  Future<List<RecentSelection>> _getRecentSelection(
      String table, String topicName) async {
    var db = await open();

    List<RecentSelection> recentSelections = List();

    List<Map<String, dynamic>> maps = await db.query(table,
        columns: [
          _columnId,
          _columnParentTopicName,
          _columnTopicName,
          _columnUpdatedAt
        ],
        where: "$_columnParentTopicName = ?",
        whereArgs: [topicName],
        limit: 3,
        orderBy: "$_columnUpdatedAt DESC");
    if (maps.length > 0) {
      maps.forEach((Map<String, dynamic> m) =>
          recentSelections.add(RecentSelection.fromMap(m)));
    }

    return recentSelections.reversed.toList();
  }

  Future<int> clearRecentSubject() async {
    return _clearRecents(_tableRecentSubject);
  }

  Future<int> clearRecentCourse() async {
    return _clearRecents(_tableRecentCourse);
  }

  Future<int> _clearRecents(String table) async {
    var db = await open();

    return await db.delete(table, where: "$_columnParentTopicName IS NOT NULL");
  }

  Future close() async => db.close();
}
