import 'package:rideme_driver/core/pagination/pagination_model.dart';
import 'package:rideme_driver/features/user/data/models/vehicle_details_model.dart';

import 'package:rideme_driver/features/user/domain/entities/all_rider_vehicles.dart';
import 'package:rideme_driver/features/user/domain/entities/vehicle_info.dart';

class AllRiderVehiclesModel extends AllRiderVehicles {
  const AllRiderVehiclesModel({
    required super.message,
    required super.allVehiclesInfo,
  });

  //fromJson

  factory AllRiderVehiclesModel.fromJson(Map<String, dynamic>? json) {
    return AllRiderVehiclesModel(
      message: json?['message'],
      allVehiclesInfo: json?['data'] != null
          ? AllVehicleInfoModel.fromJson(
              json?['data'],
            )
          : null,
    );
  }
}

class AllVehicleInfoModel extends AllVehiclesInfo {
  const AllVehicleInfoModel({
    required super.allVehicles,
    required super.pagination,
  });

  //fromJson

  factory AllVehicleInfoModel.fromJson(Map<String, dynamic> json) {
    return AllVehicleInfoModel(
      allVehicles: VehicleDetailsModel.fromJson(json["vehicle"]),
      pagination: PaginationModel.fromJson(json['pagination']),
    );
  }
}
