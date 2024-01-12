import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SendMoneySucceseController {
  final messaging = FirebaseMessaging.instance;
  final plagin = FlutterLocalNotificationsPlugin();

  //// notification request
  Future<void> getRequest() async {
    await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      sound: true,
      provisional: true,
    );
  }

  /// token get
  Future<String?> getToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  Future<void> getNotification() async {
    FirebaseMessaging.onMessage.listen((message) {
      print(message.notification!.title);
      print(message.notification!.body);
      showNotificaton(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      showNotificaton(message);
    });
  }

  //// initialization notification

  Future<void> initNotification() async {
    var android = const AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = const DarwinInitializationSettings();

    var initialization = InitializationSettings(
      android: android,
      iOS: ios,
    );

    await plagin.initialize(initialization);
  }

  //// show notification
  void showNotificaton(RemoteMessage message) async {
    var androidChanel = AndroidNotificationChannel(
        Random().nextInt(1000).toString(), 'Notification');

    var android =
        AndroidNotificationDetails(androidChanel.id, androidChanel.name);
    var ios = const DarwinNotificationDetails();

    var notificationDetails = NotificationDetails(android: android, iOS: ios);

    await plagin.show(00, message.notification!.title,
        message.notification!.body, notificationDetails);

    //await plagin.
  }
}
