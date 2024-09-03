import 'package:dartz/dartz.dart';
import 'package:rideme_driver/features/user/domain/entities/license_info.dart';
import 'package:rideme_driver/features/user/domain/entities/profile_info.dart';
import 'package:rideme_driver/features/user/domain/entities/rider_vehicle.dart';
import 'package:rideme_driver/features/user/domain/entities/support_data.dart';
import 'package:rideme_driver/features/user/domain/entities/user.dart';

abstract class UserRepository {
  //get user profile
  Future<Either<String, User>> getUserProfile(Map<String, dynamic> params);

  //delete account
  Future<Either<String, String>> deleteAccount(Map<String, dynamic> params);

  // edit profile
  Future<Either<String, User>> editProfile(Map<String, dynamic> params);

  //GET ALL LICENSE
  Future<Either<String, LicenseInfo>> getAllLicense(
      Map<String, dynamic> params);

//CREATE DRIVER LICENSE
  Future<Either<String, LicenseInfo>> createDriverLicense(
    Map<String, dynamic> params,
  );

//EDIT DRIVER LICENSE
  Future<Either<String, LicenseInfo>> editDriverLicense(
    Map<String, dynamic> params,
  );

  /// change availability params

  Future<Either<String, ProfileInfo>> changeAvailability(
      Map<String, dynamic> params);

  ///get cached user
  Future<Either<String, User>> getCachedUser();

  ///get cached user without safety
  User getCachedUserWithoutSafety();

  ///get

  ///update cached user

  Future<Either<String, dynamic>> updateCachedUser(Map<String, dynamic> params);

  ///photo check
  Future<Either<String, ProfileInfo>> riderPhotoCheck(
      Map<String, dynamic> params);

  ///create rider vehicle with parameters

  Future<Either<String, RiderVehicleInfo>> createVehicle(
      Map<String, dynamic> params);

//edit rider vehicle

  Future<Either<String, RiderVehicleInfo>> editVehicle(
      Map<String, dynamic> params);

  Future<Either<String, RiderVehicleInfo>> getAllVehicles(
      Map<String, dynamic> params);

  //get support contacts
  Future<Either<String, SupportData>> getSupportContacts(
      Map<String, dynamic> params);
}
