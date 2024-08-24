// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NotificationServices {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//   final AndroidInitializationSettings androidInitializationSettings =
//   AndroidInitializationSettings('defaultIcon');
//
//   void intialNotification() async {
//     InitializationSettings initializationSettings =
//     InitializationSettings(android: androidInitializationSettings);
//
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   void showNotification() async {
//     AndroidNotificationDetails androidNotificationDetails =
//     AndroidNotificationDetails("channelId", "channelName",
//         importance: Importance.max, priority: Priority.max);
//
//     NotificationDetails notificationDetails =
//     NotificationDetails(android: androidNotificationDetails);
//     await flutterLocalNotificationsPlugin.show(0, 'This is the title',
//         'Hi there is some Surprise for you', notificationDetails);
//   }
//
//   void ScheduleNotification() async {
//     AndroidNotificationDetails androidNotificationDetails =
//     AndroidNotificationDetails(" channelId", "channelName",
//         importance: Importance.max, priority: Priority.max);
//
//     NotificationDetails notificationDetails =
//     NotificationDetails(android: androidNotificationDetails);
//     await flutterLocalNotificationsPlugin.show(
//         0,
//         'This is the title',
//         'Hi there is some Surprise for you',
//         notificationDetails);
//   }
//
//   void StopNoti() {
//     flutterLocalNotificationsPlugin.cancelAll();
//   }
// }
