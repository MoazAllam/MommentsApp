import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;

// class NotificationService {
//   static final NotificationService _notificationService =
//       NotificationService._internal();

//   factory NotificationService() {
//     return _notificationService;
//   }

//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   NotificationService._internal();

//   Future<void> initNotification() async {
//     final AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@drawable/splash');

//     final IOSInitializationSettings initializationSettingsIOS =
//         IOSInitializationSettings(
//       requestAlertPermission: false,
//       requestBadgePermission: false,
//       requestSoundPermission: false,
//     );

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   Future<void> showNotification(
//       int id, String title, String body, int seconds) async {
//     await flutterLocalNotificationsPlugin.show(
//       id,
//       title,
//       body,
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//             'main_channel',
//             'Main Channel'
//                 'Main channel notifications',
//             importance: Importance.max,
//             priority: Priority.max,
//             icon: '@drawable/splash'),
//         iOS: IOSNotificationDetails(
//           sound: 'default.wav',
//           presentAlert: true,
//           presentBadge: true,
//           presentSound: true,
//         ),
//       ),
//     );
//   }

//   Future<void> cancelAllNotifications() async {
//     await flutterLocalNotificationsPlugin.cancelAll();
//   }
// }

class NotificationService {
  static final notifications = FlutterLocalNotificationsPlugin();

  static Future notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name'
            'channel description',
        importance: Importance.max,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future init({bool initScheduled = false}) async {
    final android = AndroidInitializationSettings('@drawable/splash');
    final iOS = IOSInitializationSettings();
    final settings = InitializationSettings(android: android, iOS: iOS);
    await notifications.initialize(
      settings,
    );
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      notifications.show(
        id,
        title,
        body,
        await notificationDetails(),
        payload: payload,
      );

  static Future showDailyNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime date,
  }) async =>
      notifications.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(date, tz.local),
        // scheduleDaily(const Time(
        //   06,
        //   08,
        //   00,
        // )),
        await notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        // matchDateTimeComponents: DateTimeComponents.time,
      );

  static tz.TZDateTime scheduleDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduliDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
      time.second,
    );

    return scheduliDate.isBefore(now)
        ? scheduliDate.add(const Duration(days: 1))
        : scheduliDate;
  }
}
