import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class PermissionsLocalDatasource {
  //notifications
  Future<PermissionStatus> requestNotificationPermission();

  //locations
  Future<PermissionStatus> requestLocationPermission();

  //app tracking
  Future<TrackingStatus> requestAllNecessaryPermissions();
}

class PermissionsLocalDatasourceImpl implements PermissionsLocalDatasource {
  final FirebaseMessaging messaging;

  PermissionsLocalDatasourceImpl({required this.messaging});

  //notifications

  @override
  Future<PermissionStatus> requestNotificationPermission() async =>
      await Permission.notification.request();

  //LOCATION

  @override
  Future<PermissionStatus> requestLocationPermission() async =>
      await Permission.location.request();

  //APP tracking transparency

  @override
  Future<TrackingStatus> requestAllNecessaryPermissions() async {
    if (Platform.isIOS) {
      await AppTrackingTransparency.requestTrackingAuthorization();

      final response =
          await AppTrackingTransparency.trackingAuthorizationStatus;

      return response;
    } else {
      return TrackingStatus.authorized;
    }
  }
}
