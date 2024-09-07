import 'package:dartz/dartz.dart';
import 'package:rideme_driver/core/usecase/usecase.dart';
import 'package:rideme_driver/features/trips/domain/entities/trip_tracking_details.dart';
import 'package:rideme_driver/features/trips/domain/repository/trips_repository.dart';

class GetTrackingDetails
    extends UseCases<TripTrackingDetails, Map<String, dynamic>> {
  final TripsRepository repository;

  GetTrackingDetails({required this.repository});
  @override
  Future<Either<String, TripTrackingDetails>> call(
      Map<String, dynamic> params) async {
    return await repository.getTrackingDetails(params);
  }
}
