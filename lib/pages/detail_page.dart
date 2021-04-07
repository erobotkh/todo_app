import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/models/to_do_model.dart';
import 'package:todo_app/notifier/todo_task_notifier.dart';
import 'package:todo_app/widgets/my_listTile.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'home_page.dart';

class DetailPage extends HookWidget {
  const DetailPage({
    Key key,
    @required this.todo,
  }) : super(key: key);

  final ToDoModel todo;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    // ToDoModel todo =
    //     globalToDoList.firstWhere((element) => element.id == taskId);
    DateFormat formater = DateFormat('dd MMM yyy').add_jm();
    String date = formater.format(todo.createdOn);
    String reminder = timeago.format(todo.reminder);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _theme.backgroundColor,
        // title: Text("Detail Page"),
        actions: [
          IconButton(
            icon: Icon(
              todo.prioritized == true
                  ? Icons.star_rate_rounded
                  : Icons.star_rate_outlined,
              color: Colors.blue,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              var notifier = useProvider(todoTaskNotifier);
              notifier.deleteTask(todo);
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) {
                    return HomePage();
                  },
                ),
              );
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
              trailing: Text(
                reminder ?? 'reminder',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Text(
              todo.name ?? "no name",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 16),
            Text(
              todo.note ?? 'no note',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
