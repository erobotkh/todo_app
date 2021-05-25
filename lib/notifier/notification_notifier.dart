import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/database/todo_database.dart';
import 'package:todo_app/models/to_do_model.dart';
import 'package:todo_app/pages/detail_page.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationNotifier extends ChangeNotifier {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final BuildContext context;

  NotificationNotifier(this.context) {
    tz.initializeTimeZones();
    var initializationSettingsAndroid = AndroidInitializationSettings('logo');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOs,
    );
    flutterLocalNotificationsPlugin.initialize(
      initSetttings,
      onSelectNotification: (String? value) async {
        final map =
            await ToDoDatabase.instance.todoListById(where: "id = $value");
        if (map != null && map.isNotEmpty) {
          return Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (_) {
                return DetailPage(
                  todo: map.values.first,
                  fromNotification: true,
                );
              },
            ),
          );
        }
      },
    );
  }

  Future<void> removeNotification(ToDoModel toDo) async {
    await flutterLocalNotificationsPlugin
        .cancel(DateTime.fromMillisecondsSinceEpoch(toDo.id!).hashCode);
  }

  Future<void> scheduleNotification(ToDoModel toDo) async {
    if (toDo.id == null) return;
    if (toDo.reminder == null) return;
    if ((toDo.reminder?.millisecondsSinceEpoch ?? 0) <
        (toDo.deadline?.millisecondsSinceEpoch ?? 0)) return;

    await removeNotification(toDo);
    var scheduledNotificationDateTime =
        tz.TZDateTime.from(toDo.reminder!, tz.local);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'notification',
      'Notification',
      'Push notification',
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      DateTime.fromMillisecondsSinceEpoch(toDo.id!).hashCode,
      "Reminder",
      toDo.name,
      scheduledNotificationDateTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      payload: toDo.id.toString(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> showNotification(ToDoModel toDoModel) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'notification',
      'Notification',
      'Push notification',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      DateTime.fromMillisecondsSinceEpoch(toDoModel.id!).hashCode,
      'Added to Reminder',
      toDoModel.name,
      platformChannelSpecifics,
      payload: toDoModel.id.toString(),
    );
  }
}

final notificationNotifier =
    ChangeNotifierProvider.family<NotificationNotifier, BuildContext>(
        (ref, context) {
  return NotificationNotifier(context);
});
