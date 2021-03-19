import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todo_app/constants/config_constant.dart';

class TTaskTile extends StatelessWidget {
  const TTaskTile({
    Key key,
    this.isPriority = false,
    this.isComplete = false,
    @required this.name,
    @required this.iconData,
    @required this.iconButton,   
    @required this.taskName,
    @required this.taskId,
    @required this.onPressed,
  }) : super(key: key);

  final bool isPriority;
  final bool isComplete;
  final bool taskName;
  final String taskId;
  final String name;
  final IconData iconData;
  final IconData iconButton;
  final Function onPressed;

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
        leading: Container(
          decoration: BoxDecoration(
            color: _theme.disabledColor,
          ),
          child: IconButton(
            icon: Icon(
              iconButton,
              color: _theme.primaryColorDark,
            ),
            onPressed: () {},
          ),
        ),
        title: Text(
          name,
          style: TextStyle(fontSize: 14),
        ),
        trailing: IconButton(
          icon: Icon(
            iconData,
            color: _theme.primaryColor,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}

