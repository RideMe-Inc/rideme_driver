import 'package:rideme_driver/core/location/domain/entity/geo_hash.dart';

class GeoDataModel extends GeoData {
  const GeoDataModel({
    required super.id,
    required super.lat,
    required super.lng,
    required super.address,
    required super.geoHash,
  });

  factory GeoDataModel.fromJson(Map<String, dynamic>? json) => GeoDataModel(
        id: json?['id'],
        lat: json?['lat'],
        lng: json?['lng'],
        address: json?['address'],
        geoHash: json?['geo_hash'],
      );
}
