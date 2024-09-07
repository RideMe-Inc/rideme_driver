import 'package:dartz/dartz.dart';
import 'package:rideme_driver/features/trips/domain/entities/all_trips_info.dart';
import 'package:rideme_driver/features/trips/domain/entities/trip_destination_info.dart';

abstract class TripsRepository {
  Future<Either<String, AllTripsInfo>> getAllTrips(Map<String, dynamic> params);

  Future<Either<String, TripDetailsInfo>> getTripDetails(
      Map<String, dynamic> params);

  Future<Either<String, String>> cancelTrip(Map<String, dynamic> params);

  Future<Either<String, String>> reportTrip(Map<String, dynamic> params);

  Future<Either<String, String>> rateTrip(Map<String, dynamic> params);

  Future<Either<String, String>> acceptOrRejectTrip(
      Map<String, dynamic> params);

  //get trip status
  Future<Either<String, String>> getTripStatus(Map<String, dynamic> params);

  ///play sound
  Future playSound(String path);

  ///stop sound
  Future stopSound();
}
