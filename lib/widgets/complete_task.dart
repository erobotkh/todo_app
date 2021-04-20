import 'package:flutter/material.dart';

class Complete extends StatelessWidget {
  final double? fontsize;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final Color? colors;
  final String text;
  final String title;
  const Complete(
      {Key? key,
      this.fontsize,
      this.fontStyle,
      this.fontWeight,
      this.colors,
      required this.title,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 32, 16, 0),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Text(
               title,
                style: TextStyle(
                    color: colors ?? Color.fromRGBO(38, 50, 56, 1),
                    fontSize: fontsize ?? 16,
                    fontWeight: fontWeight ?? FontWeight.normal),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
