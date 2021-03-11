import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    Key key,
    @required this.taskId,
  }) : super(key: key);

  final String taskId;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: _theme.backgroundColor,
        title: Text("Detail Page"),
      ),
    );
  }
}
