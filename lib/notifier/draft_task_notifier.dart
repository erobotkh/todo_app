import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/models/to_do_model.dart';

class DraftTaskNotifier extends ChangeNotifier {
  ToDoModel? _draftTodo;
  ToDoModel? get draftTodo => this._draftTodo;

  DraftTaskNotifier();
  setDraftTodo(ToDoModel todo) {
    this._draftTodo = todo;
  }

  setState() {
    notifyListeners();
  }
}

final draftTaskProvider = ChangeNotifierProvider<DraftTaskNotifier>((ref) {
  return DraftTaskNotifier();
});
