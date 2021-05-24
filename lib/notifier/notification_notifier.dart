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
    var initializationSettingsAndroid =
        AndroidInitializationSettings('flutter_devs');
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
    if (toDo.deadline == null) return;
    if ((toDo.deadline?.millisecondsSinceEpoch ?? 0) -
            DateTime.now().millisecondsSinceEpoch <
        0) return;

    await removeNotification(toDo);
    var scheduledNotificationDateTime =
        tz.TZDateTime.from(toDo.deadline!, tz.local);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'notification',
      'Notification',
      'Push notification',
      icon: 'flutter_devs',
      largeIcon: DrawableResourceAndroidBitmap('flutter_devs'),
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
}

final notificationNotifier =
    ChangeNotifierProvider.family<NotificationNotifier, BuildContext>(
        (ref, context) {
  return NotificationNotifier(context);
});
