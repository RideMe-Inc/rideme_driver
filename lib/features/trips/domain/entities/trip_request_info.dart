class TripRequestInfo {
  final String pickupAddress, riderName, polyline, timeToPickup;
  final num pickupLng, pickupLat, rating, id, distanceToPickup;

  TripRequestInfo({
    required this.pickupAddress,
    required this.riderName,
    required this.pickupLng,
    required this.pickupLat,
    required this.rating,
    required this.polyline,
    required this.id,
    required this.timeToPickup,
    required this.distanceToPickup,
  });

  //toMap

  Map<String, dynamic> toMap() => {
        "rider_name": riderName,
        "pickup_lng": pickupLng,
        "pickup_lat": pickupLat,
        "rider_rating": rating,
        "trip_id": id,
        "pickup_address": pickupAddress,
        "polyline": polyline,
        "time_to_pickup": timeToPickup,
        "distance_to_pickup": distanceToPickup,
      };
}
