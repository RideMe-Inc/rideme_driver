import 'dart:async';
import 'dart:convert';

import 'package:rideme_driver/core/enums/endpoints.dart';

import 'package:rideme_driver/core/mixins/remote_request_mixin.dart';

import 'package:rideme_driver/core/urls/urls.dart';
import 'package:rideme_driver/features/trips/data/models/all_trips_info.dart';
import 'package:rideme_driver/features/trips/data/models/directions_object_model.dart';

import 'package:rideme_driver/features/trips/data/models/trip_destnation_info_model.dart';
import 'package:http/http.dart' as http;
import 'package:rideme_driver/features/trips/data/models/trip_tracking_details_model.dart';
import 'package:web_socket_client/web_socket_client.dart';

abstract class TripRemoteDataSource {
  Future<AllTripsInfoModel> getAllTrips(Map<String, dynamic> params);

  Future<TripDetailsInfoModel> getTripDetails(Map<String, dynamic> params);

  Future<String> cancelTrip(Map<String, dynamic> params);

  Future<String> reportTrip(Map<String, dynamic> params);

  Future<String> rateTrip(Map<String, dynamic> params);

  /// accept or reject trip
  Future<String> acceptOrRejectTrip(Map<String, dynamic> params);

  //get trip status
  Future<String> getTripStatus(Map<String, dynamic> params);

  ///get tracking details
  Future<TripTrackingDetailsModel> getTrackingDetails(
      Map<String, dynamic> params);

  Future<TripTrackingDetailsModel> driverTripDestinationActions(
      Map<String, dynamic> params);

  //GET DIRECTIONS
  Future<DirectionsObjectModel> getDirections(Map<String, dynamic> params);
}

class TripRemoteDataSourceImpl
    with RemoteRequestMixin
    implements TripRemoteDataSource {
  final http.Client client;
  final URLS urls;

  final WebSocket socket;

  TripRemoteDataSourceImpl({
    required this.urls,
    required this.client,
    required this.socket,
  });

  //! CANCEL TRIP
  @override
  Future<String> cancelTrip(Map<String, dynamic> params) async {
    final decodedResponse = await delete(
      client: client,
      urls: urls,
      endpoint: Endpoints.tripDetails,
      params: params,
    );

    return decodedResponse['message'];
  }

  //! GET ALL TRIPS
  @override
  Future<AllTripsInfoModel> getAllTrips(Map<String, dynamic> params) async {
    final decodedResponse = await get(
      client: client,
      urls: urls,
      endpoint: Endpoints.trip,
      params: params,
    );

    return AllTripsInfoModel.fromJson(decodedResponse);
  }

  //! GET TRIP DETAILS
  @override
  Future<TripDetailsInfoModel> getTripDetails(
      Map<String, dynamic> params) async {
    final decodedResponse = await get(
      client: client,
      urls: urls,
      endpoint: Endpoints.tripDetails,
      params: params,
    );

    return TripDetailsInfoModel.fromJson(decodedResponse);
  }

  //! RATE TRIP
  @override
  Future<String> rateTrip(Map<String, dynamic> params) async {
    final decodedResponse = await post(
      client: client,
      urls: urls,
      endpoint: Endpoints.rateTrip,
      params: params,
    );

    return decodedResponse['message'];
  }

  //! REPORT TRIP
  @override
  Future<String> reportTrip(Map<String, dynamic> params) async {
    final decodedResponse = await post(
      client: client,
      urls: urls,
      endpoint: Endpoints.reportTrip,
      params: params,
    );

    return decodedResponse['message'];
  }

  @override
  Future<String> acceptOrRejectTrip(Map<String, dynamic> params) async {
    final decodedResponse = await post(
      client: client,
      urls: urls,
      endpoint: Endpoints.tripActions,
      params: params,
    );

    return decodedResponse['message'];
  }

  @override
  Future<String> getTripStatus(Map<String, dynamic> params) async {
    final decodedResponse = await get(
      client: client,
      urls: urls,
      endpoint: Endpoints.tripStatus,
      params: params,
    );

    return decodedResponse['message'];
  }

  @override
  Future<TripTrackingDetailsModel> getTrackingDetails(
      Map<String, dynamic> params) async {
    final decodedResponse = await get(
      client: client,
      urls: urls,
      endpoint: Endpoints.trackTrip,
      params: params,
    );
    print(decodedResponse);

    return TripTrackingDetailsModel.fromJson(decodedResponse['trip']);
  }

  @override
  Future<TripTrackingDetailsModel> driverTripDestinationActions(
      Map<String, dynamic> params) async {
    final decodedResponse = await post(
      client: client,
      urls: urls,
      endpoint: Endpoints.tripActions,
      params: params,
    );

    return TripTrackingDetailsModel.fromJson(decodedResponse['trip']);
  }

  @override
  Future<DirectionsObjectModel> getDirections(
      Map<String, dynamic> params) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/directions/json?origin=heading=${params['origin_heading']}:${params['origin_lat']},${params['origin_lng']}&destination=${params['destination_lat']},${params['destination_lng']}&key=AIzaSyAIO-3vFI_0dmGTdOv9oojSnbXNysdXxmQ',
    );

    final response = await client.get(url);

    return DirectionsObjectModel.fromJson(jsonDecode(response.body));
  }
}
