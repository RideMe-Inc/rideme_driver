import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';
import 'package:rideme_driver/core/widgets/buttons/generic_button_widget.dart';
import 'package:rideme_driver/core/widgets/popups/error_popup.dart';
import 'package:rideme_driver/features/authentication/presentation/provider/authentication_provider.dart';
import 'package:rideme_driver/features/localization/presentation/providers/locale_provider.dart';
import 'package:rideme_driver/features/trips/domain/entities/trip_tracking_details.dart';
import 'package:rideme_driver/features/trips/presentation/bloc/trips_bloc.dart';
import 'package:rideme_driver/features/trips/presentation/widgets/tracking/collapsed_info_widget.dart';
import 'package:rideme_driver/injection_container.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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

  late GoogleMapController mapController;

  void onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 14.5),
    ));
  }

  @override
  void initState() {
    fetchTripDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: tripBloc,
      listener: (context, state) {
        if (state is GetTrackingDetailsLoaded) {
          setState(() {
            tripTrackingDetails = state.tripInfo;
          });
        }

        if (state is GetTrackingDetailsError) {
          showErrorPopUp(state.message, context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: SlidingUpPanel(
          boxShadow: null,
          minHeight: Sizes.height(context, 0.13),
          color: Colors.transparent,
          body: SizedBox(
            height: Sizes.height(context, 0.85),
            child: GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              mapType: MapType.terrain,
              onMapCreated: onMapCreated,
              initialCameraPosition: const CameraPosition(
                target: LatLng(
                  0,
                  0,
                ),
                zoom: 16,
              ),
            ),
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
              GenericButton(onTap: () {}, label: 'label', isActive: true),
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
          )
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
