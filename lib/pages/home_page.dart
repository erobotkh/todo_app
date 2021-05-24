import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/constants/config_constant.dart';
import 'package:todo_app/notifier/todo_task_notifier.dart';
import 'package:todo_app/pages/detail_page.dart';
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
        onPressed: () {},
      ),
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
          _buildWriteTodo(
            theme: _theme,
            context: context,
            onSubmitted: (todoName) async {
              if (todoName.isEmpty) return;
              await notifier.addTodo(todoName);
            },
          ),
          SizedBox(height: ConfigConstant.size1),
          Column(
            children: List.generate(
              notifier.todoAsList.length,
              (index) {
                final todo = notifier.todoAsList[index];
                return TTaskTile(
                  todo: todo,
                  onPriorityPressed: () async {
                    if (todo.id == null) return;
                    await notifier.setPriority(
                      todo.id!,
                      !todo.prioritized,
                    );
                  },
                  onSetToComplete: () async {
                    if (todo.id == null) return;
                    await notifier.setCompleted(
                      todo.id!,
                      !todo.completed,
                    );
                  },
                  onPressed: () {
                    print(todo.note);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return DetailPage(todo: todo);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _buildWriteTodo({
    required ThemeData theme,
    required BuildContext context,
    required ValueChanged<String> onSubmitted,
  }) {
    return Container(
      child: TextField(
        style: theme.textTheme.bodyText2,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: theme.backgroundColor,
          filled: true,
          hintText: "Write your to do here...",
        ),
      ),
    );
  }
}
