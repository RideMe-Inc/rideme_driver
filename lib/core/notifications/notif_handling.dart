import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/ios_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

//handle notification
Future handleNotification({
  required RemoteMessage message,
  required BuildContext? context,
  required bool isInForeground,
  bool isTapped = false,
}) async {
  RemoteNotification? notification = message.notification;

  AndroidOptions getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  final secureStorage = FlutterSecureStorage(
    aOptions: getAndroidOptions(),
  );

  switch (message.data['event']) {
    case 'trips/requested':

      //navigate to trip accept page
      if (!isTapped) showNotification(notification);

      if (isInForeground) {
        if (context!.mounted) {
          context.goNamed(
            'tripAcceptReject',
            queryParameters: {
              'tripinfo': message.data['extra'],
            },
          );
        }
      } else {
        if (context == null) {
          // const uuid = Uuid();
          await secureStorage.write(
              key: 'incoming_request', value: message.data['trip']);
          showCallNotification(notification, 'uuid.v4()');

          FlutterCallkitIncoming.onEvent.listen((CallEvent? event) async {
            switch (event?.event) {
              case Event.actionCallIncoming:
                break;
              case Event.actionCallAccept:
                break;

              case Event.actionCallDecline:
                await secureStorage.delete(key: 'incoming_request');
                break;

              default:
                break;
            }
          });
        } else {
          context.goNamed(
            'tripStatusCheck',
            queryParameters: {
              "tripData": message.data['extras'],
            },
          );
        }
      }

      break;

    // case 'trips/assigned' || 'trips/started' || 'trips/updated':
    //   if (!isTapped) showNotification(notification);
    //   if (!isInForeground) {
    //     if (context != null) {
    //       context.goNamed(
    //         'trackTrip',
    //         queryParameters: {
    //           "tripId": message.data['trip_id'],
    //         },
    //       );
    //     }
    //   }

    //   break;

    case 'trips/completed':
      if (!isTapped) showNotification(notification);
      break;

    case 'trips/cancelled':
      if (isTapped) showNotification(notification);

      if (isInForeground) {
        if (context != null) {
          context.goNamed(
            'home',
          );
        }
      }

      break;

    case 'trips/ended':

      //navigate to rating page
      if (!isTapped) showNotification(notification);
      break;

    default:
      showNotification(notification);
      break;
  }
}

//show notification
showNotification(RemoteNotification? notification) {
  FlutterLocalNotificationsPlugin().show(
    notification.hashCode,
    notification?.title,
    notification?.body,
    renderNotifDetails(),
  );
}

NotificationDetails renderNotifDetails() {
  return const NotificationDetails(
    android: AndroidNotificationDetails(
      "high_importance_channel",
      "High Importance Notifications",
      importance: Importance.max,
      priority: Priority.max,
      autoCancel: false,
    ),
  );
}

showCallNotification(RemoteNotification? notification, String uuid) async {
  const uuid = Uuid();
  CallKitParams callKitParams = CallKitParams(
    id: uuid.v4(),
    nameCaller: notification?.title ?? '',
    appName: 'RideMe Driver',
    // avatar: 'https://i.pravatar.cc/100',
    // handle: '0123456789',
    type: 0,
    textAccept: 'Accept Trip',
    textDecline: 'Decline',
    duration: 20000,
    missedCallNotification: null,

    android: const AndroidParams(
        isCustomNotification: true,
        isShowLogo: false,
        ringtonePath: 'system_ringtone_default',
        actionColor: '#4CAF50',
        textColor: '#ffffff',
        incomingCallNotificationChannelName: "Incoming Call",
        missedCallNotificationChannelName: "Missed Call",
        isShowCallID: false),
    ios: const IOSParams(
      handleType: 'generic',
      supportsVideo: false,
      maximumCallGroups: 2,
      maximumCallsPerCallGroup: 1,
      audioSessionMode: 'default',
      audioSessionActive: true,
      audioSessionPreferredSampleRate: 44100.0,
      audioSessionPreferredIOBufferDuration: 0.005,
      supportsDTMF: true,
      supportsHolding: true,
      supportsGrouping: false,
      supportsUngrouping: false,
    ),
  );
  await FlutterCallkitIncoming.showCallkitIncoming(callKitParams);
}
