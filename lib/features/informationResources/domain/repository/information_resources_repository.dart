import 'package:dartz/dartz.dart';
import 'package:rideme_driver/features/informationResources/domain/entity/information_resource.dart';

import 'package:rideme_driver/features/informationResources/domain/entity/vehicle_makes.dart';

abstract class InformationResourcesRepository {
  ///get all vehicle brands
  Future<Either<String, List<VehicleMakes>>> getAllVehicleMakes(
      Map<String, dynamic> params);

  // get all colors
  Future<Either<String, List<InformationResource>>> getAllVehicleColors(
      Map<String, dynamic> params);
}
