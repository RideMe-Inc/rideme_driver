import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rideme_driver/core/enums/directions_svg_enum.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/mixins/url_launcher_mixin.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';
import 'package:rideme_driver/core/widgets/popups/error_popup.dart';
import 'package:rideme_driver/features/authentication/presentation/provider/authentication_provider.dart';
import 'package:rideme_driver/features/home/presentation/pages/home_drawer.dart';
import 'package:rideme_driver/features/home/presentation/provider/home_provider.dart';
import 'package:rideme_driver/features/localization/presentation/providers/locale_provider.dart';
import 'package:rideme_driver/features/trips/domain/entities/directions_object.dart'
    as dob;
import 'package:rideme_driver/features/trips/domain/entities/trip_tracking_details.dart';
import 'package:rideme_driver/features/trips/presentation/bloc/trips_bloc.dart';
import 'package:rideme_driver/features/trips/presentation/provider/trip_provider.dart';
import 'package:rideme_driver/features/trips/presentation/widgets/my_location_section_widget.dart';
import 'package:rideme_driver/features/trips/presentation/widgets/payment/payment_type_selection.dart';
import 'package:rideme_driver/features/trips/presentation/widgets/payment_method_section_widget.dart';
import 'package:rideme_driver/features/trips/presentation/widgets/tracking/collapsed_info_widget.dart';
import 'package:rideme_driver/features/trips/presentation/widgets/tracking/directions_card.dart';
import 'package:rideme_driver/features/trips/presentation/widgets/tracking/swipe_to_arrive.dart';
import 'package:rideme_driver/features/trips/presentation/widgets/tracking/tracking_info_tile_widget.dart';
import 'package:rideme_driver/injection_container.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:html/parser.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class TrackTripPage extends StatefulWidget {
  final String tripId;
  const TrackTripPage({
    super.key,
    required this.tripId,
  });

  @override
  State<TrackTripPage> createState() => _TrackTripPageState();
}

class _TrackTripPageState extends State<TrackTripPage> {
  final tripBloc = sl<TripsBloc>();
  final tripBloc2 = sl<TripsBloc>();

  late HomeProvider homeProvider;
  late TripProvider tripProvider;
  List<dob.Steps> directionSteps = [];
  List<dob.Steps> instructions = [];
  bool isAssigned = true;
  String? totalDistance, totalDuration;

  gl.Position? riderLocation;
  double distanceToEndPoint = 0;
  Location location = Location();

  StreamSubscription<gl.Position>? _positionStreamSubscription;

  fetchTripDetails() {
    final params = {
      "locale": context.read<LocaleProvider>().locale,
      "bearer": context.read<AuthenticationProvider>().token,
      "urlParameters": {
        "id": widget.tripId,
      }
    };

    tripBloc.add(GetTrackingDetailsEvent(params: params));
  }

  callDirectionsApi(Map<String, dynamic> params) {
    tripBloc2.add(GetDirectionsEvent(params: params));
  }

  GoogleMapController? mapController;

  void onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    final position = await gl.Geolocator.getCurrentPosition(
      desiredAccuracy: gl.LocationAccuracy.high,
    );

