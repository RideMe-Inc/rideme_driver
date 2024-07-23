import 'package:dartz/dartz.dart';
import 'package:rideme_driver/core/exceptions/generic_exception_class.dart';
import 'package:rideme_driver/core/location/data/datasources/localds.dart';
import 'package:rideme_driver/core/location/data/datasources/remoteds.dart';
import 'package:rideme_driver/core/location/domain/entity/geo_hash.dart';
import 'package:rideme_driver/core/location/domain/entity/places_info.dart';
import 'package:rideme_driver/core/location/domain/repositories/location_repository.dart';
import 'package:rideme_driver/core/network/networkinfo.dart';

class LocationRepositoryImpl extends LocationRepository {
  final NetworkInfo networkInfo;
  final LocationRemoteDatasource remoteDatasource;
  final LocationLocalDatasource localDatasource;

  LocationRepositoryImpl({
    required this.networkInfo,
    required this.localDatasource,
    required this.remoteDatasource,
  });

  //search places
  @override
  Future<Either<String, Places>> searchPlace(
      Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.searchPlaces(params);
        return Right(response);
      } catch (e) {
        if (e is ErrorException) {
          return Left(e.toString());
        }

        return const Left('An error occured');
      }
    } else {
      return Left(networkInfo.noNetowrkMessage);
    }
  }

  //GET GEO ID
  @override
  Future<Either<String, GeoData>> getGeoID(Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.getGeoID(params);
        return Right(response);
      } catch (e) {
        if (e is ErrorException) {
          return Left(e.toString());
        }

        return const Left('An error occured');
      }
    } else {
      return Left(networkInfo.noNetowrkMessage);
    }
  }

  @override
  Future<bool> cacheLocation(GeoData? geoData) async {
    return await localDatasource.cacheLocation(geoData);
  }

  @override
  List<GeoData> retrieveRecentLocations() {
    return localDatasource.retrieveRecentLocations();
  }
}
