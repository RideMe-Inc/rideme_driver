import 'package:dartz/dartz.dart';
import 'package:rideme_driver/core/usecase/usecase.dart';
import 'package:rideme_driver/features/authentication/domain/entity/authorization.dart';
import 'package:rideme_driver/features/authentication/domain/repository/authentication_repository.dart';

class RecoverToken extends UseCases<Authorization, NoParams> {
  final AuthenticationRepository repository;

  RecoverToken({required this.repository});

  @override
  Future<Either<String, Authorization>> call(NoParams params) async {
    return await repository.recoverToken();
  }
}
