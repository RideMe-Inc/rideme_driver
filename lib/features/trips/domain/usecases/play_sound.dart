import 'package:rideme_driver/features/trips/domain/repository/trips_repository.dart';

class PlaySound {
  final TripsRepository repository;

  PlaySound({required this.repository});

  Future call(String path) async {
    return await repository.playSound(path);
  }
}
