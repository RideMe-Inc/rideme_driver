import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rideme_driver/core/enums/endpoints.dart';
import 'package:rideme_driver/core/exceptions/generic_exception_class.dart';
import 'package:rideme_driver/core/location/data/models/geo_hash_model.dart';
import 'package:rideme_driver/core/location/data/models/places_model.dart';
import 'package:rideme_driver/core/mixins/remote_request_mixin.dart';
import 'package:rideme_driver/core/urls/urls.dart';

abstract class LocationRemoteDatasource {
  //search places
  Future<PlacesModel> searchPlaces(Map<String, dynamic> params);

  //get geo id
  Future<GeoDataModel> getGeoID(Map<String, dynamic> params);
}

class LocationRemoteDatasourceImpl
    with RemoteRequestMixin
    implements LocationRemoteDatasource {
  final URLS urls;
  final http.Client client;

  LocationRemoteDatasourceImpl({required this.urls, required this.client});

  //search places
  @override
  Future<PlacesModel> searchPlaces(Map<String, dynamic> params) async {
    final uri = Uri.parse(
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?fields=formatted_address%2Cname%2Cplace_id&input=${Uri.encodeComponent(params['searchText'])}&region=gh&inputtype=textquery&key='");

    final response = await client.post(uri);

    // final uri = Uri.parse("https://places.googleapis.com/v1/places:searchText");

    // final headers = {
    //   "Content-Type": "application/json",
    //   "X-Goog-Api-Key": "'",
    //   "X-Goog-FieldMask":
    //       "places.id, places.displayName,places.formattedAddress"
    // };

    // final body = {
    //   "textQuery": params['searchText'],
    // };

    // //make request

    // final response = await client.post(
    //   uri,
    //   headers: headers,
    //   body: jsonEncode(body),
    // );

    if (response.statusCode == 200) {
      return PlacesModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('An error occured');
    }
  }

  //GET GEO ID

  @override
  Future<GeoDataModel> getGeoID(Map<String, dynamic> params) async {
    final uri = urls.returnUri(
      locale: params['locale'],
      endpoint: Endpoints.getGeoID,
      queryParameters: params['queryParameters'],
      urlParameters: null,
    );

    final response = await client.get(
      uri,
      headers: urls.headers,
    );

    final decodedResponse = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw ErrorException(decodedResponse['message']);
    }

    return GeoDataModel.fromJson(decodedResponse['data']);
  }
}
