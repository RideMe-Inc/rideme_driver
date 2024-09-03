import 'package:dartz/dartz.dart';
import 'package:rideme_driver/features/informationResources/domain/entity/information_resource.dart';

abstract class InformationResourcesRepository {
  ///get all companies
  Future<Either<String, List<InformationResource>>> getAllVehicleModels(
      Map<String, dynamic> params);

  ///get all vehicle brands
  Future<Either<String, List<InformationResource>>> getAllVehicleMakes(
      Map<String, dynamic> params);
}
