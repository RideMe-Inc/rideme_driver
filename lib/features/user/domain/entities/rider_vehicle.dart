import 'package:equatable/equatable.dart';
import 'package:rideme_driver/features/user/domain/entities/vehicle_details.dart';

class RiderVehicleInfo extends Equatable {
  final String? message;
  final VehicleDetails? vehicleDetails;

  const RiderVehicleInfo({required this.message, required this.vehicleDetails});

  @override
  List<Object?> get props => [message, vehicleDetails];
}
