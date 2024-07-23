import 'package:equatable/equatable.dart';

class GeoData extends Equatable {
  final num? id, lat, lng;
  final String? address, geoHash;

  const GeoData({
    required this.id,
    required this.lat,
    required this.lng,
    required this.address,
    required this.geoHash,
  });

  @override
  List<Object?> get props => [
        id,
        lat,
        lng,
        address,
        geoHash,
      ];

  Map<String, dynamic> toMap() => {
        'id': id,
        'lat': lat,
        'lng': lng,
        'address': address,
        'geo_hash': geoHash,
      };
}
