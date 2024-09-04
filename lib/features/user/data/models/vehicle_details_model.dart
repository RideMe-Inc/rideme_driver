import 'package:rideme_driver/features/user/domain/entities/vehicle_details.dart';

class VehicleDetailsModel extends VehicleDetails {
  const VehicleDetailsModel({
    required super.vehicleBrand,
    required super.vehicleType,
    required super.registerNumber,
    required super.roadWorthyExpiry,
    required super.vehicleInsuranceExpiry,
    required super.approvedAt,
    required super.status,
    required super.id,
    required super.vehicleBrandId,
    required super.insuranceImage,
    required super.roadWorthyImage,
  });

  //fromJson
  factory VehicleDetailsModel.fromJson(Map<String, dynamic>? json) {
    return VehicleDetailsModel(
      vehicleBrand: json?['brand'],
      vehicleType: json?['type'],
      registerNumber: json?['registration_number'],
      roadWorthyExpiry: json?['road_worthy_expiry'],
      vehicleInsuranceExpiry: json?['insurance_expiry'],
      approvedAt: json?['approved_at'],
      status: json?['status'],
      id: json?['id'],
      vehicleBrandId: json?['brand_id'],
      insuranceImage: json?['insurance_image'],
      roadWorthyImage: json?['road_worthy_image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'brand': vehicleBrand,
        'type': vehicleType,
        'registration_number': registerNumber,
        'road_worthy_expiry': roadWorthyExpiry,
        'insurance_expiry': vehicleInsuranceExpiry,
        'approved_at': approvedAt,
        'status': status,
        'id': id,
        'brand_id': vehicleBrandId,
        'insurance_image': insuranceImage,
        'road_worthy_image': roadWorthyImage,
      };
}
