import 'package:rideme_driver/core/pagination/pagination_model.dart';
import 'package:rideme_driver/features/user/data/models/license_details_model.dart';
import 'package:rideme_driver/features/user/domain/entities/all_license_details.dart';
import 'package:rideme_driver/features/user/domain/entities/license_info.dart';

class LicenseInfoModel extends LicenseInfo {
  const LicenseInfoModel({
    required super.message,
    required super.licenseDetails,
  });

  //fromJson
  factory LicenseInfoModel.fromJson(Map<String, dynamic>? json) {
    return LicenseInfoModel(
      message: json?['message'],
      licenseDetails: LicenseDetailsModel.fromJson(
        json?['license'],
      ),
    );
  }
}

class AllLicenseDetailsModel extends AllLicenseDetails {
  const AllLicenseDetailsModel({
    required super.licenseDetails,
    required super.pagination,
  });

  //fromJson
  factory AllLicenseDetailsModel.fromJson(Map<String, dynamic> json) {
    return AllLicenseDetailsModel(
      licenseDetails: json['list']
          .map<LicenseDetailsModel>((e) => LicenseDetailsModel.fromJson(e))
          .toList(),
      pagination: PaginationModel.fromJson(
        json['pagination'],
      ),
    );
  }
}
