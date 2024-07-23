import 'package:dartz/dartz.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rideme_driver/core/usecase/usecase.dart';
import 'package:rideme_driver/features/permissions/domain/repository/permissions_repo.dart';

class RequestNotificationPermission
    extends UseCases<PermissionStatus, NoParams> {
  final PermissionsRepository repository;

  RequestNotificationPermission({required this.repository});
  @override
  Future<Either<String, PermissionStatus>> call(NoParams params) async {
    return await repository.requestNotificationPermission();
  }
}
