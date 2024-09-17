import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rideme_driver/core/extensions/date_extension.dart';

import 'package:rideme_driver/features/trips/data/models/trip_destnation_info_model.dart';
import 'package:rideme_driver/features/trips/data/models/trip_request_info_model.dart';
import 'package:rideme_driver/features/trips/domain/entities/all_trips_details.dart';
import 'package:rideme_driver/features/trips/domain/entities/directions_object.dart';
import 'package:rideme_driver/features/trips/domain/entities/trip_destination_data.dart';

import 'package:equatable/equatable.dart';
import 'package:rideme_driver/features/trips/domain/entities/all_trips_info.dart';

import 'package:rideme_driver/features/trips/domain/entities/trip_destination_info.dart';
import 'package:rideme_driver/features/trips/domain/entities/trip_request_info.dart';
import 'package:rideme_driver/features/trips/domain/entities/trip_tracking_details.dart';
import 'package:rideme_driver/features/trips/domain/usecases/accept_reject_trip.dart';

import 'package:rideme_driver/features/trips/domain/usecases/cancel_trip.dart';

import 'package:rideme_driver/features/trips/domain/usecases/get_all_trips.dart';
import 'package:rideme_driver/features/trips/domain/usecases/get_directions.dart';
import 'package:rideme_driver/features/trips/domain/usecases/get_tracking_details.dart';

import 'package:rideme_driver/features/trips/domain/usecases/get_trip_info.dart';
import 'package:rideme_driver/features/trips/domain/usecases/get_trip_status.dart';
import 'package:rideme_driver/features/trips/domain/usecases/play_sound.dart';

import 'package:rideme_driver/features/trips/domain/usecases/rate_trip.dart';
import 'package:rideme_driver/features/trips/domain/usecases/report_trip.dart';
import 'package:rideme_driver/features/trips/domain/usecases/rider_trip_destination_actions.dart';
import 'package:rideme_driver/features/trips/domain/usecases/stop_sound.dart';
import 'package:rideme_driver/features/trips/presentation/provider/trip_provider.dart';

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
  final GetDirections getDirections;
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
    required this.getDirections,
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

    //!GET DIRECTIONS
    on<GetDirectionsEvent>((event, emit) async {
      emit(GetDirectionsLoading());

      final response = await getDirections(event.params);

      emit(
        response.fold(
          (error) => GetDirectionsError(error: error),
          (response) => GetDirectionsLoaded(directions: response),
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

  Future playAlertSound(String path) async {
    return await playSound.call(path);
  }

  Future stopAlertSound() async {
    return await stopSound.call();
  }

  String dropOffString(
      {required int totalStops, required int completedStopsCount}) {
    if (totalStops - completedStopsCount == 1) {
      return 'Drop off ';
    } else {
      return totalStops - completedStopsCount == 2
          ? 'Going to stop '
          : 'Going to stop ${completedStopsCount + 1} ';
    }
  }

  //get distance between rider and user
  Future<double> getDistanceFromLatLonInKm({
    required LocationData currentLocation,
    required LatLng endPoint,
  }) async {
    final stringgyDistance = convertToKM(
      pickup:
          LatLng(currentLocation.latitude ?? 0, currentLocation.longitude ?? 0),
      dropOff: endPoint,
    );

    return double.parse(stringgyDistance);
  }

  String convertToKM({required LatLng pickup, required LatLng dropOff}) {
    const radius = 6371; // Radius of the earth in km
    final dLat = degToRad(pickup.latitude - dropOff.latitude); // degToRad below
    final dLon = degToRad(pickup.longitude - dropOff.longitude);
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(degToRad(dropOff.latitude)) *
            cos(degToRad(pickup.latitude)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    final distance = radius * c; // Distance in km

    return distance.toStringAsFixed(2);
  }

  //degree to radians

  double degToRad(deg) {
    return (deg * pi) / 180;
  }

  Future<bool> reCallDirectionsApi(
      {required BuildContext context, required Position riderLocation}) async {
    bool callGoogle = false;
    List<LatLng> polyCoordinates = context.read<TripProvider>().polyCoordinates;

    final latLngPosition =
        LatLng(riderLocation.latitude, riderLocation.longitude);

    if (polyCoordinates.length > 1) {
      for (int i = 0; i < polyCoordinates.length; i++) {
        if (i + 1 == polyCoordinates.length) {
          return false;
        }
        final distanceKm1 = double.parse(
            convertToKM(pickup: latLngPosition, dropOff: polyCoordinates[i]));
        final distanceKm2 = double.parse(convertToKM(
            pickup: latLngPosition, dropOff: polyCoordinates[i + 1]));

        if (distanceKm1 > distanceKm2) {
          //meaning he is on the right path

          polyCoordinates.removeRange(i, i + 1);
        } else {
          //there is a deviation. check for upward adjustment

          if (distanceKm1 > 0.05) {
            callGoogle = true;
          } else {
            break;
          }
        }
      }
    }

    context.read<TripProvider>().updatePolyCoordinates = polyCoordinates;

    if (!context.mounted) return false;

    return callGoogle;
  }

  //UPDATE STEPS IF NEEDED

  List<Steps> updateStepsIfNeeded(
      {required List<Steps> currentSteps,
      required List<LatLng> currentPolyline}) {
    // print(currentPolyline);
    // print(
    //     '${currentSteps.first.endLocation?.lat} ${currentSteps.first.endLocation?.lng}');

    List<Steps> holderSteps = currentSteps;

    if (currentSteps.isEmpty) {
      return currentSteps;
    }

    for (var step in holderSteps) {
      if (currentPolyline.contains(LatLng(
          double.parse(step.endLocation!.lat!.toStringAsFixed(5)),
          double.parse(step.endLocation!.lng!.toStringAsFixed(5))))) {
        return currentSteps;
      } else {
        currentSteps.remove(step);
      }
    }

    return currentSteps;
  }

  //UPDATE DISTANCE
  double updateDistanceOnActiveStep(
      {required Steps currentStep, required Position riderLocation}) {
    return double.parse(convertToKM(
        pickup: LatLng(riderLocation.latitude, riderLocation.longitude),
        dropOff: LatLng(
            currentStep.endLocation!.lat!, currentStep.endLocation!.lng!)));
  }

  List<Steps> updateInstructionsIfNeeded(
      {required List<Steps> currentInstructions,
      required double distanceLeft}) {
    if (currentInstructions.length <= 1) {
      return currentInstructions;
    }

    if (distanceLeft < 0.11) {
      currentInstructions.removeAt(0);

      return currentInstructions;
    }

    return currentInstructions;
  }

  int returnHeading(int heading) {
    if (heading < 0) {
      return heading + 360;
    }

    return heading;
  }
}
