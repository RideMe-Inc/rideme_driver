import 'package:rideme_driver/features/authentication/domain/entity/init_auth_data.dart';
import 'package:rideme_driver/features/authentication/domain/entity/init_auth_info.dart';

class InitAuthInfoModel extends InitAuthInfo {
  const InitAuthInfoModel({
    required super.message,
    required super.userExists,
    required super.hasPassword,
    required super.authData,
  });

  factory InitAuthInfoModel.fromJson(Map<String, dynamic> json) {
    return InitAuthInfoModel(
      message: json['message'],
      userExists: json['user_exist'],
      hasPassword: json['has_password'],
      authData: InitAuthDataModel.fromJson(json['data']),
    );
  }
}

class InitAuthDataModel extends InitAuthData {
  const InitAuthDataModel({
    required super.token,
  });

  factory InitAuthDataModel.fromJson(Map<String, dynamic>? json) {
    return InitAuthDataModel(
      token: json?['token'],
    );
  }
}
