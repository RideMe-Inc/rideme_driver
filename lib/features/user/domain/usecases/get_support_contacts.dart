import 'package:dartz/dartz.dart';
import 'package:rideme_driver/core/usecase/usecase.dart';
import 'package:rideme_driver/features/user/domain/entities/support_data.dart';
import 'package:rideme_driver/features/user/domain/repositories/user_repository.dart';

class GetSupportContacts extends UseCases<SupportData, Map<String, dynamic>> {
  final UserRepository repository;

  GetSupportContacts({required this.repository});
  @override
  Future<Either<String, SupportData>> call(Map<String, dynamic> params) async =>
      await repository.getSupportContacts(params);
}
