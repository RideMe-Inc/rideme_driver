import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:dartz/dartz.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class PermissionsRepository {
  //notifications
  Future<Either<String, PermissionStatus>> requestNotificationPermission();

  //locations
  Future<Either<String, PermissionStatus>> requestLocationPermission();

  //app tracking transparency
  Future<Either<String, TrackingStatus>> requestAllNecessaryPermissions();
}
