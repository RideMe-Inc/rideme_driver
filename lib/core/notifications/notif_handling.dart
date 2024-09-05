import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//handle notification
Future handleNotification({
  required RemoteMessage message,
  required BuildContext context,
  required bool isInForeground,
  bool isTapped = false,
}) async {
  RemoteNotification? notification = message.notification;

  switch (message.data['event']) {
    //TODO: WORK ON THE RIGHT NOTIFICATION SETUPS HERE
    // case 'orders/assigned' ||
    //       'orders/cancelled' ||
    //       'orders/delivered' ||
    //       'orders/completed' ||
    //       'orders/updated' ||
    //       'orders/ready' ||
    //       'orders/dispatched' ||
    //       'orders/arriving':
    //   if (!isTapped) showNotification(notification);
    //   if (context.mounted) {
    //     context.goNamed(
    //       'orderDetails',
    //       queryParameters: {
    //         'service': message.data['service_type'],
    //         'orderId': message.data['order_id'],
    //         'message': message.notification?.body ?? '',
    //         'isFromPayment': 'false'
    //       },
    //     );
    //   }

    case 'trips/requested':
      //navigate to trip accept page
      if (!isTapped) showNotification(notification);

    case 'trips/assigned' || 'trips/started' || 'trips/updated':
      if (!isTapped) showNotification(notification);

    case 'trips/completed':
      if (!isTapped) showNotification(notification);

    case 'trips/ended':
      //navigate to rating page
      if (!isTapped) showNotification(notification);

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
