import 'package:rideme_driver/features/authentication/domain/entity/authorization.dart';

class AuthorizationModel extends Authorization {
  const AuthorizationModel({
    required super.token,
    required super.type,
    required super.refreshTtl,
    required super.ttl,
  });

  factory AuthorizationModel.fromJson(Map<String, dynamic>? json) {
    return AuthorizationModel(
      token: json?['token'],
      type: json?['type'],
      refreshTtl: json?['refresh_ttl'],
      ttl: json?['ttl'],
    );
  }
}
