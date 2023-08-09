import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taskivist/models/Task.dart';
import 'package:get/get.dart';
class DataBaseHelper extends GetxController{
  static final DataBaseHelper _instance = DataBaseHelper.internal();
  factory DataBaseHelper() => _instance;
  final String tableTask = 'taskTable';
  final String columnId = 'id';
  final String columnTitle = 'title';
  final String columnDescription = 'description';
  final String columnDate = 'date';
  static Database? _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await dbInit();
    return _db!;
  }

  Future<Database> dbInit() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    final path = join(appDir.path, 'maindb.db');
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $tableTask($columnId INTEGER PRIMARY KEY, $columnTitle TEXT, $columnDescription TEXT, $columnDate TEXT)',
    );
  }

  Future<int> saveTask(Task task) async {
    var dbClient = await db;
    int res = await dbClient.insert(tableTask, task.toMap());
    return res;
  }

   Future<List> getAllTasks() async {
    var dbClient = await db;
    var results = await dbClient.rawQuery('SELECT * FROM $tableTask');
    return results;
  }

  Future<int?> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM $tableTask'));
  }

  Future<Task> getTask(int id) async {
    var dbClient = await db;
    var result =
        await dbClient.rawQuery('SELECT * FROM $tableTask WHERE $columnId = $id');
    return Task.fromMap(result.first);
  }

  Future<int> deleteUser(int id) async {
    var dbCLient = await db;
    var result = await dbCLient
        .delete(tableTask, where: '$columnId = ?', whereArgs: [id]);
    return result;
  }

  Future<int> updateTask(int id,Task task) async {
    var dbClient = await db;
    var result = await dbClient.update(tableTask, task.toMap(),
        where: '$columnId = ?', whereArgs: [id]);
    return result;
  }
  Future<List> sortByLastest()async{
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableTask ORDER BY $columnDate ASC");
    return result;
  }
   Future<List> sortByOldest()async{
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableTask ORDER BY $columnDate DESC");
    return result;
  }

 Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

  DataBaseHelper.internal();
}
