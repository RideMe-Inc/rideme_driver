import 'package:rideme_driver/features/informationResources/domain/entity/vehicle_makes.dart';

class VehicleMakesModel extends VehicleMakes {
  const VehicleMakesModel(
      {required super.name, required super.id, required super.models});

//fromJson

  factory VehicleMakesModel.fromJson(Map<String, dynamic> json) =>
      VehicleMakesModel(
        name: json['name'],
        id: json['id'],
        models: json["models"] != null
            ? json['models']
                .map<VehicleMakesModel>((e) => VehicleMakesModel.fromJson(e))
                .toList()
            : null,
      );
}
