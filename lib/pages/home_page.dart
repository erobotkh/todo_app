import 'package:flutter/material.dart';
import 'package:todo_app/constants/config_constant.dart';
import 'package:todo_app/widgets/d_task.dart';
import 'package:todo_app/widgets/t_task_tile.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Scaffold(
      appBar: _buildAppBar(_theme, context),
      body: _buildBody(_theme, context),
    );
  }

  _buildAppBar(ThemeData _theme, BuildContext context) {
    return AppBar(
      centerTitle: false,
      brightness: Brightness.dark,
      backgroundColor: _theme.primaryColorDark,
      leading: IconButton(
          icon: Icon(Icons.done_all, color: _theme.backgroundColor),
          onPressed: () {}),
      title: Text(
        "បញ្ជីកិច្ចការ",
        style: TextStyle(
          color: _theme.backgroundColor,
          fontSize: 14,
        ),
      ),
    );
  }

  _buildBody(ThemeData _theme, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: [
          _buildWriteTodo(_theme, context),
          SizedBox(
            height: ConfigConstant.size1,
          ),
          TTaskTile(
            name: "បញ្ជីកិច្ចការ",
            iconData: Icons.star,
            onPressed: () {},
            taskId: '',
            taskName: null,
            iconButton: Icons.radio_button_unchecked,
          ),
          TTaskTile(
            name: "បញ្ជីកិច្ចការ",
            iconData: Icons.star,
            onPressed: () {},
            taskId: '',
            taskName: null,
            iconButton: Icons.radio_button_unchecked,
          ),
          TTaskTile(
            name: "បញ្ជីកិច្ចការ",
            iconData: Icons.star,
            onPressed: () {},
            taskId: '',
            taskName: null,
            iconButton: Icons.radio_button_unchecked,
          ),
          TTaskTile(
            name: "បញ្ជីកិច្ចការ",
            iconData: Icons.star_border,
            onPressed: () {},
            taskId: '',
            taskName: null,
            iconButton: Icons.radio_button_unchecked,
          ),
          TTaskTile(
            name: "បញ្ជីកិច្ចការ",
            iconData: Icons.star_border,
            onPressed: () {},
            taskId: '',
            taskName: null,
            iconButton: Icons.radio_button_unchecked,
          ),
          SizedBox(
            height: ConfigConstant.size3,
          ),
          DTask(
            name: "កិច្ចការរួចរាល់",
            onPressed: () {},
          ),
          SizedBox(
            height: ConfigConstant.size3,
          ),
          TTaskTile(
            name: "Complete math exercise",
            iconData: Icons.star,
            onPressed: () {},
            taskId: '',
            taskName: null,
            iconButton: Icons.check_circle,
          ),
          TTaskTile(
            name: "Complete math exercise",
            iconData: Icons.star_border,
            onPressed: () {},
            taskId: '',
            taskName: null,
            iconButton: Icons.check_circle,
          ),
          TTaskTile(
            name: "Complete math exercise",
            iconData: Icons.star_border,
            onPressed: () {},
            taskId: '',
            taskName: null,
            iconButton: Icons.check_circle,
          ),        
        ],
      ),
    );
  }

  _buildWriteTodo(ThemeData _theme, BuildContext context) {
    return Container(
      child: TextField(
        decoration: InputDecoration(
          fillColor: _theme.backgroundColor,
          filled: true,
          hintText: "Write your to do here...",
        ),
      ),
    );
  }
}
