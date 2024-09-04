import 'package:equatable/equatable.dart';
import 'package:rideme_driver/features/trips/domain/entities/destination_info.dart';

import 'package:rideme_driver/features/trips/domain/entities/payment_info.dart';

class TripDetails extends Equatable {
  final num? id,
      amountCharged,
      discountAmount,
      amountPaid,
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
  final List<DestinationInfo>? destinations;

  final PaymentInfo? paymentInfo;

  const TripDetails({
    required this.pickupLat,
    required this.pickupLng,
    required this.pickupAddress,
    required this.pickupGeoDataId,
    required this.id,
    required this.amountCharged,
    required this.discountAmount,
    required this.amountPaid,
    required this.amountDue,
    required this.trackingNumber,
    required this.paymentStatus,
    required this.status,
    required this.completedAt,
    required this.createdAt,
    required this.paymentMethod,
    required this.destinations,
    required this.extraFees,
    required this.totalAmount,
    required this.waitingPenalty,
    required this.polyline,
    required this.paymentInfo,
  });

  @override
  List<Object?> get props => [
        pickupLat,
        pickupAddress,
        pickupGeoDataId,
        pickupLng,
        destinations,
        trackingNumber,
        paymentStatus,
        status,
        completedAt,
        createdAt,
        id,
        amountCharged,
        discountAmount,
        amountPaid,
        amountDue,
        extraFees,
        totalAmount,
        waitingPenalty,
        polyline,
        paymentInfo,
        paymentMethod,
      ];

  Map<String, dynamic> toMap() => {
        'pickup_address': pickupAddress,
        'pickup_lat': pickupLat,
        'pickup_lng': pickupLng,
        "id": id,
        "tracking_number": trackingNumber,
        "amount_charged": amountCharged,
        "discount_amount": discountAmount,
        "amount_paid": amountPaid,
        "amount_due": amountDue,
        "payment_status": paymentStatus,
        "status": status,
        "created_at": createdAt,
        "completed_at": completedAt,
        "extra_fees": extraFees,
        "total_amount": totalAmount,
        "waiting_penalty": waitingPenalty,
        "payment_method": paymentMethod,
        "polyline": polyline,
        "stops":
            destinations?.map<Map<String, dynamic>>((e) => e.toMap()).toList(),
        'pickup_geo_data_id': pickupGeoDataId,
        'payment_info': paymentInfo?.toMap(),
      };
}
