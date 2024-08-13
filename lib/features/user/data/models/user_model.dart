import 'package:rideme_driver/features/user/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.rating,
    required super.firstName,
    required super.lastName,
    required super.phone,
    required super.email,
    required super.profileUrl,
    required super.status,
    required super.requestedDeletion,
    required super.ongoingTrip,
  });

  factory UserModel.fromJson(Map<String, dynamic>? json) {
    return UserModel(
      id: json?['id'],
      rating: json?['rating'],
      firstName: json?['first_name'],
      lastName: json?['last_name'],
      phone: json?['phone'],
      email: json?['email'],
      profileUrl: json?['profile_url'],
      status: json?['status'],
      requestedDeletion: json?['requested_deletion'],
      ongoingTrip: json?['ongoing_trip'] != null
          ? UserOngoingTripsModel.fromJson(json!['ongoing_trip'])
          : null,
    );
  }
}

//ONGOING TRIPS
class UserOngoingTripsModel extends UserOngoingTrips {
  const UserOngoingTripsModel(
      {required super.id,
      required super.trackingNumber,
      required super.status});

  //fromJson
  factory UserOngoingTripsModel.fromJson(Map<String, dynamic> json) {
    return UserOngoingTripsModel(
      id: json['id'],
      trackingNumber: json['tracking_number'],
      status: json['status'],
    );
  }
}