    mapController!.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 14.5),
    ));
  }

  tripActionDirectionReCalling(TripTrackingDetails? tripTrackingDetails) {
    LatLng destination = LatLng(
      tripTrackingDetails?.nextStop?.lat?.toDouble() ?? 0,
      tripTrackingDetails?.nextStop?.lng?.toDouble() ?? 0,
    );

    final params = {
      "origin_heading":
          tripBloc.returnHeading(riderLocation?.heading.toInt() ?? 0),
      "origin_lat": riderLocation?.latitude,
      "origin_lng": riderLocation?.longitude,
      "destination_lat": destination.latitude,
      "destination_lng": destination.longitude,
    };

    callDirectionsApi(params);
  }

  @override
  void initState() {
    WakelockPlus.enable();

    fetchTripDetails();
    // Start listening to location changes
    _positionStreamSubscription =
        gl.Geolocator.getPositionStream().listen((gl.Position position) async {
      if (directionSteps.isNotEmpty) {
        //UPDATE DIRECTION STEP

        directionSteps = tripBloc.updateStepsIfNeeded(
          currentPolyline: tripProvider.polyCoordinates,
          currentSteps: directionSteps,
        );
        //UPDATE DISTANCE ON A PARTICULAR STEP

        distanceToEndPoint = tripBloc.updateDistanceOnActiveStep(
            currentStep: directionSteps.first, riderLocation: position);

        if (!mounted) return;

        instructions = tripBloc.updateInstructionsIfNeeded(
            currentInstructions: instructions,
            distanceLeft: distanceToEndPoint,
            distanceStepsLength: directionSteps.length,
            context: context,
            totalCurrentDistanceOnStep:
                (directionSteps.first.distance!.value! / 1000));
      }

      riderLocation = position;

      //UPDATE POLYLINE OF RIDER PATH

      if (!mounted) return;

      bool reCallDirectionApi = await tripBloc.reCallDirectionsApi(
          context: context, riderLocation: position);

      if (reCallDirectionApi) {
        LatLng destination = isAssigned
            ? LatLng(
                tripProvider.tripTrackingDetails?.pickupLat?.toDouble() ?? 0,
                tripProvider.tripTrackingDetails?.pickupLng?.toDouble() ?? 0)
            : LatLng(
                tripProvider.tripTrackingDetails?.nextStop?.lat?.toDouble() ??
                    0,
                tripProvider.tripTrackingDetails?.nextStop?.lng?.toDouble() ??
                    0);
        final params = {
          "origin_heading": tripBloc.returnHeading(position.heading.toInt()),
          "origin_lat": position.latitude,
          "origin_lng": position.longitude,
          "destination_lat": destination.latitude,
          "destination_lng": destination.longitude,
        };

        callDirectionsApi(params);
      }

      setState(() {});

      if (mapController != null) {
        mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                riderLocation?.latitude ?? 0,
                riderLocation?.longitude ?? 0,
              ),
              bearing: riderLocation?.heading ?? 0,
              zoom: 17,
            ),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    WakelockPlus.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    homeProvider = context.watch<HomeProvider>();
    tripProvider = context.watch<TripProvider>();

    isAssigned =
        (tripProvider.tripTrackingDetails?.status ?? 'assigned') == 'assigned';

    if (tripProvider.resetDirectionsViaDriverActions) {
      tripActionDirectionReCalling(tripProvider.tripTrackingDetails);
    }
    return MultiBlocListener(
      listeners: [
        BlocListener(
          bloc: tripBloc,
          listener: (context, state) async {
            if (state is GetTrackingDetailsLoaded) {
              tripProvider.updateTripTrackingDetails = state.tripInfo;

              LatLng destination = state.tripInfo.status == 'assigned'
                  ? LatLng(
                      state.tripInfo.pickupLat?.toDouble() ?? 0,
                      state.tripInfo.pickupLng?.toDouble() ?? 0,
                    )
                  : LatLng(
                      state.tripInfo.nextStop?.lat?.toDouble() ?? 0,
                      state.tripInfo.nextStop?.lng?.toDouble() ?? 0,
                    );

              final params = {
                "origin_heading":
                    tripBloc.returnHeading(riderLocation?.heading.toInt() ?? 0),
                "origin_lat": riderLocation?.latitude,
                "origin_lng": riderLocation?.longitude,
                "destination_lat": destination.latitude,
                "destination_lng": destination.longitude,
              };

              callDirectionsApi(params);
            }

            if (state is GetTrackingDetailsError) {
              showErrorPopUp(state.message, context);
            }
          },
        ),
        BlocListener(
          bloc: tripBloc2,
          listener: (context, state) async {
            if (state is GetDirectionsLoaded) {
              tripProvider.updateResetDirectionsViaDriverActions = false;

              tripProvider.decodePolyline(
                  state.directions.routes!.first.overviewPolyline!.points!);

              distanceToEndPoint = 0;

              directionSteps =
                  state.directions.routes!.first.legs!.first.steps!;

              instructions = directionSteps;

              totalDistance =
                  state.directions.routes?.first.legs?.first.distance?.text;
              totalDuration =
                  state.directions.routes?.first.legs?.first.duration?.text;
              //update steps
              setState(() {});

              await tripBloc.playHtmlInstructionSound(
                  instruction:
                      '${parse(instructions.first.htmlInstructions ?? '').body?.text}');
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.grey,
        drawer: const HomeDrawer(),
        body: SlidingUpPanel(
          boxShadow: null,
          minHeight: Sizes.height(context, 0.15),
          color: Colors.transparent,
          body: Stack(
            children: [
              SizedBox(
                height: Sizes.height(context, 0.85),
                child: GoogleMap(
                  myLocationEnabled: false,
                  myLocationButtonEnabled: false,
                  mapType: MapType.terrain,
                  onMapCreated: onMapCreated,
                  polylines: {
                    Polyline(
                      polylineId: const PolylineId('trip_line'),
                      points: tripProvider.polyCoordinates,
                      color: AppColors.rideMeBlueDark,
                      width: 5,
                    ),
                  },
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(44.9706674, -93.3438785),
                    zoom: 16,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('rider_location'),
                      icon: homeProvider.trackingIcon,
                      anchor: const Offset(0.5, 0.5),
                      position: LatLng(riderLocation?.latitude ?? 0,
                          riderLocation?.longitude ?? 0),
                      // rotation: locationData?.heading ?? 0,
                    ),
                    if (tripProvider.polyCoordinates.isNotEmpty)
                      Marker(
                          markerId: const MarkerId('end_location'),
                          icon: homeProvider.endIcon,
                          anchor: const Offset(0.5, 0.5),
                          position: LatLng(
                              tripProvider.polyCoordinates.last.latitude,
                              tripProvider.polyCoordinates.last.longitude))
                  },
                ),
              ),

              //MORE SECTION
              SafeArea(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Builder(builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            height: Sizes.height(context, 0.05),
                            width: Sizes.width(context, 0.2),
                            decoration: const BoxDecoration(
                              color: AppColors.rideMeWhite500,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                  color: AppColors.rideMeGreyNormalActive,
                                  offset: Offset(0, 3.5),
                                )
                              ],
                            ),
                            child: Icon(
                              Icons.menu,
                              color: AppColors.rideMeBlackNormal,
                              size: Sizes.height(context, 0.025),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),

              //DIRECTIONS CARD

              if (instructions.isNotEmpty)
                SafeArea(
                    child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.all(Sizes.height(context, 0.02)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DirectionsCard(
                          maneuverIcon: DirectionsSvgEnum.values
                              .firstWhere(
                                (element) =>
                                    element.maneuver ==
                                    instructions.first.maneuver,
                                orElse: () =>
                                    DirectionsSvgEnum.genericDirection,
                              )
                              .svg,
                          direction:
                              parse(instructions.first.htmlInstructions ?? '')
                                      .body
                                      ?.text ??
                                  '',
                          endLocation: isAssigned
                              ? tripProvider
                                      .tripTrackingDetails?.pickupAddress ??
                                  ''
                              : tripProvider
                                      .tripTrackingDetails?.nextStop?.address ??
                                  '',
                          distance: distanceToEndPoint < 1
                              ? '${distanceToEndPoint * 1000} m'
                              : '$distanceToEndPoint km',
                        ),
                      ],
                    ),
                  ),
                ))
            ],
          ),
          panel: _PanelWidget(
            tripTrackingDetails: tripProvider.tripTrackingDetails,
            distance: totalDistance,
            duration: totalDuration,
          ),
          collapsed: _CollapsedWidget(
            distance: totalDistance,
            duration: totalDuration,
            tripTrackingDetails: tripProvider.tripTrackingDetails,
          ),
        ),
        bottomNavigationBar: Container(
          color: AppColors.rideMeBackgroundLight,
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.height(context, 0.02),
            vertical: Sizes.height(context, 0.029),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwipeToUpdateTripStatus(
                riderLocation: riderLocation,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//!PANEL WIDGET
class _PanelWidget extends StatefulWidget {
  final TripTrackingDetails? tripTrackingDetails;
  final String? distance, duration;
  const _PanelWidget({
    required this.tripTrackingDetails,
    required this.distance,
    required this.duration,
  });

  @override
  State<_PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<_PanelWidget> with UrlLauncherMixin {
  final tripBloc = sl<TripsBloc>();

  cancelTrip() {
    final params = {
      'locale': context.appLocalizations.localeName,
      'bearer': context.read<AuthenticationProvider>().token,
      'urlParameters': {
        'id': widget.tripTrackingDetails?.id.toString(),
      }
    };

    tripBloc.add(CancelTripEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: tripBloc,
      listener: (context, state) {
        if (state is CancelTripLoaded) {
          context.pop();
          context.goNamed('home');
        }

        if (state is CancelTripError) {
          context.pop();
          showErrorPopUp(state.message, context);
        }
      },
      child: Container(
        // height: Sizes.height(context, 0.05),
        padding: EdgeInsets.symmetric(horizontal: Sizes.height(context, 0.02)),
        decoration: const BoxDecoration(
          color: AppColors.rideMeBackgroundLight,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Space.height(context, 0.01),
            Center(
              child: Container(
                width: Sizes.width(context, 0.08),
                height: Sizes.height(context, 0.005),
                decoration: BoxDecoration(
                  color: AppColors.rideMeGreyNormal,
                  borderRadius: BorderRadius.circular(
                    Sizes.height(context, 0.005),
                  ),
                ),
              ),
            ),

            Space.height(context, 0.024),

            //INFO WIDGET
            CollapseInfoWidget(
              status: widget.tripTrackingDetails?.status,
              arrivedAt: widget.tripTrackingDetails?.arrivedAt,
              completedStopsCount:
                  widget.tripTrackingDetails?.completedStopsCount?.toInt(),
              totalStops: widget.tripTrackingDetails?.totalStops?.toInt(),
              user: widget.tripTrackingDetails?.user,
              startedAt: widget.tripTrackingDetails?.nextStop?.startedAt,
              onCallTap: () =>
                  launchCallUrl(widget.tripTrackingDetails?.user.phone ?? ''),

              //TODO: THIS WILL COME FROM THE MAP DIRECTION API
              endTime: '4',
              totalMin: widget.duration,
              totalDistanceLeft: widget.distance,
            ),

            Space.height(context, 0.022),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //TRIP INFORMATION

                    Text(
                      context.appLocalizations.tripInformation,
                      style: context.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.rideMeGreyDarkActive,
                      ),
                    ),
                    Space.height(context, 0.008),

                    MyLocationSectionWidget(
                      pickUp: widget.tripTrackingDetails?.pickupAddress ?? '',
                      dropOff:
                          widget.tripTrackingDetails?.nextStop?.address ?? '',
                      onCancelTap:
                          (widget.tripTrackingDetails?.status ?? 'assigned') ==
                                  'assigned'
                              ? () async {
                                  cancelTrip();

                                  await showAdaptiveDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.rideMeBlueNormal,
                                        ),
                                      );
                                    },
                                  );
                                }
                              : null,
                    ),

                    //CUSTOMER PREFERENCES
                    Text(
                      context.appLocalizations.customerPreferences,
                      style: context.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.rideMeGreyDarkActive,
                      ),
                    ),
                    Space.height(context, 0.008),

                    TrackingInfoTileWidget(
                      label: context.appLocalizations.temperature,
                      value:
                          widget.tripTrackingDetails?.temperature?.toString(),
                    ),
                    TrackingInfoTileWidget(
                      label: context.appLocalizations.music,
                      value: widget.tripTrackingDetails?.music?.toString(),
                    ),
                    TrackingInfoTileWidget(
                      label: context.appLocalizations.conversation,
                      value:
                          widget.tripTrackingDetails?.conversation?.toString(),
                    ),

                    const Divider(
                      color: AppColors.rideMeGreyLightActive,
                    ),

                    Space.height(context, 0.015),
                    PaymentMethodSectionWidget(
                      paymentTypes: PaymentTypes.values.firstWhere(
                        (element) =>
                            element.name ==
                            (widget.tripTrackingDetails?.paymentMethod ??
                                'cash'),
                      ),
                      amount: widget.tripTrackingDetails?.amountCharged ?? 0,
                    ),
                    Space.height(context, 0.02),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//!COLLAPSED WIDGET
class _CollapsedWidget extends StatelessWidget with UrlLauncherMixin {
  const _CollapsedWidget({
    required this.tripTrackingDetails,
    required this.distance,
    required this.duration,
  });

  final TripTrackingDetails? tripTrackingDetails;

  final String? distance, duration;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: Sizes.height(context, 0.05),
      padding: EdgeInsets.symmetric(horizontal: Sizes.height(context, 0.02)),
      decoration: const BoxDecoration(
        color: AppColors.rideMeBackgroundLight,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Space.height(context, 0.01),
          Center(
            child: Container(
              width: Sizes.width(context, 0.08),
              height: Sizes.height(context, 0.005),
              decoration: BoxDecoration(
                color: AppColors.rideMeGreyNormal,
                borderRadius: BorderRadius.circular(
                  Sizes.height(context, 0.005),
                ),
              ),
            ),
          ),

          Space.height(context, 0.024),

          //INFO WIDGET
          CollapseInfoWidget(
            status: tripTrackingDetails?.status,
            arrivedAt: tripTrackingDetails?.arrivedAt,
            completedStopsCount:
                tripTrackingDetails?.completedStopsCount?.toInt(),
            totalStops: tripTrackingDetails?.totalStops?.toInt(),
            user: tripTrackingDetails?.user,
            startedAt: tripTrackingDetails?.nextStop?.startedAt,
            onCallTap: () =>
                launchCallUrl(tripTrackingDetails?.user.phone ?? ''),

            //TODO: WORK ON WAITING TIME
            endTime: '4',
            totalMin: duration,
            totalDistanceLeft: distance,
          )
        ],
      ),
    );
  }
}
