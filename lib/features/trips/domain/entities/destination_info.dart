import 'package:equatable/equatable.dart';

class DestinationData extends Equatable {
  final String message;
  final DestinationInfo destination;

  const DestinationData({
    required this.message,
    required this.destination,
  });

  @override
  List<Object?> get props => [
        message,
        destination,
      ];

  Map<String, dynamic> toMap() => {
        'message': message,
        'destination': destination.toMap(),
      };
}

class DestinationInfo extends Equatable {
  final num? id, lat, lng, geoDataId;
  final String? address, startedAt, endedAt;

  const DestinationInfo({
    required this.id,
    required this.lat,
    required this.lng,
    required this.address,
    required this.startedAt,
    required this.endedAt,
    required this.geoDataId,
  });

  @override
  List<Object?> get props => [
        id,
        lat,
        lng,
        geoDataId,
        address,
        startedAt,
        endedAt,
      ];

  Map<String, dynamic> toMap() => {
        "id": id,
        "lat": lat,
        "lng": lng,
        "address": address,
        "started_at": startedAt,
        "ended_at": endedAt,
        'geo_data_id': geoDataId,
      };
}
