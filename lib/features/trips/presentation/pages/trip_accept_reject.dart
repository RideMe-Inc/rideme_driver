import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:rideme_driver/assets/sounds/sound_name_constants.dart';
import 'package:rideme_driver/assets/svgs/svg_name_constants.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';

import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';

import 'package:rideme_driver/core/theme/app_colors.dart';
import 'package:rideme_driver/core/widgets/buttons/generic_button_widget.dart';
import 'package:rideme_driver/core/widgets/loaders/loading_indicator.dart';
import 'package:rideme_driver/core/widgets/popups/error_popup.dart';
import 'package:rideme_driver/features/home/presentation/provider/home_provider.dart';
import 'package:rideme_driver/features/trips/domain/entities/trip_request_info.dart';
import 'package:rideme_driver/features/trips/presentation/bloc/trips_bloc.dart';
import 'package:rideme_driver/features/trips/presentation/provider/trip_provider.dart';
import 'package:rideme_driver/features/trips/presentation/widgets/ride_request_timer.dart';
import 'package:rideme_driver/injection_container.dart';

class TripAcceptRejectPage extends StatefulWidget {
  final String tripRequestInfo;
  const TripAcceptRejectPage({
    super.key,
    required this.tripRequestInfo,
  });

  @override
  State<TripAcceptRejectPage> createState() => _TripAcceptRejectPageState();
}

class _TripAcceptRejectPageState extends State<TripAcceptRejectPage> {
  final tripsBloc = sl<TripsBloc>();

  List<Color> colors = [
    AppColors.rideMeBlueDarker,
    AppColors.rideMeBlueDarkActive,
    AppColors.rideMeBlueDarkHover,
    AppColors.rideMeBlueDark,
    AppColors.rideMeBlueNormalActive,
    AppColors.rideMeBlueNormalHover,
  ];

  TripRequestInfo? tripRequestInfo;
  Color currentColor = AppColors.rideMeBlueDarker;
  Timer? timer;
  late Timer colorTimer;
  late TripProvider tripProvider;

  int seconds = 15;
  int currentIndex = 0;
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

