import 'dart:convert';

import 'package:rideme_driver/core/location/data/models/geo_hash_model.dart';
import 'package:rideme_driver/core/location/domain/entity/geo_hash.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocationLocalDatasource {
  Future<bool> cacheLocation(GeoData? geoData);
  List<GeoDataModel> retrieveRecentLocations();
}

class LocationLocalDatasourceImpl implements LocationLocalDatasource {
  final SharedPreferences sharedPreferences;

  final cacheKey = 'LOCATIONS_CACHE_KEY';

  LocationLocalDatasourceImpl({required this.sharedPreferences});

  @override
  Future<bool> cacheLocation(GeoData? geoData) async {
    if (geoData == null) return false;

    final locations = sharedPreferences.getStringList(cacheKey) ?? [];

    final jsonString = jsonEncode(geoData.toMap());

    locations.add(jsonString);

    return await sharedPreferences.setStringList(cacheKey, locations);
  }

  @override
  List<GeoDataModel> retrieveRecentLocations() {
    final locations = sharedPreferences.getStringList(cacheKey) ?? [];

    final decodedLocations = locations.map((e) => jsonDecode(e)).toList();

    return decodedLocations.map((e) => GeoDataModel.fromJson(e)).toList();
  }
}
