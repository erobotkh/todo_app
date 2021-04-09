import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/database/todo_database.dart';
import 'package:todo_app/models/to_do_model.dart';

class TodoTaskNotifier extends ChangeNotifier {
  Map<int, ToDoModel> listTodo = {};
  final database = ToDoDatabase.instance;

  load() async {
    final result = await database.todoListById();
    if (result != null) {
      this.listTodo = result;
    }
    return listTodo;
  }

  getIncompletTasks() {
    List<ToDoModel> _doneTasks = [];
    for (var todoTask in listTodo.entries) {
      if (todoTask.value.completed == false) {
        _doneTasks.add(todoTask.value);
      }
    }
    return _doneTasks;
  }

  getCompletedTasks() {
    List<ToDoModel> _doneTasks = [];
    for (var todoTask in listTodo.entries) {
      if (todoTask.value.completed == true) {
        _doneTasks.add(todoTask.value);
      }
    }
    return _doneTasks;
  }

  deleteTask(ToDoModel task) {
    listTodo.remove(task);
    print('deleted');
    notifyListeners();
  }
}

final todoTaskNotifier = ChangeNotifierProvider<TodoTaskNotifier>(
  (ref) {
    final notifier = TodoTaskNotifier()..load();
    return notifier;
  },
);
