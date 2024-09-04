import 'package:equatable/equatable.dart';
import 'package:rideme_driver/features/user/domain/entities/vehicle_info.dart';

class AllRiderVehicles extends Equatable {
  final String? message;
  final AllVehiclesInfo? allVehiclesInfo;

  const AllRiderVehicles(
      {required this.message, required this.allVehiclesInfo});

  @override
  List<Object?> get props => [message, allVehiclesInfo];
}
