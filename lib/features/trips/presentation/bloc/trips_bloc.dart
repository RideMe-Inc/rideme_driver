import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideme_driver/core/extensions/date_extension.dart';

import 'package:rideme_driver/features/trips/data/models/trip_destnation_info_model.dart';
import 'package:rideme_driver/features/trips/domain/entities/all_trips_details.dart';
import 'package:rideme_driver/features/trips/domain/entities/trip_destination_data.dart';

import 'package:equatable/equatable.dart';
import 'package:rideme_driver/features/trips/domain/entities/all_trips_info.dart';

import 'package:rideme_driver/features/trips/domain/entities/trip_destination_info.dart';

import 'package:rideme_driver/features/trips/domain/usecases/cancel_trip.dart';

import 'package:rideme_driver/features/trips/domain/usecases/get_all_trips.dart';

import 'package:rideme_driver/features/trips/domain/usecases/get_trip_info.dart';

import 'package:rideme_driver/features/trips/domain/usecases/rate_trip.dart';
import 'package:rideme_driver/features/trips/domain/usecases/report_trip.dart';

part 'trips_event.dart';
part 'trips_state.dart';

class TripsBloc extends Bloc<TripsEvent, TripsState> {
  final CancelTrip cancelTrip;

  final GetAllTrips getAllTrips;
  final RateTrip rateTrip;
  final ReportTrip reportTrip;
  final GetTripInfo getTripInfo;

  TripsBloc({
    required this.cancelTrip,
    required this.getAllTrips,
    required this.rateTrip,
    required this.getTripInfo,
    required this.reportTrip,
  }) : super(TripsInitial()) {
    //! CANCEL TRIP

    on<CancelTripEvent>((event, emit) async {
      emit(CancelTripLoading());

      final response = await cancelTrip(event.params);

      emit(
        response.fold(
          (error) => GenericTripsError(errorMessage: error),
          (response) => CancelTripLoaded(message: response),
        ),
      );
    });

    //! GET  ALL TRIPS

    on<GetAllTripsEvent>((event, emit) async {
      emit(GetAllTripLoading());

      final response = await getAllTrips(event.params);

      emit(
        response.fold(
          (error) => GenericTripsError(errorMessage: error),
          (response) => GetAllTripLoaded(allTripsInfo: response, tripDetails: [
            ...event.currentList,
            ...response.allTripsData!.list
          ]),
        ),
      );
    });

    //! GET TRIP INFO

    on<GetTripInfoEvent>((event, emit) async {
      emit(GetTripLoading());

      final response = await getTripInfo(event.params);

      emit(
        response.fold(
          (error) => GenericTripsError(errorMessage: error),
          (response) => GetTripLoaded(tripDetailsInfo: response),
        ),
      );
    });

    //! RATE TRIPS

    on<RateTripEvent>((event, emit) async {
      emit(RateTripLoading());

      final response = await rateTrip(event.params);

      emit(
        response.fold(
          (error) => GenericTripsError(errorMessage: error),
          (response) => RateTripLoaded(rate: response),
        ),
      );
    });

    //! REPORT TRIPS

    on<ReportTripEvent>((event, emit) async {
      emit(ReportTripLoading());

      final response = await reportTrip(event.params);

      emit(
        response.fold(
          (error) => GenericTripsError(errorMessage: error),
          (response) => ReportTripLoaded(report: response),
        ),
      );
    });
  }

  //return destinations
  List<Map> returnDestinationMap(
      {required List<dynamic> locations,
      required List<TextEditingController> contacts}) {
    List<Map> someshit = [];

    for (int i = 0; i < locations.length; i++) {
      someshit.add({
        "customer_phone": contacts[i].text,
        "geo_data_id": locations[i]['id'],
        "destination_type": "drop-off",
      });
    }

    return someshit;
  }

  //check contacts availability
  bool allContactsAdded({required List<TextEditingController> contacts}) {
    bool holder = true;

    for (int i = 0; i < contacts.length; i++) {
      if (contacts[i].text.isEmpty) {
        holder = false;
        break;
      }
    }

    return holder;
  }

  //CHECK VALIDITY OF NUMBER

