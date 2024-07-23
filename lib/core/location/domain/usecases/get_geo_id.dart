import 'package:dartz/dartz.dart';
import 'package:rideme_driver/core/location/domain/entity/geo_hash.dart';
import 'package:rideme_driver/core/location/domain/repositories/location_repository.dart';
import 'package:rideme_driver/core/usecase/usecase.dart';

class GetGeoID extends UseCases<GeoData, Map<String, dynamic>> {
  final LocationRepository repository;

  GetGeoID({required this.repository});
  @override
  Future<Either<String, GeoData>> call(Map<String, dynamic> params) async {
    return await repository.getGeoID(params);
  }
}
