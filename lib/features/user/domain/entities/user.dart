import 'package:equatable/equatable.dart';

class User extends Equatable {
  final num? id, rating;
  final bool? requestedDeletion;
  final String? firstName, lastName, phone, email, profileUrl, status;

  final UserOngoingTrips? ongoingTrip;

  const User({
    required this.id,
    required this.rating,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.profileUrl,
    required this.status,
    required this.requestedDeletion,
    required this.ongoingTrip,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "rating": rating,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "email": email,
        "profile_url": profileUrl,
        "status": status,
        "requested_deletion": requestedDeletion,
        "ongoing_trip": ongoingTrip?.toMap(),
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
        ongoingTrip,
      ];
}

//ONGOING TRIPS
class UserOngoingTrips extends Equatable {
  final int id;
  final String trackingNumber, status;

  const UserOngoingTrips({
    required this.id,
    required this.trackingNumber,
    required this.status,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "tracking_number": trackingNumber,
        "status": status,
      };

  @override
  List<Object?> get props => [
        id,
        trackingNumber,
        status,
      ];
}
