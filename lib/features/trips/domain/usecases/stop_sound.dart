import 'package:rideme_driver/features/trips/domain/repository/trips_repository.dart';

class StopSound {
  final TripsRepository repository;

  StopSound({required this.repository});

  Future call() async {
    return await repository.stopSound();
  }
}
