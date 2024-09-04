import 'package:equatable/equatable.dart';
import 'package:rideme_driver/features/trips/domain/entities/trip_destination_data.dart';

class TripDetailsInfo extends Equatable {
  final String? message;
  final TripDetails? tripDestinationData;

  const TripDetailsInfo({
    required this.message,
    required this.tripDestinationData,
  });

  @override
  List<Object?> get props => [message, tripDestinationData];
}
