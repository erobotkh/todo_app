import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/database/todo_database.dart';
import 'package:todo_app/models/to_do_model.dart';

class TodoTaskNotifier extends ChangeNotifier {
  Map<int, ToDoModel>? _listTodo;
  Map<int, ToDoModel> get listTodo => _listTodo ?? {};

  final database = ToDoDatabase.instance;

  load() async {
    final result = await database.todoListById();
    if (result != null) {
      this._listTodo = result;
    }
    notifyListeners();
  }

  Future<void> setPriority(int id, bool prioritied) async {
    ToDoModel? updatedTodo = listTodo[id]?.copyWith(prioritized: prioritied);
    if (updatedTodo == null) return;
    await updateTodo(todo: updatedTodo);
  }

  Future<void> addTodo(String name) async {
    await database.addTodo(name: name);
    await load();
  }

  Future<void> updateTodo({required ToDoModel todo}) async {
    await database.updateTodo(todo: todo);
    await load();
  }

  Future<void> setCompleted(int id, bool completed) async {
    ToDoModel? updatedTodo = listTodo[id]?.copyWith(completed: completed);
    if (updatedTodo == null) return;
    updateTodo(todo: updatedTodo);
  }

  deleteTask(ToDoModel task) async {
    if (task.id == null) return;
    await database.deleteTodoById(task.id!);
    await load();
    notifyListeners();
  }

  List<ToDoModel> get todoAsList {
    final list = listTodo.entries.toList();
    return list.map((e) => e.value).toList();
  }
}

final todoTaskNotifier = ChangeNotifierProvider<TodoTaskNotifier>(
  (ref) {
    final notifier = TodoTaskNotifier()..load();
    return notifier;
  },
);
