import 'package:rideme_driver/features/user/data/models/ongoing_trip_model.dart';
import 'package:rideme_driver/features/user/data/models/user_model.dart';
import 'package:rideme_driver/features/user/domain/entities/driver_object.dart';

class DriverObjectModel extends DriverObject {
  DriverObjectModel({
    required super.profile,
    required super.extra,
  });

  //fromJson
  factory DriverObjectModel.fromJson(Map<String, dynamic> json) =>
      DriverObjectModel(
        profile: UserModel.fromJson(json['profile']),
        extra:
            json["extra"] != null ? ExtraModel.fromJson(json['extra']) : null,
      );
}

class ExtraModel extends Extra {
  ExtraModel({required super.ongoingTrips});

  //fromJson
  factory ExtraModel.fromJson(Map<String, dynamic> json) => ExtraModel(
      ongoingTrips: json['ongoing_trips']
          .map<UserOngoingTripsModel>((e) => UserOngoingTripsModel.fromJson(e))
          .toList());
}