  bool isValidNumber(String phoneNumber) {
    final regex = RegExp(r'(\+)?(233)|(0)[25][0345679]\d{7}$');

    final match = regex.firstMatch(phoneNumber);

    if (match == null) {
      return false;
    }

    return true;
  }

  //parse Time String
  Duration parseTimeString(String timeString) {
    List<String> parts = timeString.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(parts[2]);

    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }

  //get geo data ids for making request for pricing
  List<Map<String, dynamic>> getGeoDataIds(List<dynamic> data) {
    List<Map<String, dynamic>> ids = [];

    for (var element in data) {
      ids.add({
        "geo_data_id": element['id'],
      });
    }

    return ids;
  }

  // //pricing data parsing

  // CreateTripInfo decodePricingInfo(String jsonString) {
  //   return CreateTripInfoModel.fromJson(jsonDecode(jsonString));
  // }

  // //update markers for polyline on pricing page

  // Set<Marker> updateMarkersForPolyLine(CreateTripInfo createTripInfo) {
  //   Set<Marker> marker = {};

  //   marker.add(
  //     Marker(
  //       markerId: MarkerId(createTripInfo.pickupAddress ?? ''),
  //       infoWindow: InfoWindow(
  //         title: createTripInfo.pickupAddress,
  //       ),
  //       position: LatLng(
  //         createTripInfo.pickupLat?.toDouble() ?? 0,
  //         createTripInfo.pickupLng?.toDouble() ?? 0,
  //       ),
  //     ),
  //   );

  //   for (var location in createTripInfo.destinations!) {
  //     marker.add(
  //       Marker(
  //         markerId: MarkerId(location.address!),
  //         infoWindow: InfoWindow(
  //           title: location.address ?? '',
  //         ),
  //         position: LatLng(
  //           location.lat.toDouble(),
  //           location.lng.toDouble(),
  //         ),
  //       ),
  //     );
  //   }

  //   return marker;
  // }

//trip info data parsing

  TripDetails decodeTripDetailsInfo(String jsonString) {
    return TripDestinationDataModel.fromJson(jsonDecode(jsonString));
  }

//sort under date

  List<MapEntry<DateTime, List<AllTripDetails>>> getCategorizedTripsHistory(
      List<AllTripDetails> bills) {
    Map<DateTime, List<AllTripDetails>> history = {};

    for (final data in bills) {
      final keys = history.keys;
      final key = keys.firstWhere(
        (element) => element.isSameDate(
            DateTime.parse(data.createdAt ?? DateTime.now().toString())),
        orElse: () =>
            DateTime.parse(data.createdAt ?? DateTime.now().toString()),
      );
      if (history.containsKey(key)) {
        history[key]!.add(data);
      } else {
        history[key] = [data];
      }
    }

    List<MapEntry<DateTime, List<AllTripDetails>>> historyList = history.entries
        .map(
          (e) => e,
        )
        .toList();
    return historyList;
  }

  // //get order page tracking intent
  // TrackingInfoNotice getSearchTrackInfo(
  //   TrackingInfo? trackingInfo,
  //   BuildContext context,
  // ) {
  //   switch (trackingInfo?.status ?? 'searching') {
  //     case 'searching':
  //       return TrackingInfoNotice(
  //         header: context.appLocalizations.checkingForCar,
  //         subtitle: context.appLocalizations.checkingForCarInfo,
  //       );

  //     case 'driver-found':
  //       return TrackingInfoNotice(
  //         header: context.appLocalizations.availableDriverFound,
  //         subtitle: context.appLocalizations.availableDriverFoundInfo,
  //       );

  //     case 'driver-not-found':
  //       return TrackingInfoNotice(
  //         header: context.appLocalizations.driverNotFound,
  //         subtitle: context.appLocalizations.driverNotFoundInfo,
  //       );

  //     case 'driver-assigned':
  //       return TrackingInfoNotice(
  //         header: context.appLocalizations.driverNotFound,
  //         subtitle: context.appLocalizations.driverNotFoundInfo,
  //       );

  //     default:
  //       return TrackingInfoNotice(
  //         header: context.appLocalizations.checkingForCar,
  //         subtitle: context.appLocalizations.checkingForCarInfo,
  //       );
  //   }
  // }
}
