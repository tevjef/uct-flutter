import 'dart:async';

import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

final String tableRecentSubject = "recent_subject";
final String tableRecentCourse = "recent_course";

final String columnId = "_id";
final String columnParentTopicName = "parent_topic_name";
final String columnTopicName = "topic_name";

class RecentSelection {
  int id;
  String parentTopicName;
  String topicName;

  Map toMap() {
    Map map = {
      columnParentTopicName: parentTopicName,
      columnTopicName: topicName
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  RecentSelection();

  RecentSelection.fromMap(Map map) {
    id = map[columnId];
    parentTopicName = map[columnParentTopicName];
    topicName = map[columnTopicName];
  }
}

class RecentSelectionDatabase {

  Database db;

  RecentSelectionDatabase() {
    create();
  }

  Future create() async {
    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(path.path, "recents.db");

    db = await openDatabase(dbPath, version: 1, onCreate: this._create);
  }

  Future _create(Database db, int version) async {
    await db.execute('''
CREATE TABLE $tableRecentSubject ( 
  $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
  $columnParentTopicName TEXT NOT NULL,
  $columnTopicName TEXT NOT NULL)
''');

await db.execute('''
CREATE TABLE $tableRecentCourse ( 
  $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
  $columnParentTopicName TEXT NOT NULL,
  $columnTopicName TEXT NOT NULL)
''');
  }

  Future<RecentSelection> insertSubjectSelection(RecentSelection recentSelection) async {
    recentSelection.id =
        await db.insert(tableRecentSubject, recentSelection.toMap());
    return recentSelection;
  }

  Future<RecentSelection> insertCourseSelection(RecentSelection recentSelection) async {
    recentSelection.id = await db.insert(tableRecentCourse, recentSelection.toMap());
    return recentSelection;
  }

  Future<List<RecentSelection>> getRecentSubjectSelection(String topicName) async {
    return _getRecentSelection(tableRecentSubject, topicName);
  }

  Future<List<RecentSelection>> getRecentCourseSelection(String topicName) async {
    return _getRecentSelection(tableRecentCourse, topicName);
  }

  Future<List<RecentSelection>> _getRecentSelection(String table, String topicName) async {
    List<Map> maps = await db.query(table,
        columns: [columnId, columnParentTopicName, columnTopicName],
        where: "$columnParentTopicName = ?",
        whereArgs: [topicName],
        limit: 3,
        orderBy: "rowid");
    if (maps.length > 0) {
      return maps.map((Map m) => RecentSelection.fromMap(m));
    }

    return List();
  }

  Future<int> clearRecentSubject() async {
    return _clearRecents(tableRecentSubject);
  }

  Future<int> clearRecentCourse() async {
    return _clearRecents(tableRecentCourse);
  }

  Future<int> _clearRecents(String table) async {
    return await db.delete(table, where: "$columnParentTopicName IS NOT NULL", whereArgs: []);
  }

  Future close() async => db.close();
}
