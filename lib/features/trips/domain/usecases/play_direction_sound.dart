import 'package:rideme_driver/features/trips/domain/repository/trips_repository.dart';

class PlayDirectionSound {
  final TripsRepository repository;

  PlayDirectionSound({required this.repository});

  //play direction sound
  Future call(String instruction) async =>
      await repository.playDirectionSound(instruction);
}
