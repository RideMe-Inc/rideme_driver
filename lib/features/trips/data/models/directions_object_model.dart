import 'package:rideme_driver/features/trips/domain/entities/directions_object.dart';

class DirectionsObjectModel extends DirectionsObject {
  DirectionsObjectModel({required super.routes, required super.status});

  factory DirectionsObjectModel.fromJson(Map<String, dynamic> json) =>
      DirectionsObjectModel(
        routes: json['routes'] != null
            ? json["routes"]
                .map<RoutesModel>((e) => RoutesModel.fromJson(e))
                .toList()
            : null,
        status: json['status'],
      );
}

class RoutesModel extends Routes {
  RoutesModel({
    required super.bounds,
    required super.copyrights,
    required super.legs,
    required super.overviewPolyline,
    required super.summary,
  });

  factory RoutesModel.fromJson(Map<String, dynamic> json) => RoutesModel(
        bounds: BoundsModel.fromJson(json['bounds']),
        copyrights: json['copyrights'],
        legs: json['legs'] != null
            ? json["legs"].map<LegsModel>((e) => LegsModel.fromJson(e)).toList()
            : null,
        overviewPolyline: PolylineModel.fromJson(json['overview_polyline']),
        summary: json['summary'],
      );
}

class BoundsModel extends Bounds {
  BoundsModel({required super.northeast, required super.southwest});

  factory BoundsModel.fromJson(Map<String, dynamic> json) => BoundsModel(
        northeast: NortheastModel.fromJson(json['northeast']),
        southwest: NortheastModel.fromJson(json['southwest']),
      );
}

class NortheastModel extends Northeast {
  NortheastModel({required super.lat, required super.lng});

  factory NortheastModel.fromJson(Map<String, dynamic> json) => NortheastModel(
        lat: json['lat'],
        lng: json['lng'],
      );
}

class LegsModel extends Legs {
  LegsModel({
    required super.distance,
    required super.duration,
    required super.endAddress,
    required super.endLocation,
    required super.startAddress,
    required super.startLocation,
    required super.steps,
  });

  factory LegsModel.fromJson(Map<String, dynamic> json) => LegsModel(
        distance: DistanceModel.fromJson(json['distance']),
        duration: DistanceModel.fromJson(json['duration']),
        endAddress: json['end_address'],
        endLocation: NortheastModel.fromJson(json['end_location']),
        startAddress: json['start_address'],
        startLocation: NortheastModel.fromJson(json['start_location']),
        steps: json['steps'] != null
            ? json["steps"]
                .map<StepsModel>((e) => StepsModel.fromJson(e))
                .toList()
            : null,
      );
}

class DistanceModel extends Distance {
  DistanceModel({required super.text, required super.value});

  factory DistanceModel.fromJson(Map<String, dynamic> json) => DistanceModel(
        text: json['text'],
        value: json['value'],
      );
}

class StepsModel extends Steps {
  StepsModel(
      {required super.distance,
      required super.duration,
      required super.endLocation,
      required super.htmlInstructions,
      required super.polyline,
      required super.startLocation,
      required super.travelMode,
      required super.maneuver});

  factory StepsModel.fromJson(Map<String, dynamic> json) => StepsModel(
        distance: DistanceModel.fromJson(json['distance']),
        duration: DistanceModel.fromJson(json['duration']),
        endLocation: NortheastModel.fromJson(json['end_location']),
        htmlInstructions: json['html_instructions'],
        polyline: PolylineModel.fromJson(json['polyline']),
        startLocation: NortheastModel.fromJson(json['start_location']),
        travelMode: json['travel_mode'],
        maneuver: json['maneuver'],
      );
}

class PolylineModel extends Polyline {
  PolylineModel({required super.points});

  factory PolylineModel.fromJson(Map<String, dynamic> json) =>
      PolylineModel(points: json['points']);
}
