import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rideme_driver/core/enums/directions_svg_enum.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';
import 'package:rideme_driver/core/widgets/buttons/generic_button_widget.dart';
import 'package:rideme_driver/core/widgets/popups/error_popup.dart';
import 'package:rideme_driver/features/authentication/presentation/provider/authentication_provider.dart';
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
import 'package:rideme_driver/injection_container.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:html/parser.dart';

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

  LocationData? riderLocation;
  double distanceToEndPoint = 0;
  Location location = Location();

  TripTrackingDetails? tripTrackingDetails;

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

  //nasty line; should be looked at later

  locationListenerEvent() async {
    location.onLocationChanged.listen(
      (event) async {
        if (directionSteps.isNotEmpty) {
          //UPDATE DISTANCE ON A PARTICULAR STEP

          distanceToEndPoint = tripBloc.updateDistanceOnActiveStep(
              currentStep: directionSteps.first, riderLocation: event);

          //UPDATE DIRECTION STEP

          directionSteps = tripBloc.updateStepsIfNeeded(
            currentPolyline: tripProvider.polyCoordinates,
            currentSteps: directionSteps,
          );

          instructions = tripBloc.updateInstructionsIfNeeded(
              currentInstructions: instructions,
              distanceLeft: distanceToEndPoint);
        }

        riderLocation = event;

        //UPDATE POLYLINE OF RIDER PATH

        if (!mounted) return;

        bool reCallDirectionApi = await tripBloc.reCallDirectionsApi(
            context: context, riderLocation: event);

        if (reCallDirectionApi) {
          LatLng destination = isAssigned
              ? LatLng(tripTrackingDetails?.pickupLat?.toDouble() ?? 0,
                  tripTrackingDetails?.pickupLng?.toDouble() ?? 0)
              : LatLng(tripTrackingDetails?.nextStop?.lat?.toDouble() ?? 0,
                  tripTrackingDetails?.nextStop?.lng?.toDouble() ?? 0);
          final params = {
            "origin_heading":
                tripBloc.returnHeading(event.heading?.toInt() ?? 0),
            "origin_lat": event.latitude,
            "origin_lng": event.longitude,
            "destination_lat": destination.latitude,
            "destination_lng": destination.longitude,
          };

          callDirectionsApi(params);
        }

        setState(() {});

        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(
                  riderLocation?.latitude ?? 0,
                  riderLocation?.longitude ?? 0,
                ),
                bearing: riderLocation?.heading ?? 0,
                zoom: 17),
          ),
        );
      },
    );
  }

  late GoogleMapController mapController;

  void onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    final position = await gl.Geolocator.getCurrentPosition(
      desiredAccuracy: gl.LocationAccuracy.high,
    );

    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 14.5),
    ));

    locationListenerEvent();
  }

  @override
  void initState() {
    fetchTripDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    homeProvider = context.watch<HomeProvider>();
    tripProvider = context.watch<TripProvider>();

    isAssigned = (tripTrackingDetails?.status ?? 'assigned') == 'assigned';
    return MultiBlocListener(
      listeners: [
        BlocListener(
          bloc: tripBloc,
          listener: (context, state) async {
            if (state is GetTrackingDetailsLoaded) {
              setState(() {
                tripTrackingDetails = state.tripInfo;
              });

              LatLng destination = state.tripInfo.status == 'assigned'
                  ? LatLng(state.tripInfo.pickupLat?.toDouble() ?? 0,
                      state.tripInfo.pickupLng?.toDouble() ?? 0)
                  : LatLng(state.tripInfo.nextStop?.lat?.toDouble() ?? 0,
                      state.tripInfo.nextStop?.lng?.toDouble() ?? 0);

              final position = await gl.Geolocator.getCurrentPosition(
                desiredAccuracy: gl.LocationAccuracy.high,
              );

              final params = {
                "origin_heading":
                    tripBloc.returnHeading(position.heading.toInt()),
                "origin_lat": position.latitude,
                "origin_lng": position.longitude,
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
          listener: (context, state) {
            if (state is GetDirectionsLoaded) {
              tripProvider.decodePolyline(
                  state.directions.routes!.first.overviewPolyline!.points!);

              distanceToEndPoint = 0;

              directionSteps =
                  state.directions.routes!.first.legs!.first.steps!;

              instructions = directionSteps;
              //update steps
              setState(() {});
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.grey,
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
                      polylineId: PolylineId('trip_line'),
                      points: tripProvider.polyCoordinates,
                      color: AppColors.rideMeBlueDark,
                      width: 5,
                    ),
                  },
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(
                      0,
                      0,
                    ),
                    zoom: 16,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('rider_location'),
                      icon: homeProvider.customMarkerIcon,
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

              //DIRECTIONS CARD

              if (instructions.isNotEmpty)
                SafeArea(
                    child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.all(Sizes.height(context, 0.02)),
                    child: Column(
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
                          //TODO: CONVERT HTML STRING TO NORMAL STRING
                          // direction: instructions.first.htmlInstructions ?? '',
                          direction:
                              parse(instructions.first.htmlInstructions ?? '')
                                      .body
                                      ?.text ??
                                  '',
                          endLocation: isAssigned
                              ? tripTrackingDetails?.pickupAddress ?? ''
                              : tripTrackingDetails?.nextStop?.address ?? '',
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
            tripTrackingDetails: tripTrackingDetails,
          ),
          collapsed: _CollapsedWidget(
            user: tripTrackingDetails?.user,
            status: tripTrackingDetails?.status,
            arrivedAt: tripTrackingDetails?.arrivedAt,
            completedStopsCount:
                tripTrackingDetails?.completedStopsCount?.toInt(),
            totalStops: tripTrackingDetails?.totalStops?.toInt(),
          ),
        ),

        //TODO: BUTTONS HERE; COMPLETE BUILD
        bottomNavigationBar: Container(
          color: AppColors.rideMeBackgroundLight,
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.height(context, 0.02),
            vertical: Sizes.height(context, 0.029),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GenericButton(
                onTap: () {},
                label: 'label',
                isActive: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//!PANEL WIDGET
class _PanelWidget extends StatelessWidget {
  final TripTrackingDetails? tripTrackingDetails;
  const _PanelWidget({required this.tripTrackingDetails});

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

            //TODO: THIS WILL COME FROM THE MAP DIRECTION API
            endTime: '4',
            totalMin: '5',
            totalDistanceLeft: 20,
          ),

          Space.height(context, 0.022),
          MyLocationSectionWidget(
              pickUp: tripTrackingDetails?.pickupAddress ?? '',
              dropOff: tripTrackingDetails?.nextStop?.address ?? ''),
          Space.height(context, 0.03),
          PaymentMethodSectionWidget(
            paymentTypes: PaymentTypes.values.firstWhere(
              (element) =>
                  element.name ==
                  (tripTrackingDetails?.paymentMethod ?? 'cash'),
            ),
            amount: tripTrackingDetails?.amountCharged ?? 0,
            onEditTap: () {},
          ),
          Space.height(context, 0.042),
        ],
      ),
    );
  }
}

//!COLLAPSED WIDGET
class _CollapsedWidget extends StatelessWidget {
  const _CollapsedWidget(
      {required this.user,
      required this.status,
      required this.arrivedAt,
      required this.completedStopsCount,
      required this.totalStops});
  final RiderInfo? user;
  final String? status;
  final String? arrivedAt;
  final int? completedStopsCount, totalStops;

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
            status: status,
            arrivedAt: arrivedAt,
            completedStopsCount: completedStopsCount,
            totalStops: totalStops,
            user: user,

            //TODO: THIS WILL COME FROM THE MAP DIRECTION API
            endTime: '4',
            totalMin: '5',
            totalDistanceLeft: 20,
          )
        ],
      ),
    );
  }
}
