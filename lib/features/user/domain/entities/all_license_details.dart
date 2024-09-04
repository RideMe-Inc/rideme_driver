import 'package:equatable/equatable.dart';

import 'package:rideme_driver/core/pagination/pagination_entity.dart';
import 'package:rideme_driver/features/user/domain/entities/license_details.dart';

class AllLicenseDetails extends Equatable {
  final LicenseDetails licenseDetails;

  final Pagination? pagination;

  const AllLicenseDetails({
    required this.licenseDetails,
    required this.pagination,
  });

  @override
  List<Object?> get props => [
        licenseDetails,
        pagination,
      ];
}
