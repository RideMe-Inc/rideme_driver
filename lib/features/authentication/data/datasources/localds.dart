import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rideme_driver/features/authentication/data/model/authorization_model.dart';
import 'package:rideme_driver/features/authentication/domain/entity/authorization.dart';

abstract class AuthenticationLocalDatasource {
  // cache authorization data
  Future cacheAuthorizationData(Authorization authorization);

  // get cached authorization data
  Future<AuthorizationModel> getCachedAuthorizationData();

  //clear authorization cache
  Future<bool> clearAuthorizationCache();
}

class AuthenticationLocalDatasourceImpl
    implements AuthenticationLocalDatasource {
  final FlutterSecureStorage secureStorage;
  final String cacheKey = 'AUTHORIZATION_CACHE_KEY';

  AuthenticationLocalDatasourceImpl({
    required this.secureStorage,
  });

  //! CACHE AUTHORIZATION DATA
  @override
  Future cacheAuthorizationData(Authorization authorization) async {
    final jsonString = jsonEncode(authorization.toMap());
    await secureStorage.write(key: cacheKey, value: jsonString);

    return true;
  }

  //! GET CACHED AUTHORIZATION DATA
  @override
  Future<AuthorizationModel> getCachedAuthorizationData() async {
    final jsonString = await secureStorage.read(key: cacheKey);

    if (jsonString == null) {
      throw Exception('Cache Error');
    }

    return AuthorizationModel.fromJson(json.decode(jsonString));
  }

  //!CLEAR AUTHORIZATION CACHE

  @override
  Future<bool> clearAuthorizationCache() async {
    await secureStorage.delete(key: cacheKey);
    return true;
  }
}
