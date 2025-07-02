import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:rideme_driver/assets/svgs/svg_name_constants.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';
import 'package:rideme_driver/core/widgets/popups/error_popup.dart';
import 'package:rideme_driver/features/authentication/presentation/provider/authentication_provider.dart';

import 'package:rideme_driver/features/trips/presentation/bloc/trips_bloc.dart';

import 'package:rideme_driver/features/trips/presentation/provider/trip_provider.dart';

import 'package:rideme_driver/injection_container.dart';

class SwipeToUpdateTripStatus extends StatefulWidget {
  final Position? riderLocation;
  const SwipeToUpdateTripStatus({
    super.key,
    required this.riderLocation,
  });

  @override
  State<SwipeToUpdateTripStatus> createState() =>
      _SwipeToUpdateTripStatusState();
}

class _SwipeToUpdateTripStatusState extends State<SwipeToUpdateTripStatus> {
  final tripBloc = sl<TripsBloc>();
  late TripProvider provider;

  bool didDismiss = false;

  driverActions() {
    final params = {
      "locale": context.appLocalizations.localeName,
      "bearer": context.read<AuthenticationProvider>().token,
      "body": {
        "lat": widget.riderLocation?.latitude,
        "lng": widget.riderLocation?.longitude,
      },
      "urlParameters": {
        "id": provider.tripTrackingDetails?.id.toString(),
        "actions": tripBloc.tripActionId(
            tripTrackingDetails: provider.tripTrackingDetails),
      }
    };

    tripBloc.add(RiderTripActionsEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    provider = context.watch<TripProvider>();

    return BlocListener(
      bloc: tripBloc,
      listener: (context, state) {
        if (state is RiderTripActionsLoaded) {
          //TODO: CHECK FOR NAVIGATING TO PRICING PAGE
          context.pop();
          provider.updateTripTrackingDetails = state.tripInfo;
          provider.updateResetDirectionsViaDriverActions = true;
          setState(() {
            didDismiss = !didDismiss;
          });
        }
        if (state is RiderTripActionsError) {
          if (kDebugMode) print(state.message);
          context.pop();
          showErrorPopUp(state.message, context);
          setState(() {
            didDismiss = !didDismiss;
          });
        }
      },
      child: Container(
        height: Sizes.height(context, 0.06),
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.rideMeBlueNormal,
            borderRadius: BorderRadius.circular(51)),
        child: didDismiss
            ? Center(
                child: Dismissible(
                  key: UniqueKey(),
                  child: const Row(),
                ),
              )
            :

            //SIMULATE BRINGING THE DISMISSABLE BACK BY GIVING A BOOLEAN THAT WILL BE SENT ON DRAG AND RESET ON ANY OF THE STATES EMITTED

            Center(
                child: Dismissible(
                  key: UniqueKey(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: Sizes.height(context, 0.005)),
                        child: CircleAvatar(
                          radius: Sizes.height(context, 0.025),
                          backgroundColor: AppColors.rideMeBackgroundLight,
                          child: SvgPicture.asset(
                            SvgNameConstants.swipeSVG,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Sizes.width(context, 0.4),
                        child: Center(
                          child: Text(
                            tripBloc.tripActionInfo(
                                tripTrackingDetails:
                                    provider.tripTrackingDetails,
                                context: context),
                            style: context.textTheme.displayMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: AppColors.rideMeBackgroundLight,
                            ),
                          ),
                        ),
                      ),
                      Space.width(context, 0.15)
                    ],
                  ),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      return true;
                    }

                    return false;
                  },
                  onDismissed: (direction) async {
                    setState(() {
                      didDismiss = !didDismiss;
                    });

                    driverActions();

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
                  },
                ),
              ),
      ),
    );
  }
}
