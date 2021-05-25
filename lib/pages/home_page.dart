import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/constants/config_constant.dart';
import 'package:todo_app/notifier/todo_task_notifier.dart';
import 'package:todo_app/pages/detail_page.dart';
import 'package:todo_app/widgets/t_task_tile.dart';

class HomePage extends HookWidget {
  final String? todoId;
  const HomePage({
    Key? key,
    this.todoId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    var notifier = useProvider(todoTaskNotifier);
    var textController = useTextEditingController();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        TextEditingController().clear();
      },
      child: Scaffold(
        appBar: _buildAppBar(_theme, context),
        body: _buildBody(
          _theme,
          context,
          notifier,
          textController,
        ),
      ),
    );
  }

  _buildAppBar(ThemeData _theme, BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: _theme.primaryColorDark,
      brightness: Brightness.dark,
      leading: IconButton(
        icon: Icon(Icons.done_all, color: Colors.white),
        onPressed: () {},
      ),
      title: Text(
        "បញ្ជីកិច្ចការ",
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }

  _buildBody(
    ThemeData _theme,
    BuildContext context,
    TodoTaskNotifier notifier,
    TextEditingController textController,
  ) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _buildWriteTodo(
          theme: _theme,
          context: context,
          textController: textController,
          onSubmitted: (todoName) async {
            if (todoName.isEmpty) return;
            await notifier.addTodo(todoName);
            textController.clear();
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
    );
  }

  _buildWriteTodo({
    required ThemeData theme,
    required BuildContext context,
    required ValueChanged<String> onSubmitted,
    required TextEditingController textController,
  }) {
    return Container(
      child: TextField(
        style: theme.textTheme.bodyText2,
        onSubmitted: onSubmitted,
        controller: textController,
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
