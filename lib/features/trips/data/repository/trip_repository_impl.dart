import 'package:dartz/dartz.dart';
import 'package:rideme_driver/core/exceptions/generic_exception_class.dart';
import 'package:rideme_driver/core/network/networkinfo.dart';
import 'package:rideme_driver/features/trips/data/datasource/localds.dart';
import 'package:rideme_driver/features/trips/data/datasource/remoteds.dart';
import 'package:rideme_driver/features/trips/domain/entities/all_trips_info.dart';

import 'package:rideme_driver/features/trips/domain/entities/trip_destination_info.dart';
import 'package:rideme_driver/features/trips/domain/repository/trips_repository.dart';

class TripsRepositoryImpl implements TripsRepository {
  final NetworkInfo networkInfo;
  final TripRemoteDataSource tripRemoteDataSource;
  final TripsLocalDatasource localDatasource;

  TripsRepositoryImpl({
    required this.networkInfo,
    required this.tripRemoteDataSource,
    required this.localDatasource,
  });

  // cancel trip

  @override
  Future<Either<String, String>> cancelTrip(Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await tripRemoteDataSource.cancelTrip(params);
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

  // get all trips
  @override
  Future<Either<String, AllTripsInfo>> getAllTrips(
      Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await tripRemoteDataSource.getAllTrips(params);
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

  // get trip details

  @override
  Future<Either<String, TripDetailsInfo>> getTripDetails(
      Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await tripRemoteDataSource.getTripDetails(params);
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

  // rate trip
  @override
  Future<Either<String, String>> rateTrip(Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await tripRemoteDataSource.rateTrip(params);
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

  //report trip
  @override
  Future<Either<String, String>> reportTrip(Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await tripRemoteDataSource.reportTrip(params);
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

  // accept or reject trip
  @override
  Future<Either<String, String>> acceptOrRejectTrip(
      Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await tripRemoteDataSource.acceptOrRejectTrip(params);

        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    } else {
      return Left(networkInfo.noNetowrkMessage);
    }
  }

  //get trip status
  @override
  Future<Either<String, String>> getTripStatus(
      Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await tripRemoteDataSource.getTripStatus(params);
        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    } else {
      return Left(networkInfo.noNetowrkMessage);
    }
  }

  @override
  Future playSound(String path) async {
    return localDatasource.playSound(path);
  }

  @override
  Future stopSound() async {
    return localDatasource.stopSound();
  }
}
