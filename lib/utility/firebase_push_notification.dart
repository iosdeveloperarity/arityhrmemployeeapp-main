import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future initialise() async {
    var initializationSettingsAndroid =
    new AndroidInitializationSettings('@drawable/logo');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(android: initializationSettingsAndroid,iOS: initializationSettingsIOS);
    if (Platform.isIOS) {
      FirebaseMessaging.instance.requestPermission();
    }

    String token = await FirebaseMessaging.instance.getToken();
    print("FirebaseMessaging token: $token");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if(notification!=null && android!=null){
        showNotification(message.notification.title, message.notification.body);

      }
    });
  }

  void showNotification(String title, String body) async {
    await _demoNotification(title, body);
  }

  Future<void> _demoNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel_ID', 'channel name', 'channel description',
        importance: Importance.max,
        playSound: true,
        icon: '@drawable/logo',
        showProgress: true,
        priority: Priority.high,
        ticker: 'test ticker');

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics,iOS: iOSChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: 'test');
  }
}