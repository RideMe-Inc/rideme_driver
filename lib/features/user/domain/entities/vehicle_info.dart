import 'package:equatable/equatable.dart';
import 'package:rideme_driver/core/pagination/pagination_entity.dart';
import 'package:rideme_driver/features/user/domain/entities/vehicle_details.dart';

class AllVehiclesInfo extends Equatable {
  final VehicleDetails? allVehicles;
  final Pagination? pagination;

  const AllVehiclesInfo({required this.allVehicles, required this.pagination});

  @override
  List<Object?> get props => [allVehicles, pagination];
}
