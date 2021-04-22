import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todo_app/constants/config_constant.dart';
import 'package:todo_app/models/to_do_model.dart';

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
      height: ConfigConstant.size9,
      width: double.infinity,
      child: Column(
        children: [
          _buildTtask(_theme, context),
        ],
      ),
    );
  }

  _buildTtask(ThemeData _theme, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: _theme.backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListTile(
        onTap: onPressed,
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
          style: TextStyle(fontSize: 14),
        ),
        trailing: IconButton(
          icon: Icon(
            todo.prioritized ? Icons.star : Icons.star_outline,
            color: _theme.primaryColor,
          ),
          onPressed: onPriorityPressed,
        ),
      ),
    );
  }
}
