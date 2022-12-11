import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/models/to_do_model.dart';
import 'package:todo_app/notifier/notification_notifier.dart';
import 'package:todo_app/notifier/todo_task_notifier.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/widgets/my_listTile.dart';

class DetailPage extends HookWidget {
  const DetailPage({
    Key? key,
    required this.todo,
    this.fromNotification = false,
  }) : super(key: key);
  final ToDoModel todo;
  final bool fromNotification;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final draftNotiifer = useState(todo);
    var notification = useProvider(notificationNotifier(context));

    return ValueListenableBuilder(
      valueListenable: draftNotiifer,
      builder: (context, ToDoModel? value, child) {
        final _todo = value;

        DateFormat formater = DateFormat('dd MMM yyy').add_jm();
        String date = _todo?.deadline != null ? formater.format(_todo!.deadline!) : "";
        String? reminder = _todo?.reminder != null ? formater.format(_todo!.reminder!) : "";

        return WillPopScope(
          onWillPop: () async {
            ScaffoldMessenger.maybeOf(context)?.removeCurrentSnackBar();
            if (fromNotification) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) {
                  return HomePage();
                },
              ));
            } else {
              Navigator.of(context).pop();
            }
            return false;
          },
          child: GestureDetector(
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
                      color: Color(0xFFF1BE43),
                    ),
                    onPressed: () async {
                      var notifier = context.read(todoTaskNotifier);
                      if (_todo == null) return;
                      final updated = _todo.copyWith(
                        prioritized: !_todo.prioritized,
                      );
                      await notifier.setPriority(
                        updated.id!,
                        updated.prioritized,
                      );
                      draftNotiifer.value = updated;
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      final dialog = AlertDialog(
                        title: Text('Are you sure to delete?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('NO'),
                          ),
                          TextButton(
                            onPressed: () async {
                              var notifier = context.read(todoTaskNotifier);
                              await notifier.deleteTask(todo);
                              var notification = context.read(notificationNotifier(context));
                              await notification.removeNotification(todo);
                              Navigator.of(context)
                                ..pop()
                                ..pop();
                            },
                            child: Text('YES'),
                          ),
                        ],
                      );
                      showDialog(
                        context: context,
                        builder: (context) {
                          return dialog;
                        },
                      );
                    },
                    color: Colors.red,
                  ),
                  IconButton(
                    icon: Icon(Icons.save),
                    onPressed: () async {
                      var notifier = context.read(todoTaskNotifier);
                      if (_todo == null) return;
                      await notifier.updateTodo(todo: _todo);
                      // notification.showNotification(_todo);

                      String? message;
                      await notification.scheduleNotification(_todo).onError((error, stackTrace) {
                        message = error.toString();
                      });

                      final snackBar = SnackBar(
                        content: Text(
                          message ?? "Saved successfully",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Theme.of(context).colorScheme.surface),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
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
                        if (_todo == null) return;

                        DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: todo.reminder ?? DateTime.now(),
                          firstDate: DateTime(DateTime.now().year - 50),
                          lastDate: DateTime(DateTime.now().year + 50),
                        );

                        if (date == null) return;

                        TimeOfDay? timeOfDay = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                            DateTime(DateTime.now().year - 50),
                          ),
                        );

                        if (timeOfDay == null) return;

                        final dateResult = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          timeOfDay.hour,
                          timeOfDay.minute,
                        );

                        final updated = _todo.copyWith(deadline: dateResult);
                        draftNotiifer.value = updated;
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
                          initialDate: todo.reminder ?? DateTime.now(),
                          firstDate: DateTime(DateTime.now().year - 50),
                          lastDate: DateTime(DateTime.now().year + 50),
                        );

                        if (date == null) return;

                        TimeOfDay? timeOfDay = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                            DateTime(DateTime.now().year - 50),
                          ),
                        );

                        if (timeOfDay == null) return;
                        if (_todo == null) return;

                        final dateResult = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          timeOfDay.hour,
                          timeOfDay.minute,
                        );

                        final updated = _todo.copyWith(reminder: dateResult);
                        draftNotiifer.value = updated;
                      },
                      trailing: Text(
                        reminder,
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
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Todo name",
                      ),
                      onChanged: (value) {
                        if (_todo == null) return;
                        final updated = _todo.copyWith(name: value);
                        draftNotiifer.value = updated;
                      },
                    ),
                    TextFormField(
                      initialValue: _todo?.note != "null" ? _todo?.note : "",
                      style: Theme.of(context).textTheme.bodyText2,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Note...",
                      ),
                      onChanged: (value) {
                        if (_todo == null) return;
                        final updated = _todo.copyWith(note: value);
                        draftNotiifer.value = updated;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
