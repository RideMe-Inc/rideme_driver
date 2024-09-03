import 'package:dartz/dartz.dart';
import 'package:rideme_driver/core/usecase/usecase.dart';
import 'package:rideme_driver/features/user/domain/repositories/user_repository.dart';

class DeleteAccount extends UseCases<String, Map<String, dynamic>> {
  final UserRepository repository;

  DeleteAccount({required this.repository});
  @override
  Future<Either<String, String>> call(Map<String, dynamic> params) async =>
      await repository.deleteAccount(params);
}
