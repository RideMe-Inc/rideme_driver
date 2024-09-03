import 'package:dartz/dartz.dart';
import 'package:rideme_driver/core/usecase/usecase.dart';
import 'package:rideme_driver/features/user/domain/entities/license_info.dart';

import 'package:rideme_driver/features/user/domain/repositories/user_repository.dart';

class CreateDriverLicense extends UseCases<LicenseInfo, Map<String, dynamic>> {
  final UserRepository repository;

  CreateDriverLicense({required this.repository});

  @override
  Future<Either<String, LicenseInfo>> call(Map<String, dynamic> params) async {
    return await repository.createDriverLicense(params);
  }
}
