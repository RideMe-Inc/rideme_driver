import 'package:equatable/equatable.dart';
import 'package:rideme_driver/features/authentication/domain/entity/init_auth_data.dart';

class InitAuthInfo extends Equatable {
  final String? message;
  final bool? userExists, hasPassword;
  final InitAuthData? authData;

  const InitAuthInfo({
    required this.message,
    required this.userExists,
    required this.hasPassword,
    required this.authData,
  });

  @override
  List<Object?> get props => [
        message,
        userExists,
        hasPassword,
        authData,
      ];
}
