import 'package:rideme_driver/core/pagination/pagination_model.dart';
import 'package:rideme_driver/features/trips/data/models/all_trips_details_model.dart';
import 'package:rideme_driver/features/trips/domain/entities/all_trips_data.dart';
import 'package:rideme_driver/features/trips/domain/entities/all_trips_info.dart';

class AllTripsInfoModel extends AllTripsInfo {
  const AllTripsInfoModel(
      {required super.message, required super.allTripsData});

  factory AllTripsInfoModel.fromJson(Map<String, dynamic> json) {
    return AllTripsInfoModel(
      message: json["message"],
      allTripsData: AllTripsDataModel.fromJson(json["trips"]),
    );
  }
}

class AllTripsDataModel extends AllTripsData {
  const AllTripsDataModel({required super.list, required super.pagination});

  factory AllTripsDataModel.fromJson(Map<String, dynamic>? json) {
    return AllTripsDataModel(
      list: json?["list"]
          .map<AllTripDetailsModel>((e) => AllTripDetailsModel.fromJson(e))
          .toList(),
      pagination: PaginationModel.fromJson(json?["pagination"]),
    );
  }
}
