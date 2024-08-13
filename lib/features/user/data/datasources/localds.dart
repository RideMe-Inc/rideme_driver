import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:rideme_driver/features/user/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDatasource {
  // cache user information
  Future cacheUserInfo(User user);
}

class UserLocalDatasourceImpl implements UserLocalDatasource {
  final SharedPreferences sharedPreferences;
  final String cacheKey = 'USER_CACHE_KEY';
  final ImagePicker imagePicker;

  UserLocalDatasourceImpl({
    required this.sharedPreferences,
    required this.imagePicker,
  });

  //! CACHE USER INFO
  @override
  Future cacheUserInfo(User user) {
    final jsonString = jsonEncode(user.toMap());

    return sharedPreferences.setString(cacheKey, jsonString);
  }
}
