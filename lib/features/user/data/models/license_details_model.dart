import 'package:rideme_driver/features/user/domain/entities/license_details.dart';

class LicenseDetailsModel extends LicenseDetails {
  const LicenseDetailsModel({
    required super.number,
    required super.fontImage,
    required super.backImage,
    required super.expiry,
    required super.status,
    required super.approvedAt,
    required super.id,
  });

  //fromJson
  factory LicenseDetailsModel.fromJson(Map<String, dynamic>? json) {
    return LicenseDetailsModel(
      number: json?['number'],
      fontImage: json?['front_image'],
      backImage: json?['back_image'],
      expiry: json?['expiry'],
      status: json?['status'],
      approvedAt: json?['approved_at'],
      id: json?['id'],
    );
  }
}
