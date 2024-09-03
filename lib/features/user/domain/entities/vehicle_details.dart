import 'package:equatable/equatable.dart';

class VehicleDetails extends Equatable {
  final String? vehicleBrand,
      vehicleType,
      registerNumber,
      roadWorthyExpiry,
      vehicleInsuranceExpiry,
      insuranceImage,
      roadWorthyImage,
      approvedAt,
      status;

  final int? id, vehicleBrandId;

  const VehicleDetails({
    required this.insuranceImage,
    required this.roadWorthyImage,
    required this.vehicleBrand,
    required this.vehicleType,
    required this.registerNumber,
    required this.roadWorthyExpiry,
    required this.vehicleInsuranceExpiry,
    required this.approvedAt,
    required this.status,
    required this.id,
    required this.vehicleBrandId,
  });

  Map<String, dynamic> toMap() => {
        'brand': vehicleBrand,
        'type': vehicleType,
        'register_number': registerNumber,
        'road_worthy_expiry': roadWorthyExpiry,
        'insurance_expiry': vehicleInsuranceExpiry,
        'approved_at': approvedAt,
        'status': status,
        'id': id,
        'brand_id': vehicleBrandId,
        'insurance_image': insuranceImage,
        'road_worthy_image': roadWorthyImage,
      };

  @override
  List<Object?> get props => [
        vehicleBrand,
        vehicleType,
        status,
        registerNumber,
        roadWorthyExpiry,
        vehicleBrandId,
        approvedAt,
        id,
      ];
}
