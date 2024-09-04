import 'package:equatable/equatable.dart';

import 'all_trips_data.dart';

class AllTripsInfo extends Equatable {
  final String? message;
  final AllTripsData? allTripsData;

  const AllTripsInfo({required this.message, required this.allTripsData});

  @override
  List<Object?> get props => [message, allTripsData];
}