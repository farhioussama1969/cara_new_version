import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';

class LocalNotificationService {
  static final localNotification = FlutterLocalNotificationsPlugin();

  static void initialize() {
    localNotification.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        ),
      ),
    );
  }

  static void showNotification(
      {required String? title, required String? body}) {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'cara_channel',
      'cara_channel',
      channelDescription: 'cara channel',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      enableVibration: true,
      color: MainColors.primaryColor,
    );
    DarwinNotificationDetails iOSPlatformChannelSpecifics =
        const DarwinNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    localNotification.show(1, title, body, platformChannelSpecifics);
  }
}
