import 'package:dartz/dartz.dart';
import 'package:rideme_driver/core/exceptions/generic_exception_class.dart';
import 'package:rideme_driver/core/network/networkinfo.dart';
import 'package:rideme_driver/features/authentication/data/datasources/localds.dart';
import 'package:rideme_driver/features/authentication/data/datasources/remoteds.dart';
import 'package:rideme_driver/features/authentication/domain/entity/authentication.dart';
import 'package:rideme_driver/features/authentication/domain/entity/authorization.dart';
import 'package:rideme_driver/features/authentication/domain/entity/init_auth_info.dart';
import 'package:rideme_driver/features/authentication/domain/repository/authentication_repository.dart';
import 'package:rideme_driver/features/user/data/datasources/localds.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final NetworkInfo networkInfo;
  final UserLocalDatasource userLocalDatasource;
  final AuthenticationLocalDatasource localDatasource;
  final AuthenticationRemoteDatasource remoteDatasource;

  AuthenticationRepositoryImpl({
    required this.networkInfo,
    required this.userLocalDatasource,
    required this.localDatasource,
    required this.remoteDatasource,
  });
  // init auth
  @override
  Future<Either<String, InitAuthInfo>> initAuth(
      Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetowrkMessage);
    }

    try {
      final response = await remoteDatasource.initAuth(params);
      return Right(response);
    } catch (e) {
      if (e is ErrorException) {
        return Left(e.toString());
      }

      return const Left('An error occured');
    }
  }

// sign up
  @override
  Future<Either<String, Authentication>> signUp(
      Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetowrkMessage);
    }

    try {
      final response = await remoteDatasource.signUp(params);

      // cache authorization data
      await localDatasource.cacheAuthorizationData(response.authorization!);

      return Right(response);
    } catch (e) {
      if (e is ErrorException) {
        return Left(e.toString());
      }

      return const Left('An error occured');
    }
  }

// verify otp
  @override
  Future<Either<String, Authentication>> verifyOtp(
      Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetowrkMessage);
    }

    try {
      final response = await remoteDatasource.verifyOtp(params);

      // cache authorization data
      await localDatasource.cacheAuthorizationData(response.authorization!);

      return Right(response);
    } catch (e) {
      if (e is ErrorException) {
        return Left(e.toString());
      }

      return const Left('An error occured');
    }
  }

  //GET REFRESH TOKEN

  @override
  Future<Either<String, Authorization>> getRefreshToken(
      Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.getRefreshToken(params);

        // cache authorization token
        await localDatasource.cacheAuthorizationData(response);

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

  //RECOVER TOKEN

  @override
  Future<Either<String, Authorization>> recoverToken() async {
    try {
      final response = await localDatasource.getCachedAuthorizationData();

      return Right(response);
    } catch (e) {
      if (e is ErrorException) {
        return Left(e.toString());
      }

      return const Left('An error occured');
    }
  }

  //LOG OUT

  @override
  Future<Either<String, String>> logOut(Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.logOut(params);

        // cache authorization token
        await localDatasource.clearAuthorizationCache();

        //remove user id cache
        await userLocalDatasource.removeRiderId();

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
}
