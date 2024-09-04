import 'package:dartz/dartz.dart';
import 'package:rideme_driver/core/usecase/usecase.dart';

import 'package:rideme_driver/features/informationResources/domain/entity/vehicle_makes.dart';
import 'package:rideme_driver/features/informationResources/domain/repository/information_resources_repository.dart';

class GetAllVehicleMakes
    extends UseCases<List<VehicleMakes>, Map<String, dynamic>> {
  final InformationResourcesRepository repository;

  GetAllVehicleMakes({required this.repository});

  @override
  Future<Either<String, List<VehicleMakes>>> call(
      Map<String, dynamic> params) async {
    return await repository.getAllVehicleMakes(params);
  }
}
