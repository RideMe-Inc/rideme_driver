import 'package:dartz/dartz.dart';
import 'package:rideme_driver/core/usecase/usecase.dart';
import 'package:rideme_driver/features/user/domain/repositories/user_repository.dart';
import 'package:rideme_driver/features/user/domain/entities/rider_vehicle.dart';

class GetAllRiderVehicles
    extends UseCases<RiderVehicleInfo, Map<String, dynamic>> {
  final UserRepository repository;

  GetAllRiderVehicles({required this.repository});

  @override
  Future<Either<String, RiderVehicleInfo>> call(
      Map<String, dynamic> params) async {
    return await repository.getAllVehicles(params);
  }
}
