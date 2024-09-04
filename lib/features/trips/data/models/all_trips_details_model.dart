import 'package:rideme_driver/features/trips/domain/entities/all_trips_details.dart';

class AllTripDetailsModel extends AllTripDetails {
  const AllTripDetailsModel({
    required super.pickupAddress,
    required super.id,
    required super.trackingNumber,
    required super.createdAt,
    required super.totalAmount,
    required super.dropOffAddress,
    required super.paymentStatus,
    required super.status,
  });

  //fromJson

  factory AllTripDetailsModel.fromJson(Map<String, dynamic> json) {
    return AllTripDetailsModel(
      pickupAddress: json['pickup_address'],
      id: json["id"],
      trackingNumber: json["tracking_number"],
      createdAt: json["created_at"],
      totalAmount: json["total_amount"],
      dropOffAddress: json['drop_off_address'],
      paymentStatus: json['payment_status'],
      status: json['status'],
    );
  }
}
