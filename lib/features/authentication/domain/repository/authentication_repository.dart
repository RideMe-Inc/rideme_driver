import 'package:dartz/dartz.dart';
import 'package:rideme_driver/features/authentication/domain/entity/authentication.dart';
import 'package:rideme_driver/features/authentication/domain/entity/authorization.dart';
import 'package:rideme_driver/features/authentication/domain/entity/init_auth_info.dart';

abstract class AuthenticationRepository {
  Future<Either<String, InitAuthInfo>> initAuth(Map<String, dynamic> params);

  Future<Either<String, Authentication>> verifyOtp(Map<String, dynamic> params);

  Future<Either<String, Authentication>> signUp(Map<String, dynamic> params);

  Future<Either<String, Authorization>> getRefreshToken(
      Map<String, dynamic> params);

  Future<Either<String, Authorization>> recoverToken();

  Future<Either<String, String>> logOut(Map<String, dynamic> params);
}
