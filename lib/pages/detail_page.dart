import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/models/to_do_model.dart';
import 'package:todo_app/notifier/draft_task_notifier.dart';
import 'package:todo_app/notifier/todo_task_notifier.dart';
import 'package:todo_app/widgets/my_listTile.dart';
import 'package:timeago/timeago.dart' as timeago;

class DetailPage extends HookWidget {
  const DetailPage({
    Key? key,
    required this.todo,
  }) : super(key: key);
  final ToDoModel todo;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    final notifier = useProvider(draftTaskProvider)..setDraftTodo(todo);
    final _todo = notifier.draftTodo;

    DateFormat formater = DateFormat('dd MMM yyy').add_jm();
    String date =
        _todo?.deadline != null ? formater.format(_todo!.deadline!) : "";
    String? reminder =
        _todo?.reminder != null ? timeago.format(_todo!.reminder!) : null;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        TextEditingController().clear();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _theme.backgroundColor,
          actions: [
            IconButton(
              icon: Icon(
                _todo?.prioritized == true
                    ? Icons.star_rate_rounded
                    : Icons.star_rate_outlined,
                color: Colors.blue,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                var notifier = context.read(todoTaskNotifier);
                await notifier.deleteTask(todo);
                Navigator.of(context).pop();
              },
              color: Colors.red,
            ),
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {},
              color: Colors.blue,
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyListTile(
                margin: EdgeInsets.only(bottom: 8),
                color: Colors.blue,
                title: 'Deadline',
                titleColor: Colors.white,
                onTap: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: todo.reminder ?? DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 50),
                    lastDate: DateTime(DateTime.now().year + 50),
                  );

                  if (date == null) return;
                  if (_todo == null) return;

                  final updated = _todo.copyWith(deadline: date);
                  notifier.setDraftTodo(updated);
                  notifier.setState();
                },
                trailing: Text(
                  date,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              MyListTile(
                margin: EdgeInsets.only(bottom: 32),
                color: Colors.black,
                title: 'Reminder',
                titleColor: Colors.white,
                onTap: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: _todo?.reminder ?? DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 50),
                    lastDate: DateTime(DateTime.now().year + 50),
                  );

                  if (date == null) return;
                  if (_todo == null) return;

                  final updated = _todo.copyWith(reminder: date);
                  notifier.setDraftTodo(updated);
                  notifier.setState();
                },
                trailing: Text(
                  reminder ?? "",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              TextFormField(
                initialValue: _todo?.name,
                style: Theme.of(context).textTheme.bodyText1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Todo name",
                ),
                onChanged: (value) {
                  if (_todo == null) return;
                  final updated = _todo.copyWith(name: value);
                  notifier.setDraftTodo(updated);
                  notifier.setState();
                },
              ),
              TextFormField(
                initialValue: _todo?.note,
                style: Theme.of(context).textTheme.bodyText2,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Note...",
                ),
                onChanged: (value) {
                  if (_todo == null) return;
                  final updated = _todo.copyWith(note: value);
                  notifier.setDraftTodo(updated);
                  notifier.setState();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
