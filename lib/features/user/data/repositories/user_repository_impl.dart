import 'package:dartz/dartz.dart';
import 'package:rideme_driver/core/exceptions/generic_exception_class.dart';
import 'package:rideme_driver/core/network/networkinfo.dart';
import 'package:rideme_driver/features/user/data/datasources/localds.dart';
import 'package:rideme_driver/features/user/data/datasources/remoteds.dart';
import 'package:rideme_driver/features/user/domain/entities/license_info.dart';
import 'package:rideme_driver/features/user/domain/entities/profile_info.dart';
import 'package:rideme_driver/features/user/domain/entities/rider_vehicle.dart';
import 'package:rideme_driver/features/user/domain/entities/support_data.dart';
import 'package:rideme_driver/features/user/domain/entities/user.dart';
import 'package:rideme_driver/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final NetworkInfo networkInfo;
  final UserLocalDatasource localDatasource;
  final UserRemoteDatasource remoteDatasource;

  UserRepositoryImpl(
      {required this.networkInfo,
      required this.localDatasource,
      required this.remoteDatasource});

  @override
  Future<Either<String, User>> getUserProfile(
      Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetowrkMessage);
    }

    try {
      final response = await remoteDatasource.getUserProfile(params);
      return Right(response);
    } catch (e) {
      if (e is ErrorException) {
        return Left(e.toString());
      }

      return const Left('An error occured');
    }
  }

  //DELETE ACCOUNT
  @override
  Future<Either<String, String>> deleteAccount(
      Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.deleteAccount(params);

        return Right(response);
      } catch (e) {
        if (e is ErrorException) {
          return Left(e.toString());
        }

        return const Left('An error occured');
      }
    } else {
      return Left(networkInfo.noNetowrkMessage);
    }
  }

  //EDIT PROFILE

  @override
  Future<Either<String, User>> editProfile(Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.editProfile(params);

        return Right(response);
      } catch (e) {
        if (e is ErrorException) {
          return Left(e.toString());
        }

        return const Left('An error occured');
      }
    } else {
      return Left(networkInfo.noNetowrkMessage);
    }
  }

  @override
  Future<Either<String, LicenseInfo>> createDriverLicense(
      Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.createDriverLicense(params);
        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    } else {
      return Left(networkInfo.noNetowrkMessage);
    }
  }

  @override
  Future<Either<String, SupportData>> getSupportContacts(
      Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.getSupportContacts(params);

        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    } else {
      return Left(networkInfo.noNetowrkMessage);
    }
  }

  @override
  Future<Either<String, LicenseInfo>> getAllLicense(
      Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.getAllLicense(params);
        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    } else {
      return Left(networkInfo.noNetowrkMessage);
    }
  }

  // Change availability
  @override
  Future<Either<String, ProfileInfo>> changeAvailability(
      Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetowrkMessage);
    }

    try {
      final response = await remoteDatasource.changeAvailability(params);

      //cache rider info after updating profile information

      await localDatasource.cacheUserInfo(response.rider!);

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, User>> getCachedUser() async {
    try {
      final response = await localDatasource.getUserInfo();
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, dynamic>> updateCachedUser(
      Map<String, dynamic> params) async {
    try {
      final response = await localDatasource.updateUserInfo(params);

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  //GET CACHED USER WITHOUT SAFETY

  @override
  User getCachedUserWithoutSafety() {
    final response = localDatasource.getUserInfoWithoutSafety();

    return response;
  }

  //RIDER PHOTO CHECK

  @override
  Future<Either<String, ProfileInfo>> riderPhotoCheck(
      Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetowrkMessage);
    }

    try {
      final response = await remoteDatasource.riderPhotoCheck(params);

      //cache rider info after updating profile information

      await localDatasource.cacheUserInfo(response.rider!);

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  //EDIT DRIVER LICENSE

  @override
  Future<Either<String, LicenseInfo>> editDriverLicense(
      Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.editDriverLicense(params);
        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    } else {
      return Left(networkInfo.noNetowrkMessage);
    }
  }

  //Create or edit rider vehicle
  @override
  Future<Either<String, RiderVehicleInfo>> createVehicle(
      Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.createVehicle(params);

        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    } else {
      return Left(networkInfo.noNetowrkMessage);
    }
  }

// Get all vehicles
  @override
  Future<Either<String, RiderVehicleInfo>> getAllVehicles(
      Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.getAllVehicles(params);
        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    } else {
      return Left(networkInfo.noNetowrkMessage);
    }
  }

  @override
  Future<Either<String, RiderVehicleInfo>> editVehicle(
      Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.editVehicle(params);

        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    } else {
      return Left(networkInfo.noNetowrkMessage);
    }
  }

  @override
  cacheRiderId(int id) {
    return localDatasource.cacheRiderId(id);
  }
}
