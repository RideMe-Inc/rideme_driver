import 'package:dartz/dartz.dart';
import 'package:rideme_driver/core/usecase/usecase.dart';
import 'package:rideme_driver/features/authentication/domain/entity/authentication.dart';
import 'package:rideme_driver/features/authentication/domain/repository/authentication_repository.dart';

class SignUp extends UseCases<Authentication, Map<String, dynamic>> {
  final AuthenticationRepository repository;

  SignUp({required this.repository});
  @override
  Future<Either<String, Authentication>> call(
      Map<String, dynamic> params) async {
    return await repository.signUp(params);
  }
}
