import 'package:dartz/dartz.dart';
import 'package:rideme_driver/core/usecase/usecase.dart';
import 'package:rideme_driver/features/informationResources/domain/repository/information_resources_repository.dart';

class GetAllVehicleColors extends UseCases {
  final InformationResourcesRepository repository;

  GetAllVehicleColors({required this.repository});
  @override
  Future<Either<String, dynamic>> call(params) async =>
      await repository.getAllVehicleColors(params);
}
