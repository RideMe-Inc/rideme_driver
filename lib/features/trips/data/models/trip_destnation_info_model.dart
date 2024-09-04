import 'package:rideme_driver/features/trips/data/models/destination_info_model.dart';
import 'package:rideme_driver/features/trips/data/models/payment_info_model.dart';

import 'package:rideme_driver/features/trips/domain/entities/trip_destination_data.dart';
import 'package:rideme_driver/features/trips/domain/entities/trip_destination_info.dart';

class TripDetailsInfoModel extends TripDetailsInfo {
  const TripDetailsInfoModel({
    required super.message,
    required super.tripDestinationData,
  });
  factory TripDetailsInfoModel.fromJson(Map<String, dynamic> json) {
    return TripDetailsInfoModel(
      message: json["message"],
      tripDestinationData: TripDestinationDataModel.fromJson(json["trip"]),
    );
  }
}

///
///

class TripDestinationDataModel extends TripDetails {
  const TripDestinationDataModel({
    required super.destinations,
    required super.id,
    required super.amountCharged,
    required super.discountAmount,
    required super.amountPaid,
    required super.amountDue,
    required super.trackingNumber,
    required super.paymentStatus,
    required super.status,
    required super.completedAt,
    required super.createdAt,
    required super.extraFees,
    required super.totalAmount,
    required super.waitingPenalty,
    required super.paymentMethod,
    required super.polyline,
    required super.pickupLat,
    required super.pickupLng,
    required super.pickupAddress,
    required super.pickupGeoDataId,
    required super.paymentInfo,
  });

  factory TripDestinationDataModel.fromJson(Map<String, dynamic>? json) {
    return TripDestinationDataModel(
      pickupAddress: json?['pickup_address'],
      pickupLat: json?['pickup_lat'],
      pickupLng: json?['pickup_lng'],
      id: json?["id"],
      trackingNumber: json?["tracking_number"],
      amountCharged: json?["amount_charged"],
      discountAmount: json?["discount_amount"],
      amountPaid: json?["amount_paid"],
      amountDue: json?["amount_due"],
      paymentStatus: json?["payment_status"],
      status: json?["status"],
      createdAt: json?["created_at"],
      completedAt: json?["completed_at"],
      paymentMethod: json?["payment_method"],
      extraFees: json?["extra_fees"],
      totalAmount: json?["total_amount"],
      waitingPenalty: json?["waiting_penalty"],
      polyline: json?["polyline"],
      destinations: json?["stops"]
          ?.map<DestinationInfoModel>((e) => DestinationInfoModel.fromJson(e))
          .toList(),
      pickupGeoDataId: json?['pickup_geo_data_id'],
      paymentInfo: json?['payment_info'] != null
          ? PaymentInfoModel.fromJson(json!['payment_info'])
          : null,
    );
  }
}
