import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rideme_driver/assets/svgs/svg_name_constants.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';

import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';

import 'package:rideme_driver/features/home/presentation/provider/home_provider.dart';

import 'package:rideme_driver/features/permissions/presentation/bloc/permission_bloc.dart';
import 'package:rideme_driver/injection_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AppLocalizations appLocalizations;

  late HomeProvider homeProvider;

  final permissionBloc = sl<PermissionBloc>();

  Set<Marker> markers = {};
  DateTime chosenDate = DateTime.now();
  BitmapDescriptor customIcon = BitmapDescriptor.defaultMarker;

  double? lat;
  double? lng;

  // fetchRiders(Position position) async {
  //   final params = {
  //     "event": "riders-near-me",
  //     "data": {
  //       "lng": position.longitude,
  //       "lat": position.latitude,
  //       "radius": 5,
  //     }
  //   };

  //   homeBloc.add(FetchRidersNearMeEvent(params: params));
  // }

  // fetchTopLocations() {
  //   final params = {
  //     "locale": context.read<LocaleProvider>().locale,
  //     "bearer": 'Bearer ${context.read<HomeProvider>().refreshedToken}'
  //   };

  //   homeBloc.add(GetTopLocationsEvent(params: params));
  // }

  late GoogleMapController mapController;

  void onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    if (homeProvider.isLocationAllowed) {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // fetchRiders(position);

      // final params = {
      //   "locale": appLocalizations.localeName,
      //   "queryParams": {
      //     "lat": position.latitude.toString(),
      //     "lng": position.longitude.toString(),
      //   },
      // };

      // tripsBloc.add(GetGeoIDEvent(params: params, isPickUp: true));
      // getServiceInfo(lat: position.latitude, lng: position.longitude);

      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 14.5),
      ));
    }
  }

  // getServiceInfo({required double lat, required double lng}) {
  //   final params = {
  //     "locale": appLocalizations.localeName,
  //     "bearer": "Bearer ${context.read<HomeProvider>().refreshedToken}",
  //     "queryParams": {
  //       "lat": lat.toString(),
  //       "lng": lng.toString(),
  //     },
  //   };

  //   homeBloc2.add(GetServiceInfoEvent(params: params));
  // }

  @override
  void initState() {
    // user = userBloc.getCachedUserWithoutSafety();
    permissionBloc.add(RequestLocationPemEvent());
    // fetchTopLocations();
    // PushNotificationHandler(
    //   context: context,
    //   localNotificationsPlugin: FlutterLocalNotificationsPlugin(),
    //   messaging: FirebaseMessaging.instance,
    // );
    super.initState();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context)!;
    homeProvider = context.watch<HomeProvider>();

    return Scaffold(
      // drawer: const HomeDrawer(),

      body: BlocListener(
        bloc: permissionBloc,
        listener: (context, state) {
          // homeProvider.setNumberOfActiveTrips = user?.ongoingTrips?.length ?? 0;
          if (state is LocationPemDeclined) {
            homeProvider.updateLocationAllowed = false;
          }
        },
        child: Stack(
          children: [
            SizedBox(
              height: Sizes.height(context, 0.8),
              child: GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                onMapCreated: onMapCreated,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(5.6651369, -0.202062),
                  zoom: 15,
                ),
                markers: homeProvider.markers,
              ),
            ),

            //MORE SECTION
            SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: Builder(builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      // Scaffold.of(context).openDrawer();
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

            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
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
                              onTap: homeProvider.isLocationAllowed
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

                  //container
                  Container(
                    width: Sizes.width(context, 1),
                    // height: Sizes.height(context, 0.42),
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizes.width(context, 0.04),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.rideMeBackgroundLight,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Sizes.height(context, 0.03)),
                        topRight: Radius.circular(Sizes.height(context, 0.03)),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Space.height(context, 0.007),
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

                        Space.height(context, 0.014),
                        Text(
                          context.appLocalizations.helloThere('Simon'),
                          style: context.textTheme.displayLarge?.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        Space.height(context, 0.016),

                        // Column(
                        //   children: homeProvider.topLocations
                        //       .map(
                        //         (location) => DropOffLocationSections(
                        //           sectionType: SectionType.suggestions,
                        //           place: location,
                        //           isLast: homeProvider.topLocations
                        //                   .indexOf(location) ==
                        //               homeProvider.topLocations.length - 1,
                        //           topLocationOnTap: (p0) {
                        //             Map locations = {
                        //               "pickUp": [
                        //                 homeProvider.isLocationAllowed
                        //                     ? {
                        //                         "name": homeProvider
                        //                             .geoDataInfo?.address,
                        //                         "id": homeProvider
                        //                             .geoDataInfo?.id,
                        //                         "lat": homeProvider
                        //                             .geoDataInfo?.lat,
                        //                         "lng": homeProvider
                        //                             .geoDataInfo?.lng,
                        //                       }
                        //                     : {}
                        //               ],
                        //               "dropOff": [
                        //                 {
                        //                   'id': p0?.id,
                        //                   'name': p0?.address,
                        //                   'lat': p0?.lat,
                        //                   'lng': p0?.lng,
                        //                 }
                        //               ],
                        //             };
                        //             final tripData = jsonEncode(locations);
                        //             context.pushNamed('tripInfo',
                        //                 queryParameters: {
                        //                   "tripData": tripData,
                        //                   "scheduledDate": null.toString(),
                        //                 });
                        //           },
                        //         ),
                        //       )
                        //       .toList(),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
