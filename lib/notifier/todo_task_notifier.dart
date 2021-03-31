import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/examples/examples.dart';
import 'package:todo_app/models/to_do_model.dart';

class TodoTaskNotifier extends ChangeNotifier {
  List<ToDoModel> _listTodo = [];
  getTodoList() {
    _listTodo = globalToDoList;
    return _listTodo;
  }

  getIncompletTasks() {
    List<ToDoModel> _doneTasks = [];
    for (var todoTask in _listTodo) {
      if (todoTask.completed == false) {
        _doneTasks.add(todoTask);
      }
    }
    return _doneTasks;
  }

  getCompletedTasks() {
    List<ToDoModel> _doneTasks = [];
    for (var todoTask in _listTodo) {
      if (todoTask.completed == true) {
        _doneTasks.add(todoTask);
      }
    }
    return _doneTasks;
  }

  deleteTask(ToDoModel task) {
    _listTodo.remove(task);
    print('deleted');
    notifyListeners();
  }
}

final todoTaskNotifier = ChangeNotifierProvider<TodoTaskNotifier>(
  (ref) {
    final notifier = TodoTaskNotifier()..getTodoList();
    return notifier;
  },
);
