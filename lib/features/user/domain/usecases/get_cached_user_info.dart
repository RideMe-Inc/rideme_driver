import 'package:dartz/dartz.dart';
import 'package:rideme_driver/core/usecase/usecase.dart';

import 'package:rideme_driver/features/user/domain/entities/user.dart';
import 'package:rideme_driver/features/user/domain/repositories/user_repository.dart';

class GetCachedUserInfo extends UseCases<User, NoParams> {
  final UserRepository repository;

  GetCachedUserInfo({required this.repository});
  @override
  Future<Either<String, User>> call(NoParams params) async {
    return await repository.getCachedUser();
  }
}
