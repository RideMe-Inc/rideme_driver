import 'package:rideme_driver/core/location/domain/entity/places_info.dart';

class PlacesModel extends Places {
  const PlacesModel({required super.places});

  //fromJson
  factory PlacesModel.fromJson(Map<String, dynamic> json) {
    return PlacesModel(
      places: json['predictions']
          .map<PlaceInfoModel>((e) => PlaceInfoModel.fromJson(e))
          .toList(),
    );
  }
}

//place
class PlaceInfoModel extends PlaceInfo {
  const PlaceInfoModel({
    required super.id,
    required super.name,
    required super.structuredFormatting,
  });

  //fromJson

  factory PlaceInfoModel.fromJson(Map<String, dynamic> json) {
    return PlaceInfoModel(
        id: json['place_id'],
        name: json['description'],
        structuredFormatting: DisplayNameModel.fromJson(
          json['structured_formatting'],
        ));
  }
}

//display name

class DisplayNameModel extends DisplayName {
  const DisplayNameModel({required super.mainText});

  //fromJson

  factory DisplayNameModel.fromJson(Map<String, dynamic> json) {
    return DisplayNameModel(mainText: json['main_text']);
  }
}
