import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:dartz/dartz.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:rideme_driver/features/permissions/data/datasources/localds.dart';
import 'package:rideme_driver/features/permissions/domain/repository/permissions_repo.dart';

class PermissionsRepositoryImpl implements PermissionsRepository {
  final PermissionsLocalDatasource localDatasource;

  PermissionsRepositoryImpl({required this.localDatasource});

  //!notifications
  @override
  Future<Either<String, PermissionStatus>>
      requestNotificationPermission() async {
    try {
      final response = await localDatasource.requestNotificationPermission();

      return Right(response);
    } catch (e) {
      return const Left("An error occured");
    }
  }

  //!locations

  @override
  Future<Either<String, PermissionStatus>> requestLocationPermission() async {
    try {
      final response = await localDatasource.requestLocationPermission();

      return Right(response);
    } catch (e) {
      return const Left("An error occured");
    }
  }

  //!app transparency

  @override
  Future<Either<String, TrackingStatus>>
      requestAllNecessaryPermissions() async {
    try {
      final response = await localDatasource.requestAllNecessaryPermissions();
      await localDatasource.requestNotificationPermission();
      await localDatasource.requestLocationPermission();

      return Right(response);
    } catch (e) {
      return const Left("An error occured");
    }
  }
}
