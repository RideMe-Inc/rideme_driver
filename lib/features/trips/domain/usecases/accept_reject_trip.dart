import 'package:dartz/dartz.dart';
import 'package:rideme_driver/core/usecase/usecase.dart';
import 'package:rideme_driver/features/trips/domain/repository/trips_repository.dart';

class AcceptOrRejectTrip extends UseCases<String, Map<String, dynamic>> {
  final TripsRepository repository;

  AcceptOrRejectTrip({required this.repository});

  @override
  Future<Either<String, String>> call(Map<String, dynamic> params) async {
    return await repository.acceptOrRejectTrip(params);
  }
}
