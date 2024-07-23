import 'package:dartz/dartz.dart';
import 'package:rideme_driver/core/location/domain/entity/geo_hash.dart';
import 'package:rideme_driver/core/location/domain/entity/places_info.dart';

abstract class LocationRepository {
  // search places

  Future<Either<String, Places>> searchPlace(Map<String, dynamic> params);

  //get geo id
  Future<Either<String, GeoData>> getGeoID(Map<String, dynamic> params);

  //cache location
  Future<bool> cacheLocation(GeoData? geoData);

  //retrieve locations
  List<GeoData> retrieveRecentLocations();
}
