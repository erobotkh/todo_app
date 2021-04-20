import 'package:flutter/material.dart';

class MainActionButton extends StatelessWidget {
  const MainActionButton({
    Key? key,
    this.trailing,
    this.backgroundColor,
    this.date,
    this.time,
    this.colors,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  final Color? backgroundColor;
  final String label;
  final Widget? trailing;
  final VoidCallback onPressed;
  final String? date;
  final String? time;
  final Color? colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
      width: MediaQuery.of(context).size.width,
      height: 52,
      decoration: BoxDecoration(
        color: colors ?? Colors.blue,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              label,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "$date, ",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  time!,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
