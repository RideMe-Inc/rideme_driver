import 'package:dartz/dartz.dart';

import 'package:rideme_driver/core/usecase/usecase.dart';
import 'package:rideme_driver/features/user/domain/entities/user.dart';
import 'package:rideme_driver/features/user/domain/repositories/user_repository.dart';

class ChangeAvailability extends UseCases<User, Map<String, dynamic>> {
  final UserRepository repository;

  ChangeAvailability({required this.repository});

  @override
  Future<Either<String, User>> call(params) async {
    return await repository.changeAvailability(params);
  }
}
