import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/constants/config_constant.dart';
import 'package:todo_app/notifier/todo_task_notifier.dart';
import 'package:todo_app/pages/detail_page.dart';
import 'package:todo_app/widgets/d_task_tile.dart';
import 'package:todo_app/widgets/t_task_tile.dart';

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    var notifier = useProvider(todoTaskNotifier);
    return Scaffold(
      appBar: _buildAppBar(_theme, context),
      body: _buildBody(
        _theme,
        context,
        notifier,
      ),
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

  _buildBody(
    ThemeData _theme,
    BuildContext context,
    TodoTaskNotifier notifier,
  ) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: [
          _buildWriteTodo(_theme, context),
          SizedBox(
            height: ConfigConstant.size1,
          ),
          Column(
            children: List.generate(
              notifier.listTodo.length,
              (index) {
                final todo = notifier.listTodo.entries.toList()[index].value;
                return TTaskTile(
                  name: todo.name,
                  iconData: Icons.star,
                  onPressed: () {
                    print(todo.note);
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return DetailPage(todo: todo);
                    }));
                  },
                  taskId: "",
                  taskName: null,
                  iconButton: Icons.radio_button_unchecked,
                );
              },
            ),
          ),
          DTask(
            name: "កិច្ចការរួចរាល់",
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  _buildWriteTodo(ThemeData _theme, BuildContext context) {
    return Container(
      child: TextField(
        style: _theme.textTheme.bodyText2,
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: _theme.backgroundColor,
          filled: true,
          hintText: "Write your to do here...",
        ),
      ),
    );
  }
}
