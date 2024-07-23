import 'package:rideme_driver/core/location/domain/entity/geo_hash.dart';
import 'package:rideme_driver/core/location/domain/repositories/location_repository.dart';

class CacheLocation {
  final LocationRepository repository;

  CacheLocation({required this.repository});

  Future<bool> call(GeoData? geoData) async =>
      await repository.cacheLocation(geoData);
}
