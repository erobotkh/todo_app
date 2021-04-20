import 'package:flutter/material.dart';

class DTask extends StatelessWidget {
  const DTask({
    Key? key,
    required this.name,
    required this.onPressed,
  }) : super(key: key);

  final String name;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 1,
            color: _theme.primaryColorDark,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(name),
          ),
          Container(
            width: 100,
            height: 1,
            color: _theme.primaryColorDark,
          ),
        ],
      ),
    );
  }
}
