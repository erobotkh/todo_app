import 'package:flutter/material.dart';
import 'package:todo_app/constants/config_constant.dart';
import 'package:todo_app/pages/detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Scaffold(
      appBar: _buildAppBar(_theme, context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(ThemeData _theme, BuildContext context) {
    return AppBar(
      centerTitle: false,
      brightness: Brightness.dark,
      backgroundColor: _theme.primaryColorDark,
      leading: Icon(Icons.done_all, color: _theme.backgroundColor),
      title: Text(
        "បញ្ជីកិច្ចការ Home Page Testing",
        style: TextStyle(
          color: Theme.of(context).backgroundColor,
        ),
      ),
    );
  }

  Center _buildBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: ConfigConstant.size0),
          TextButton(
            child: const Text("Open Detail Page"),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) {
                    return DetailPage(taskId: "1");
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
