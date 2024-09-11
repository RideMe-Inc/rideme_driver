import 'package:dartz/dartz.dart';
import 'package:rideme_driver/core/usecase/usecase.dart';
import 'package:rideme_driver/features/trips/domain/entities/directions_object.dart';
import 'package:rideme_driver/features/trips/domain/repository/trips_repository.dart';

class GetDirections extends UseCases<DirectionsObject, Map<String, dynamic>> {
  final TripsRepository repository;

  GetDirections({required this.repository});
  @override
  Future<Either<String, DirectionsObject>> call(
          Map<String, dynamic> params) async =>
      await repository.getDirections(params);
}
