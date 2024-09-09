import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_client/web_socket_client.dart';

void startBackgroundService() {
  final service = FlutterBackgroundService();
  service.startService();
}

void stopBackgroundService() {
  final service = FlutterBackgroundService();
  service.invoke("stop");
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
    androidConfiguration: AndroidConfiguration(
      autoStart: true,
      onStart: onStart,
      isForegroundMode: false,
      autoStartOnBoot: true,
    ),
  );
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  if (kDebugMode) print('ios background running');

  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  final socket = WebSocket(Uri.parse('wss://dss.rideme.app'));

  final sharedPreferences = await SharedPreferences.getInstance();
  int? riderId;

  socket.connection.listen(
    (event) {
      if (kDebugMode) {
        print(event);
      }

      if (event is Connected) {
        if (kDebugMode) print('CONNECTED');
      }

      if (event is Reconnected) {
        if (kDebugMode) print('CONNECTED');
      }
    },
  );

  Timer.periodic(const Duration(seconds: 3), (timer) async {
    riderId ??= sharedPreferences.getInt('rider_id_cache');

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
        forceAndroidLocationManager: true,
      );

      final params = {
        "event": "geo-update",
        "data": {
          "lat": position.latitude,
          "lng": position.longitude,
          "heading": position.heading,
          "driver_id": riderId ?? '',
        }
      };

      socket.send(jsonEncode(params));

      if (kDebugMode) {
        print('lat:${position.latitude}, lng:${position.longitude}');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  });
}

// @pragma('vm:entry-point')
// void onStart(ServiceInstance service) async {
//   final socket = WebSocket(Uri.parse('wss://dss.rideme.app'));
//   final location = Location();

//   final sharedPreferences = await SharedPreferences.getInstance();
//   int? riderId;

//   await for (final _ in Stream.periodic(const Duration(seconds: 5))) {
//     final serviceEnabled = await location.serviceEnabled();

//     if (serviceEnabled) {
//       break;
//     }
//   }

//   location.enableBackgroundMode(enable: true);

//   location.onLocationChanged.listen(
//     (event) {
//       print(event);
//       Timer.periodic(const Duration(seconds: 3), (timer) async {
//         riderId ??= sharedPreferences.getInt('rider_id_cache');

//         try {
//           final params = {
//             "event": "geo-update",
//             "data": {
//               "lat": event.latitude,
//               "lng": event.longitude,
//               "heading": event.heading,
//               "rider_id": riderId ?? '',
//             }
//           };

//           socket.send(jsonEncode(params));

//           if (kDebugMode) {
//             print('lat:${event.latitude}, lng:${event.longitude}');
//           }
//         } catch (e) {
//           if (kDebugMode) {
//             print(e);
//           }
//         }
//       });
//     },
//   );

//   // Timer.periodic(
//   //   const Duration(seconds: 3),
//   //   (timer) async {

//   //     return completer.future;
//   //   },
//   // );

//   // socket.connection.listen(
//   //   (event) {
//   //     if (kDebugMode) {
//   //       print(event);
//   //     }

//   //     if (event is Connected) {
//   //       if (kDebugMode) print('CONNECTED');
//   //     }

//   //     if (event is Reconnected) {
//   //       if (kDebugMode) print('CONNECTED');
//   //     }
//   //   },
//   // );

//   // Timer.periodic(const Duration(seconds: 3), (timer) async {
//   //   riderId ??= sharedPreferences.getInt('rider_id_cache');

//   //   try {
//   //     final position = await Geolocator.getCurrentPosition(
//   //       desiredAccuracy: LocationAccuracy.low,
//   //       forceAndroidLocationManager: true,
//   //     );

//   //     final params = {
//   //       "event": "geo-update",
//   //       "data": {
//   //         "lat": position.latitude,
//   //         "lng": position.longitude,
//   //         "heading": position.heading,
//   //         "rider_id": riderId ?? '',
//   //       }
//   //     };

//   //     socket.send(jsonEncode(params));

//   //     if (kDebugMode) {
//   //       print('lat:${position.latitude}, lng:${position.longitude}');
//   //     }
//   //   } catch (e) {
//   //     if (kDebugMode) {
//   //       print(e);
//   //     }
//   //   }
//   // });
// }
