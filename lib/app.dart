import 'package:flutter/material.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/config/theme_config.dart';
import 'package:easy_localization/easy_localization.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      title: 'To Do',
      home: HomePage(),
      theme: ThemeConfig().theme,
      debugShowCheckedModeBanner: false,
    );
  }
}
