import 'package:rideme_driver/features/trips/domain/repository/trips_repository.dart';

class StopDirectionPlaySound {
  final TripsRepository repository;

  StopDirectionPlaySound({required this.repository});

  //play direction sound
  Future call() async => await repository.stopDirectionPlaySound();
}
