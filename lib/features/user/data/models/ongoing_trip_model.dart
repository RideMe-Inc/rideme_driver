//ONGOING TRIPS
import 'package:rideme_driver/features/user/domain/entities/ongoing_trip.dart';

class UserOngoingTripsModel extends UserOngoingTrips {
  const UserOngoingTripsModel({required super.id, required super.status});

  //fromJson
  factory UserOngoingTripsModel.fromJson(Map<String, dynamic> json) {
    return UserOngoingTripsModel(
      id: json['id'],
      status: json['status'],
    );
  }
}
