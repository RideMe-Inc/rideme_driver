import 'package:dartz/dartz.dart';
import 'package:rideme_driver/core/usecase/usecase.dart';
import 'package:rideme_driver/features/user/domain/entities/user.dart';
import 'package:rideme_driver/features/user/domain/repositories/user_repository.dart';

class EditProfile extends UseCases<User, Map<String, dynamic>> {
  final UserRepository repository;

  EditProfile({required this.repository});
  @override
  Future<Either<String, User>> call(Map<String, dynamic> params) async =>
      await repository.editProfile(params);
}
