import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> handelBackgroundMessage(RemoteMessage massage) async {
  print('------ back ${massage.notification!.title}');
  print('------ back ${massage.notification!.body}');
}

Future<void> handelForegroundMessage(RemoteMessage massage) async {
  print('------ Fore ${massage.notification!.title}');
  print('------ Fore ${massage.notification!.body}');
}

void handelMessage(RemoteMessage? massage) {
  if (massage == null) return;

  print('------ handel ${massage.notification!.title}');
  print('------ handel ${massage.notification!.body}');
  // navigatorKey.currentState?.pushReplacement(MaterialPageRoute(
  //   builder: (context) => const VideoScreen(),
  // ));
}

class FirebaseFCM {
  final firebaseMessaging = FirebaseMessaging.instance;

  // final firebaseInAppMessage = FirebaseInAppMessaging.instance;

  bool isFlutterLocalNotificationsInitialized = false;

  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.defaultImportance,
  );
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then(handelMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handelMessage);
    FirebaseMessaging.onBackgroundMessage(handelBackgroundMessage);
    FirebaseMessaging.onMessage.listen((massage) {
      final notification = massage.notification;
      if (notification == null) return;

      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
            android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: '@drawable/launcher_icon',
        )),
        payload: jsonEncode(massage.toMap()),
      );
    });
  }

  Future initLocalNotification() async {
    const android = AndroidInitializationSettings('@drawable/launcher_icon');
    const settings = InitializationSettings(android: android);

    await flutterLocalNotificationsPlugin.initialize(settings,
        onDidReceiveNotificationResponse: (payload) {
      final message = RemoteMessage.fromMap(jsonDecode(payload as String));
      handelMessage(message);
    });
    final platform =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(channel);
  }

  Future<void> initNotifications() async {
    await firebaseMessaging.requestPermission();
    final fCMToken = await firebaseMessaging.getToken();
    // await FirebaseMessaging.instance.subscribeToTopic('all');
    print('**** Token $fCMToken');
    initPushNotifications();
    initLocalNotification();
  }

  // Future<void> initInAppMessage() async {
  //
  //   final fCMToken = await firebaseInAppMessage.app.;
  //   // await FirebaseMessaging.instance.subscribeToTopic('all');
  //   print('**** Token $fCMToken');
  // }

  Future<void> setupFlutterNotifications() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    // channel = const AndroidNotificationChannel(
    //   'high_importance_channel', // id
    //   'High Importance Notifications', // title
    //   description:
    //       'This channel is used for important notifications.', // description
    //   importance: Importance.high,
    // );

    var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    isFlutterLocalNotificationsInitialized = true;
  }
}
