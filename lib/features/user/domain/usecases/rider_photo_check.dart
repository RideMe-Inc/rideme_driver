import 'package:dartz/dartz.dart';
import 'package:rideme_driver/core/usecase/usecase.dart';
import 'package:rideme_driver/features/user/domain/entities/profile_info.dart';
import 'package:rideme_driver/features/user/domain/repositories/user_repository.dart';

class RiderPhotoCheck extends UseCases<ProfileInfo, Map<String, dynamic>> {
  final UserRepository repository;

  RiderPhotoCheck({required this.repository});

  @override
  Future<Either<String, ProfileInfo>> call(Map<String, dynamic> params) async {
    return await repository.riderPhotoCheck(params);
  }
}
