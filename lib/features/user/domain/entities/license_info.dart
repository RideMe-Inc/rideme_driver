import 'package:equatable/equatable.dart';
import 'package:rideme_driver/features/user/domain/entities/license_details.dart';

class LicenseInfo extends Equatable {
  final String? message;
  final LicenseDetails? licenseDetails;

  const LicenseInfo({
    required this.message,
    required this.licenseDetails,
  });
  @override
  List<Object?> get props => [
        message,
        licenseDetails,
      ];
}
