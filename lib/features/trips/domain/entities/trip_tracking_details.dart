import 'package:rideme_driver/core/location/domain/entity/geo_hash.dart';

class TripTrackingDetails {
  final num? id,
      amountCharged,
      temperature,
      discountAmount,
      amountPaid,
      totalStops,
      completedStopsCount,
      amountDue,
      totalAmount,
      extraFees,
      pickupLat,
      pickupLng,
      pickupGeoDataId,
      waitingPenalty;
  final String? trackingNumber,
      paymentStatus,
      pickupAddress,
      status,
      completedAt,
      paymentMethod,
      createdAt,
      polyline;

  final bool? music, conversation;
  final GeoData? nextStop;
  final RiderInfo user;

  const TripTrackingDetails(
      {required this.id,
      required this.amountCharged,
      required this.temperature,
      required this.discountAmount,
      required this.amountPaid,
      required this.totalStops,
      required this.completedStopsCount,
      required this.amountDue,
      required this.totalAmount,
      required this.extraFees,
      required this.pickupLat,
      required this.pickupLng,
      required this.pickupGeoDataId,
      required this.waitingPenalty,
      required this.trackingNumber,
      required this.paymentStatus,
      required this.pickupAddress,
      required this.status,
      required this.completedAt,
      required this.paymentMethod,
      required this.createdAt,
      required this.polyline,
      required this.music,
      required this.conversation,
      required this.nextStop,
      required this.user});
}

class RiderInfo {
  final String name;
  final num id, lat, lng;

  const RiderInfo({
    required this.name,
    required this.id,
    required this.lat,
    required this.lng,
  });
}
