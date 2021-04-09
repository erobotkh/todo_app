import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import "package:path/path.dart";
import 'package:todo_app/models/to_do_model.dart';

class ToDoDatabase {
  ToDoDatabase._privateConstructor();
  static final ToDoDatabase instance = ToDoDatabase._privateConstructor();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _init();
    return _database;
  }

  Future<Database> _init() async {
    Directory applicationDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(applicationDirectory.path, "database.db");

    bool dbExists = await File(dbPath).exists();

    if (!dbExists) {
      // copy from asset
      ByteData data = await rootBundle.load(
        join("assets/database", "database.db"),
      );

      List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );

      // write and flush the bytes written
      await File(dbPath).writeAsBytes(bytes, flush: true);
    }

    return await openDatabase(dbPath);
  }

  /// map of key of `TODO id` and value of `TODO model`
  Future<Map<int, ToDoModel>> todoListById() async {
    var client = await database;
    List<Map<String, dynamic>> maps = await client.query(
      "todo",
      columns: [
        "id",
        "prioritized",
        "completed",
        "name",
        "note",
        "reminder",
        "created_on",
        "updated_on",
      ],
    );

    final map = Map.fromIterable(maps, key: (e) {
      return int.parse("${e['id']}");
    }, value: (e) {
      return ToDoModel.fromJson(e);
    });

    return map;
  }
}
