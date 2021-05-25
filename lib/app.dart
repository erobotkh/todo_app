import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/notifier/notification_notifier.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/config/theme_config.dart';
import 'package:easy_localization/easy_localization.dart';

class App extends HookWidget {
  @override
  Widget build(BuildContext context) {
    useProvider(notificationNotifier(context));
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
