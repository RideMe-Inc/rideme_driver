import 'dart:convert';

import 'package:rideme_driver/features/user/data/models/user_model.dart';
import 'package:rideme_driver/features/user/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDatasource {
  //cache rider id
  cacheRiderId(int id);

  //remove rider id

  removeRiderId();
  // cache user information
  Future cacheUserInfo(User user);

  //get rider information

  Future<UserModel> getUserInfo();

  //get user information without safety
  UserModel getUserInfoWithoutSafety();

  //update user information
  Future updateUserInfo(Map<String, dynamic> params);
}

class UserLocalDatasourceImpl implements UserLocalDatasource {
  final SharedPreferences sharedPreferences;
  final String cacheKey = 'USER_CACHE_KEY';

  UserLocalDatasourceImpl({
    required this.sharedPreferences,
  });

  //! CACHE USER INFO
  @override
  Future cacheUserInfo(User user) {
    final jsonString = jsonEncode(user.toMap());

    return sharedPreferences.setString(cacheKey, jsonString);
  }

  //! GET RIDER INFORMATION
  @override
  Future<UserModel> getUserInfo() async {
    final jsonString = sharedPreferences.getString(cacheKey);

    if (jsonString != null) {
      return UserModel.fromJson(json.decode(jsonString));
    } else {
      throw Exception('Cache Error');
    }
  }

  //! UPDATE RIDER INFORMATION
  @override
  Future updateUserInfo(Map<String, dynamic> params) async {
    final jsonString = sharedPreferences.getString(cacheKey);

    if (jsonString == null) throw Exception('Cache Error');

    final decodedString = json.decode(jsonString) as Map<String, dynamic>;

    decodedString.addAll(params);

    final encodedString = jsonEncode(decodedString);

    return sharedPreferences.setString(cacheKey, encodedString);
  }

  //!GET RIDER INFO WITHOUT SAFETY

  @override
  UserModel getUserInfoWithoutSafety() {
    final jsonString = sharedPreferences.getString(cacheKey);

    if (jsonString != null) {
      return UserModel.fromJson(json.decode(jsonString));
    } else {
      throw Exception('Cache Error');
    }
  }

  @override
  cacheRiderId(int id) {
    return sharedPreferences.setInt('rider_id_cache', id);
  }

  @override
  removeRiderId() async {
    return await sharedPreferences.remove('rider_id_cache');
  }
}
