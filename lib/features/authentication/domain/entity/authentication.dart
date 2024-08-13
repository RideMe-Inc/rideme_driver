import 'package:equatable/equatable.dart';
import 'package:rideme_driver/features/authentication/domain/entity/authorization.dart';
import 'package:rideme_driver/features/user/domain/entities/user.dart';

class Authentication extends Equatable {
  final String? message;
  final Authorization? authorization;
  final User? user;

  const Authentication({
    required this.message,
    required this.authorization,
    required this.user,
  });

  @override
  List<Object?> get props => [
        message,
        authorization,
        user,
      ];
}
