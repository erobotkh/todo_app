import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import "package:path/path.dart";
import 'package:todo_app/models/to_do_model.dart';

class ToDoDatabase {
  ToDoDatabase._privateConstructor();
  static final ToDoDatabase instance = ToDoDatabase._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _init();
    return _database!;
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

  Future<bool> deleteTodoById(int id) async {
    try {
      await _database!.delete("todo", where: "id = $id");
      return true;
    } catch (e) {
      return false;
    }
  }

  /// id and create_on is auto generate by using datetime.now
  /// so we only need name to create new todo.
  Future<bool> addTodo({required String name}) async {
    final validName = name.replaceAll("'", "$singleQuote");
    String query = '''
    INSERT or REPLACE INTO "todo" (
      'id',
      'name',
      'created_on'
    )
    VALUES (
      ${DateTime.now().millisecondsSinceEpoch},
      '$validName',
      ${DateTime.now().millisecondsSinceEpoch}
    )
    ''';

    try {
      await _database!.execute(query);
      return true;
    } catch (e) {
      return false;
    }
  }

  static String singleQuote = "▘";
  Future<bool> updateTodo({
    required ToDoModel todo,
  }) async {
    final note =
        todo.note != null ? todo.note?.replaceAll("'", "$singleQuote") : "";
    final name =
        todo.name != null ? todo.name?.replaceAll("'", "$singleQuote") : "";
    String query = '''
    UPDATE todo 
    SET completed = ${todo.completed ? 1 : 0}, 
        deadline = ${todo.deadline?.millisecondsSinceEpoch},
        name = '$name',
        note = '$note',
        prioritized = ${todo.prioritized ? 1 : 0},
        reminder = ${todo.reminder?.millisecondsSinceEpoch},
        updated_on = ${DateTime.now().millisecondsSinceEpoch},
        deadline = ${todo.deadline?.millisecondsSinceEpoch}
    WHERE id = ${todo.id}
    ''';

    try {
      await _database?.execute(query);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// map of key of `TODO id` and value of `TODO model`
  Future<Map<int, ToDoModel>?> todoListById({String? where}) async {
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
        "deadline",
      ],
      where: where,
    );

    final map = Map.fromIterable(maps, key: (e) {
      return int.parse("${e['id']}");
    }, value: (e) {
      final note =
          e['note'] != null ? e['note']?.replaceAll("$singleQuote", "'") : null;
      final name =
          e['name'] != null ? e['name'].replaceAll("$singleQuote", "'") : null;
      return ToDoModel.fromJson(e).copyWith(
        name: name,
        note: note,
      );
    });

    return map;
  }
}
