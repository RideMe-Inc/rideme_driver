import 'package:equatable/equatable.dart';

class User extends Equatable {
  final num? id, rating;
  final bool? requestedDeletion, hasVehicle, hasLicense, photoCheckRequired;
  final String? firstName,
      lastName,
      phone,
      email,
      profileUrl,
      address,
      status,
      availability;

  const User({
    required this.id,
    required this.rating,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.profileUrl,
    required this.address,
    required this.status,
    required this.requestedDeletion,
    required this.hasLicense,
    required this.hasVehicle,
    required this.availability,
    required this.photoCheckRequired,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "rating": rating,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "email": email,
        "has_license": hasLicense,
        "has_vehicle": hasVehicle,
        "photo_check_required": photoCheckRequired,
        "profile_url": profileUrl,
        "status": status,
        "address": address,
        "requested_deletion": requestedDeletion,
        "availability": availability,
      };

  @override
  List<Object?> get props => [
        id,
        rating,
        firstName,
        lastName,
        phone,
        email,
        profileUrl,
        status,
        requestedDeletion,
        hasLicense,
        address,
        hasVehicle,
        photoCheckRequired,
        availability,
      ];
}
