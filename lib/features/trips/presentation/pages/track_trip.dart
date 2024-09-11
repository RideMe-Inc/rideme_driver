import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/location/presentation/bloc/location_bloc.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';
import 'package:rideme_driver/core/widgets/buttons/generic_button_widget.dart';
import 'package:rideme_driver/core/widgets/popups/error_popup.dart';
import 'package:rideme_driver/features/authentication/presentation/provider/authentication_provider.dart';
import 'package:rideme_driver/features/trips/domain/entities/trip_tracking_details.dart';
import 'package:rideme_driver/features/trips/presentation/bloc/trips_bloc.dart';
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
      "locale": context.appLocalizations.localeName,
      "bearer": context.read<AuthenticationProvider>().token,
      "urlParameters": {
        "id": widget.tripId,
      }
    };

    tripBloc.add(GetTrackingDetailsEvent(params: params));
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
          color: Colors.transparent,
          body: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Map stuff goes here'),
            ],
          ),
          panel: _PanelWidget(),
          collapsed: _CollapsedWidget(),
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
  const _PanelWidget();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

//!COLLAPSED WIDGET
class _CollapsedWidget extends StatelessWidget {
  const _CollapsedWidget();

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
        ],
      ),
    );
  }
}
