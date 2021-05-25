import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/models/to_do_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/notifier/notification_notifier.dart';
import 'package:todo_app/notifier/todo_task_notifier.dart';

class TTaskTile extends StatelessWidget {
  const TTaskTile({
    Key? key,
    required this.todo,
    required this.onPressed,
    required this.onPriorityPressed,
    required this.onSetToComplete,
  }) : super(key: key);

  final ToDoModel todo;
  final void Function() onPressed;
  final void Function() onPriorityPressed;
  final void Function() onSetToComplete;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 8.0),
      child: _buildTtask(_theme, context),
    );
  }

  _buildTtask(ThemeData _theme, BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        decoration: BoxDecoration(color: _theme.backgroundColor),
        child: ListTile(
          onTap: onPressed,
          contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
          leading: Container(
            decoration: BoxDecoration(
              color: _theme.disabledColor,
            ),
            child: IconButton(
              icon: Icon(
                todo.completed
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: _theme.primaryColorDark,
              ),
              onPressed: onSetToComplete,
            ),
          ),
          title: Text(
            todo.name ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              decoration: todo.completed ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              todo.prioritized ? Icons.star : Icons.star_outline,
              color: Color(0xFFF1BE43),
            ),
            onPressed: onPriorityPressed,
          ),
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Theme.of(context).errorColor,
          icon: Icons.delete,
          onTap: () async {
            var notification = context.read(notificationNotifier(context));
            await notification.removeNotification(todo);
            var notifier = context.read(todoTaskNotifier);
            await notifier.deleteTask(todo);
          },
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Theme.of(context).errorColor,
          icon: Icons.delete,
          onTap: () async {
            var notification = context.read(notificationNotifier(context));
            await notification.removeNotification(todo);
            var notifier = context.read(todoTaskNotifier);
            await notifier.deleteTask(todo);
          },
        ),
      ],
    );
  }
}