    tripProvider.decodePolyline(tripRequestInfo!.polyline);
  }

  acceptOrRejectTrip({required bool isRejectTrip}) async {
    timer!.cancel();
    colorTimer.cancel();
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    if (!mounted) return;
    final params = {
      "locale": context.appLocalizations.localeName,
      "bearer": "Bearer ${context.read<HomeProvider>().refreshedToken}",
      "body": {
        "lat": position.latitude,
        "lng": position.longitude,
      },
      "type": isRejectTrip ? 'reject' : 'accept',
      "urlParameters": {"tripId": tripRequestInfo!.id},
    };

    //send event

    tripsBloc.add(AcceptRejectTripEvent(params: params));
  }

  countdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds == 0) {
        timer.cancel();
        // context.goNamed('home');
      } else if (seconds > 0) {
        seconds--;
        setState(() {});
      }
    });
  }

  playSound() {
    tripsBloc.playAlertSound(SoundsNameConstants.alertSound);
  }

  @override
  void initState() {
    countdown();
    tripRequestInfo = tripsBloc.parseTripRequestInfo(widget.tripRequestInfo);
    playSound();

    colorTimer = Timer.periodic(
      const Duration(milliseconds: 500),
      (timer) {
        setState(() {
          currentIndex = (currentIndex + 1) % colors.length;
          currentColor = colors[currentIndex];
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    colorTimer.cancel();
    tripsBloc.stopAlertSound();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    tripProvider = context.watch<TripProvider>();
    return Scaffold(
      body: BlocListener(
        bloc: tripsBloc,
        listener: (context, state) {
          if (state is AcceptRejectTripLoaded) {
            if (state.isReject) {
              context.goNamed('home');
              return;
            }

            context.goNamed(
              'trackTrip',
              queryParameters: {
                "tripId": tripRequestInfo?.id.toString(),
              },
            );
          }
          if (state is GenericTripError) {
            showErrorPopUp(state.errorMessage, context);
          }
        },
        child: Stack(
          children: [
            SizedBox(
              height: Sizes.height(context, 0.85),
              child: GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                onMapCreated: onMapCreated,
                polylines: {
                  Polyline(
                    polylineId: const PolylineId('tripacceptreject'),
                    color: AppColors.rideMeBlueNormalActive,
                    width: 4,
                    points: tripProvider.polyCoordinates,
                  )
                },
                initialCameraPosition: const CameraPosition(
                  target: LatLng(
                    0,
                    0,
                  ),
                  zoom: 16,
                ),
              ),
            ),

            //MORE SECTION
            SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: Builder(builder: (context) {
                  return BlocBuilder(
                    bloc: tripsBloc,
                    builder: (context, state) {
                      if (state is AcceptRejectTripLoading) {
                        return const LoadingIndicator(
                          indicatorColor: AppColors.rideMeErrorNormal,
                        );
                      }
                      return GestureDetector(
                        onTap: () {
                          acceptOrRejectTrip(isRejectTrip: true);
                        },
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              // height: Sizes.height(context, 0.05),
                              // width: Sizes.width(context, 0.2),
                              margin: EdgeInsets.only(
                                  right: Sizes.height(context, 0.02)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: Sizes.height(context, 0.023),
                                  vertical: Sizes.height(context, 0.007)),
                              decoration: BoxDecoration(
                                color: AppColors.rideMeErrorNormal,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                    color: AppColors.rideMeGreyNormalActive,
                                    offset: Offset(0, 3.5),
                                  )
                                ],
                              ),
                              child: Text(
                                'Decline',
                                style: context.textTheme.displayLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: AppColors.rideMeWhite400),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            ),

            //MODAL SHEET

            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizes.width(context, 0.04),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(SvgNameConstants.googleLogoSVG),
                            GestureDetector(
                              onTap: context
                                      .read<HomeProvider>()
                                      .isLocationAllowed
                                  ? () async {
                                      final position =
                                          await Geolocator.getCurrentPosition(
                                        desiredAccuracy: LocationAccuracy.high,
                                      );

                                      mapController.animateCamera(
                                          CameraUpdate.newLatLng(LatLng(
                                              position.latitude,
                                              position.longitude)));
                                    }
                                  : null,
                              child: CircleAvatar(
                                radius: Sizes.height(context, 0.024),
                                backgroundColor:
                                    AppColors.rideMeBackgroundLight,
                                child: Icon(
                                  Icons.near_me_outlined,
                                  color: AppColors.rideMeBlackNormal,
                                  size: Sizes.height(
                                    context,
                                    0.03,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Space.height(context, 0.01),
                      ],
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    // height: Sizes.height(context, 0.43),
                    margin: EdgeInsets.only(
                      top: Sizes.height(context, 0.02),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizes.width(context, 0.04),
                      vertical: Sizes.height(context, 0.02),
                    ),
                    decoration: BoxDecoration(
                        color: currentColor,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(Sizes.height(context, 0.03)),
                        )),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Sizes.width(context, 0.6),
                              child: Text(
                                tripRequestInfo?.pickupAddress ?? '',
                                style: context.textTheme.displayLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.rideMeBackgroundLight,
                                ),
                              ),
                            ),
                            _UserInfoRating(
                              name: tripRequestInfo?.riderName ?? '',
                              rating: tripRequestInfo?.rating ?? 0,
                            )
                          ],
                        ),
                        Space.height(context, 0.041),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              tripRequestInfo?.timeToPickup != null
                                  ? DateFormat('m').format(
                                      DateFormat('Hms', 'en_US')
                                          .parse(tripRequestInfo!.timeToPickup),
                                    )
                                  : '5',
                              style: context.textTheme.displayLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.rideMeBackgroundLight,
                              ),
                            ),
                            RideRequestTimer(
                              timer: timer,
                              seconds: seconds,
                            ),
                            Text(
                              '${tripRequestInfo?.distanceToPickup ?? 0} km',
                              style: context.textTheme.displayLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.rideMeBackgroundLight,
                              ),
                            ),
                          ],
                        ),
                        Space.height(context, 0.045),
                        BlocBuilder(
                          bloc: tripsBloc,
                          builder: (context, state) {
                            if (state is AcceptRejectTripLoading) {
                              return const LoadingIndicator();
                            }

                            return GenericButton(
                              onTap: () {
                                acceptOrRejectTrip(isRejectTrip: false);
                              },
                              label: context.appLocalizations.accept,
                              isActive: true,
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserInfoRating extends StatelessWidget {
  final String name;
  final num rating;
  const _UserInfoRating({
    required this.name,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          name,
          style: context.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.rideMeBackgroundLight,
          ),
        ),
        Space.width(context, 0.01),
        Text(
          '$rating',
          style: context.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.rideMeBackgroundLight,
          ),
        ),
        Space.width(context, 0.005),
        Icon(
          Icons.star,
          color: AppColors.rideMeBackgroundLight,
          size: Sizes.height(context, 0.018),
        )
      ],
    );
  }
}
