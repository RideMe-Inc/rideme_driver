import 'package:dartz/dartz.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rideme_driver/core/usecase/usecase.dart';
import 'package:rideme_driver/features/permissions/domain/repository/permissions_repo.dart';

class RequestLocationPermission extends UseCases<PermissionStatus, NoParams> {
  final PermissionsRepository repository;

  RequestLocationPermission({required this.repository});
  @override
  Future<Either<String, PermissionStatus>> call(NoParams params) async {
    return await repository.requestLocationPermission();
  }
}
