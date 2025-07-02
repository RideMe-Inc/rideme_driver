import 'package:rideme_driver/features/user/domain/entities/ongoing_trip.dart';
import 'package:rideme_driver/features/user/domain/entities/user.dart';

class DriverObject {
  final User profile;
  final Extra? extra;

  DriverObject({required this.profile, required this.extra});
}

class Extra {
  final List<UserOngoingTrips> ongoingTrips;

  Extra({required this.ongoingTrips});
}
