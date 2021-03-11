import 'package:flutter/material.dart';
import 'package:todo_app/constants/config_constant.dart';

class TTaskTile extends StatelessWidget {
  const TTaskTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ConfigConstant.size7,
      width: double.infinity,
    );
  }
}
