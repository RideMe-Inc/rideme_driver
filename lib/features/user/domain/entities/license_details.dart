import 'package:equatable/equatable.dart';

class LicenseDetails extends Equatable {
  final String? number, fontImage, backImage, expiry, status, approvedAt;

  final num? id;

  const LicenseDetails({
    required this.number,
    required this.fontImage,
    required this.backImage,
    required this.expiry,
    required this.status,
    required this.approvedAt,
    required this.id,
  });

  @override
  List<Object?> get props => [
        number,
        fontImage,
        backImage,
        expiry,
        status,
        approvedAt,
        id,
      ];
}
