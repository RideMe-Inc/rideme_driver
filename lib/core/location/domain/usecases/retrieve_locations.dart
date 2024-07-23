import 'package:rideme_driver/core/location/domain/entity/geo_hash.dart';
import 'package:rideme_driver/core/location/domain/repositories/location_repository.dart';

class RetrieveLocations {
  final LocationRepository repository;

  RetrieveLocations({required this.repository});

  List<GeoData> call() => repository.retrieveRecentLocations();
}
