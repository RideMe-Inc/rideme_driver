import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rideme_driver/assets/svgs/svg_name_constants.dart';

import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';

import 'package:rideme_driver/features/home/presentation/provider/home_provider.dart';
import 'package:rideme_driver/features/home/presentation/widgets/home_profile_widget.dart';

import 'package:rideme_driver/features/permissions/presentation/bloc/permission_bloc.dart';
import 'package:rideme_driver/features/user/domain/entities/user.dart';
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

  late GoogleMapController mapController;

  void onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    if (homeProvider.isLocationAllowed) {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 14.5),
      ));
    }
  }

  @override
  void initState() {
    permissionBloc.add(RequestLocationPemEvent());

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
              height: double.infinity,
              child: GoogleMap(
                myLocationEnabled: true,
                mapType: MapType.terrain,
                myLocationButtonEnabled: false,
                onMapCreated: onMapCreated,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(44.9706674, -93.3438785),
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
                            CircleAvatar(
                              radius: Sizes.height(context, 0.03),
                            ),
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
                        topLeft: Radius.circular(Sizes.height(context, 0.02)),
                        topRight: Radius.circular(Sizes.height(context, 0.02)),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
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
                        Space.height(context, 0.016),
                        const HomeUserProfileWidget(
                            user: User(
                          id: null,
                          rating: null,
                          firstName: 'Isaiah',
                          lastName: 'Amo Mensah',
                          phone: null,
                          email: null,
                          profileUrl: null,
                          status: 'offline',
                          requestedDeletion: null,
                          ongoingTrip: null,
                          hasLicense: null,
                          hasVehicle: null,
                          photoCheckRequired: null,
                        )),
                        Space.height(context, 0.037),
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
