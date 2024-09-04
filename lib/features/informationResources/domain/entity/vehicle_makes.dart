import 'package:equatable/equatable.dart';

class VehicleMakes extends Equatable {
  final String name;
  final int id;
  final List<VehicleMakes>? models;

  const VehicleMakes({
    required this.name,
    required this.id,
    required this.models,
  });
  @override
  List<Object?> get props => [id, name, models];
}
