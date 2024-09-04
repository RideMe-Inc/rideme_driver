import 'package:rideme_driver/features/trips/domain/entities/destination_info.dart';

class DestinationDataModel extends DestinationData {
  const DestinationDataModel(
      {required super.message, required super.destination});

  factory DestinationDataModel.fromJson(Map<String, dynamic> json) {
    return DestinationDataModel(
        message: json["message"],
        destination: DestinationInfoModel.fromJson(json["destination"]));
  }
}

///
///
///
///
class DestinationInfoModel extends DestinationInfo {
  const DestinationInfoModel({
    required super.id,
    required super.lat,
    required super.lng,
    required super.address,
    required super.startedAt,
    required super.endedAt,
    required super.geoDataId,
  });

  factory DestinationInfoModel.fromJson(Map<String, dynamic>? json) =>
      DestinationInfoModel(
        id: json?["id"],
        lat: json?["lat"],
        lng: json?["lng"],
        address: json?["address"],
        startedAt: json?["started_at"],
        endedAt: json?["ended_at"],
        geoDataId: json?['geo_data_id'],
      );
}
