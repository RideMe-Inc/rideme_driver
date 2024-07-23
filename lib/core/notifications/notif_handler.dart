import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rideme_driver/core/notifications/notif_handling.dart';

class PushNotificationHandler {
  final BuildContext context;
  final FlutterLocalNotificationsPlugin localNotificationsPlugin;
  final FirebaseMessaging messaging;

  PushNotificationHandler(
      {required this.context,
      required this.localNotificationsPlugin,
      required this.messaging}) {
    //INITIALIZE NOTIFICATION DEPENDENCY ON CONSTRUCTOR CREATION
    initializeNotifDep();
  }

  //intialize

  Future initializeNotifDep() async {
    try {
      await initNotifs();

      await setForegroundNotificationOptions();
      setFirebaseMessageHandlers();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //init Notif

  Future initNotifs() async {
    await localNotificationsPlugin.initialize(
      const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
          iOS: DarwinInitializationSettings(
            requestProvisionalPermission: true,
            requestCriticalPermission: true,
          )),
    );
  }

  //foreground notification options
  Future setForegroundNotificationOptions() async {
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  //onMessageHandler

  _onMessageHandler({required RemoteMessage message}) {
    localNotificationsPlugin.cancelAll();
    handleNotification(
        message: message, context: context, isInForeground: true);
  }

  //onMessageOpenHandler
  _onMessageOpenedAppHandler({required RemoteMessage message}) {
    localNotificationsPlugin.cancelAll();
    handleNotification(
      message: message,
      context: context,
      isInForeground: false,
      isTapped: true,
    );
  }

  //firebase message handlers
  setFirebaseMessageHandlers() {
    FirebaseMessaging.onMessage
        .listen((event) => _onMessageHandler(message: event));

    FirebaseMessaging.onMessageOpenedApp
        .listen((event) => _onMessageOpenedAppHandler(message: event));

    messaging.getInitialMessage().then((message) => message != null
        ? handleNotification(
            message: message, context: context, isInForeground: false)
        : null);
  }
}
