import 'package:dartz/dartz.dart';
import 'package:rideme_driver/core/usecase/usecase.dart';
import 'package:rideme_driver/features/user/domain/repositories/user_repository.dart';

class UpdateCachedUser extends UseCases<dynamic, Map<String, dynamic>> {
  final UserRepository repository;

  UpdateCachedUser({required this.repository});
  @override
  Future<Either<String, dynamic>> call(Map<String, dynamic> params) async {
    return await repository.updateCachedUser(params);
  }
}
