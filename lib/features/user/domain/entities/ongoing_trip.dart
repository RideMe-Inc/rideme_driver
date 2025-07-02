//ONGOING TRIPS
import 'package:equatable/equatable.dart';

class UserOngoingTrips extends Equatable {
  final int id;
  final String status;

  const UserOngoingTrips({
    required this.id,
    required this.status,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "status": status,
      };

  @override
  List<Object?> get props => [
        id,
        status,
      ];
}
