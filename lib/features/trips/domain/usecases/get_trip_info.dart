import 'package:dartz/dartz.dart';
import 'package:rideme_driver/core/usecase/usecase.dart';
import 'package:rideme_driver/features/trips/domain/entities/trip_destination_info.dart';
import 'package:rideme_driver/features/trips/domain/repository/trips_repository.dart';

class GetTripInfo extends UseCases<TripDetailsInfo, Map<String, dynamic>> {
  final TripsRepository repository;

  GetTripInfo({required this.repository});
  @override
  Future<Either<String, TripDetailsInfo>> call(
      Map<String, dynamic> params) async {
    return await repository.getTripDetails(params);
  }
}
