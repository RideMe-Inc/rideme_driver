import 'package:dartz/dartz.dart';
import 'package:rideme_driver/core/network/networkinfo.dart';
import 'package:rideme_driver/features/informationResources/data/datasource/remoteds.dart';
import 'package:rideme_driver/features/informationResources/domain/entity/information_resource.dart';

import 'package:rideme_driver/features/informationResources/domain/entity/vehicle_makes.dart';
import 'package:rideme_driver/features/informationResources/domain/repository/information_resources_repository.dart';

class InformationResourcesRepositoryImpl
    implements InformationResourcesRepository {
  final NetworkInfo networkInfo;
  final InformationResourcesRemoteDatastore remoteDatastore;

  InformationResourcesRepositoryImpl({
    required this.networkInfo,
    required this.remoteDatastore,
  });

  //!GET COMPANIES
  @override
  Future<Either<String, List<VehicleMakes>>> getAllVehicleMakes(
      Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetowrkMessage);
    }

    try {
      final response = await remoteDatastore.getAllVehicleMakes(params);

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<InformationResource>>> getAllVehicleColors(
      Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetowrkMessage);
    }

    try {
      final response = await remoteDatastore.getAllVehicleColors(params);

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
