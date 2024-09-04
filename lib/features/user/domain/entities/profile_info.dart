import 'package:equatable/equatable.dart';

import 'package:rideme_driver/features/user/domain/entities/user.dart';

class ProfileInfo extends Equatable {
  final String? message;
  final User? rider;

  const ProfileInfo({required this.message, required this.rider});

  @override
  List<Object?> get props => [message, rider];
}
