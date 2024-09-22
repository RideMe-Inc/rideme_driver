import 'package:dartz/dartz.dart';
import 'package:rideme_driver/features/trips/domain/entities/all_trips_info.dart';
import 'package:rideme_driver/features/trips/domain/entities/directions_object.dart';
import 'package:rideme_driver/features/trips/domain/entities/trip_destination_info.dart';
import 'package:rideme_driver/features/trips/domain/entities/trip_tracking_details.dart';

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

  ///get tracking details
  Future<Either<String, TripTrackingDetails>> getTrackingDetails(
      Map<String, dynamic> params);

  Future<Either<String, TripTrackingDetails>> driverTripDestinationActions(
      Map<String, dynamic> params);

  //GET DIRECTIONS
  Future<Either<String, DirectionsObject>> getDirections(
      Map<String, dynamic> params);

  //play direction sound
  Future playDirectionSound(String instruction);

  //stop play direction sound
  Future stopDirectionPlaySound();
}
