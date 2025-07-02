import 'package:rideme_driver/features/authentication/data/model/authorization_model.dart';
import 'package:rideme_driver/features/authentication/domain/entity/authentication.dart';
import 'package:rideme_driver/features/user/data/models/user_model.dart';

class AuthenticationModel extends Authentication {
  const AuthenticationModel({
    required super.message,
    required super.authorization,
    required super.user,
    required super.userExist,
  });

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) {
    return AuthenticationModel(
      message: json['message'],
      authorization: AuthorizationModel.fromJson(json['authorization']),
      user: UserModel.fromJson(json['user']),
      userExist: json['user_exist'],
    );
  }
}
