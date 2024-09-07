import 'package:rideme_driver/features/trips/domain/entities/trip_request_info.dart';

class TripRequestInfoModel extends TripRequestInfo {
  TripRequestInfoModel({
    required super.pickupAddress,
    required super.riderName,
    required super.pickupLng,
    required super.pickupLat,
    required super.rating,
    required super.polyline,
    required super.id,
    required super.distanceToPickup,
    required super.timeToPickup,
  });

  //fromJson
  factory TripRequestInfoModel.fromJson(Map<String, dynamic> json) =>
      TripRequestInfoModel(
        pickupAddress: json['pickup_address'],
        riderName: json['rider_name'],
        pickupLng: json['pickup_lng'],
        pickupLat: json['pickup_lat'],
        rating: json['rider_rating'],
        id: json['trip_id'],
        polyline: json['polyline'],
        timeToPickup: json['time_to_pickup'],
        distanceToPickup: json['distance_to_pickup'],
      );
}
