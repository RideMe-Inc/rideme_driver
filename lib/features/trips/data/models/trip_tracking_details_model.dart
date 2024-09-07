import 'package:rideme_driver/core/location/data/models/geo_hash_model.dart';
import 'package:rideme_driver/features/trips/domain/entities/trip_tracking_details.dart';

class TripTrackingDetailsModel extends TripTrackingDetails {
  TripTrackingDetailsModel(
      {required super.id,
      required super.amountCharged,
      required super.temperature,
      required super.discountAmount,
      required super.amountPaid,
      required super.totalStops,
      required super.completedStopsCount,
      required super.amountDue,
      required super.totalAmount,
      required super.extraFees,
      required super.pickupLat,
      required super.pickupLng,
      required super.pickupGeoDataId,
      required super.waitingPenalty,
      required super.trackingNumber,
      required super.paymentStatus,
      required super.pickupAddress,
      required super.status,
      required super.completedAt,
      required super.paymentMethod,
      required super.createdAt,
      required super.polyline,
      required super.music,
      required super.conversation,
      required super.nextStop,
      required super.user});

  //fromJson
  factory TripTrackingDetailsModel.fromJson(Map<String, dynamic> json) {
    return TripTrackingDetailsModel(
      pickupAddress: json['pickup_address'],
      pickupLat: json['pickup_lat'],
      pickupLng: json['pickup_lng'],
      id: json["id"],
      trackingNumber: json["tracking_number"],
      amountCharged: json["amount_charged"],
      discountAmount: json["discount_amount"],
      amountPaid: json["amount_paid"],
      amountDue: json["amount_due"],
      paymentStatus: json["payment_status"],
      status: json["status"],
      createdAt: json["created_at"],
      completedAt: json["completed_at"],
      paymentMethod: json["payment_method"],
      extraFees: json["extra_fees"],
      totalAmount: json["total_amount"],
      waitingPenalty: json["waiting_penalty"],
      polyline: json["polyline"],
      pickupGeoDataId: json['pickup_geo_data_id'],
      temperature: json['temperature'],
      totalStops: json['total_stops'],
      completedStopsCount: json['completed_stops_count'],
      music: json['music'],
      conversation: json['conversation'],
      nextStop: json['next_stop'] != null
          ? GeoDataModel.fromJson(json['next_stop'])
          : null,
      user: RiderInfoModel.fromJson(json['user']),
    );
  }
}

class RiderInfoModel extends RiderInfo {
  RiderInfoModel(
      {required super.name,
      required super.id,
      required super.lat,
      required super.lng});

  //fromJson
  factory RiderInfoModel.fromJson(Map<String, dynamic> json) => RiderInfoModel(
        name: json['name'],
        id: json['id'],
        lat: json['lat'],
        lng: json['lng'],
      );
}
