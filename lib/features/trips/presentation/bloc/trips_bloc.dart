import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideme_driver/core/extensions/date_extension.dart';

import 'package:rideme_driver/features/trips/data/models/trip_destnation_info_model.dart';
import 'package:rideme_driver/features/trips/data/models/trip_request_info_model.dart';
import 'package:rideme_driver/features/trips/domain/entities/all_trips_details.dart';
import 'package:rideme_driver/features/trips/domain/entities/trip_destination_data.dart';

import 'package:equatable/equatable.dart';
import 'package:rideme_driver/features/trips/domain/entities/all_trips_info.dart';

import 'package:rideme_driver/features/trips/domain/entities/trip_destination_info.dart';
import 'package:rideme_driver/features/trips/domain/entities/trip_request_info.dart';
import 'package:rideme_driver/features/trips/domain/entities/trip_tracking_details.dart';
import 'package:rideme_driver/features/trips/domain/usecases/accept_reject_trip.dart';

import 'package:rideme_driver/features/trips/domain/usecases/cancel_trip.dart';

import 'package:rideme_driver/features/trips/domain/usecases/get_all_trips.dart';
import 'package:rideme_driver/features/trips/domain/usecases/get_tracking_details.dart';

import 'package:rideme_driver/features/trips/domain/usecases/get_trip_info.dart';
import 'package:rideme_driver/features/trips/domain/usecases/get_trip_status.dart';
import 'package:rideme_driver/features/trips/domain/usecases/play_sound.dart';

import 'package:rideme_driver/features/trips/domain/usecases/rate_trip.dart';
import 'package:rideme_driver/features/trips/domain/usecases/report_trip.dart';
import 'package:rideme_driver/features/trips/domain/usecases/rider_trip_destination_actions.dart';
import 'package:rideme_driver/features/trips/domain/usecases/stop_sound.dart';

part 'trips_event.dart';
part 'trips_state.dart';

class TripsBloc extends Bloc<TripsEvent, TripsState> {
  final CancelTrip cancelTrip;

  final GetAllTrips getAllTrips;
  final RateTrip rateTrip;
  final ReportTrip reportTrip;
  final GetTripInfo getTripInfo;

  final AcceptOrRejectTrip acceptOrRejectTrip;
  final GetTripStatus getTripStatus;
  final PlaySound playSound;
  final StopSound stopSound;
  final GetTrackingDetails getTrackingDetails;
  final RiderTripDestinationActions riderTripDestinationActions;

  TripsBloc({
    required this.cancelTrip,
    required this.getAllTrips,
    required this.rateTrip,
    required this.getTripInfo,
    required this.reportTrip,
    required this.acceptOrRejectTrip,
    required this.getTripStatus,
    required this.playSound,
    required this.stopSound,
    required this.getTrackingDetails,
    required this.riderTripDestinationActions,
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

    //!ACCEPT REJECT TRIP
    on<AcceptRejectTripEvent>((event, emit) async {
      emit(AcceptRejectTripLoading());
      final response = await acceptOrRejectTrip(event.params);

      emit(
        response.fold(
          (errorMessage) => GenericTripError(errorMessage: errorMessage),
          (response) => AcceptRejectTripLoaded(
              tripId: response, isReject: event.params['type'] == 'reject'),
        ),
      );
    });

    //!GET TRIP STATUS

    on<GetTripStatusEvent>((event, emit) async {
      emit(GetTripStatusLoading());

      final response = await getTripStatus(event.params);

      emit(
        response.fold(
          (error) => GetTripStatusError(error: error),
          (response) => GetTripStatusLoaded(status: response),
        ),
      );
    });

    //!TRACK TRIP
    on<GetTrackingDetailsEvent>((event, emit) async {
      emit(GetTrackingDetailsLoading());
      final response = await getTrackingDetails(event.params);

      emit(
        response.fold(
          (errorMessage) => GetTrackingDetailsError(message: errorMessage),
          (response) => GetTrackingDetailsLoaded(
            tripInfo: response,
          ),
        ),
      );
    });

    //!RIDER TRIP ACTIONS
    on<RiderTripActionsEvent>((event, emit) async {
      emit(RiderTripActionsLoading());

      final response = await riderTripDestinationActions(event.params);

      emit(
        response.fold(
          (l) => GenericTripError(errorMessage: l),
          (r) => RiderTripActionsLoaded(
            tripInfo: r,
            isCompleted: event.isCompleted,
          ),
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

  //parse trip request info

  TripRequestInfo parseTripRequestInfo(String json) {
    return TripRequestInfoModel.fromJson(jsonDecode(json));
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

  Future playAlertSound(String path) async {
    return await playSound.call(path);
  }

  Future stopAlertSound() async {
    return await stopSound.call();
  }
}
