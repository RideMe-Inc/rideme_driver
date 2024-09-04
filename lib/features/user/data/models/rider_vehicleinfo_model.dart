import 'package:rideme_driver/features/user/domain/entities/rider_vehicle.dart';

import 'vehicle_details_model.dart';

class RiderVehicleInfoModel extends RiderVehicleInfo {
  const RiderVehicleInfoModel({
    required super.message,
    required super.vehicleDetails,
  });

  //fromJson
  factory RiderVehicleInfoModel.fromJson(Map<String, dynamic>? json) {
    return RiderVehicleInfoModel(
      message: json?["message"],
      vehicleDetails: VehicleDetailsModel.fromJson(
        json?["vehicle"],
      ),
    );
  }
}
