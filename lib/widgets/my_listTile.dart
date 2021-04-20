import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  const MyListTile({
    Key? key,
    this.trailing,
    this.leading,
    this.title,
    this.titleColor,
    this.color,
    this.margin,
    this.padding,
    this.onTap,
  }) : super(key: key);

  final Widget? trailing;
  final Widget? leading;
  final String? title;
  final Color? titleColor;
  final Color? color;
  final Function? onTap;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? null,
      padding: padding ?? null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: color ?? Colors.white,
      ),
      child: ListTile(
        leading: leading,
        title: Text(
          title!,
          style: TextStyle(
            color: titleColor ?? Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: trailing,
        onTap: onTap as void Function()?,
      ),
    );
  }
}
