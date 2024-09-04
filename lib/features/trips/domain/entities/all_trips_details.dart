import 'package:equatable/equatable.dart';

class AllTripDetails extends Equatable {
  final num? id, totalAmount;
  final String? trackingNumber,
      pickupAddress,
      dropOffAddress,
      createdAt,
      status,
      paymentStatus;

  const AllTripDetails({
    required this.pickupAddress,
    required this.id,
    required this.trackingNumber,
    required this.createdAt,
    required this.totalAmount,
    required this.dropOffAddress,
    required this.paymentStatus,
    required this.status,
  });

  @override
  List<Object?> get props => [
        pickupAddress,
        trackingNumber,
        createdAt,
        id,
        totalAmount,
        dropOffAddress,
        paymentStatus,
        status,
      ];
}
