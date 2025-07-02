import 'package:dartz/dartz.dart';
import 'package:rideme_driver/core/usecase/usecase.dart';
import 'package:rideme_driver/features/user/domain/entities/driver_object.dart';
import 'package:rideme_driver/features/user/domain/repositories/user_repository.dart';

class GetUserProfile extends UseCases<DriverObject, Map<String, dynamic>> {
  final UserRepository repository;

  GetUserProfile({required this.repository});
  @override
  Future<Either<String, DriverObject>> call(
          Map<String, dynamic> params) async =>
      await repository.getUserProfile(params);
}
