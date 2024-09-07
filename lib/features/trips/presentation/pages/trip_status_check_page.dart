import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';
import 'package:rideme_driver/core/widgets/loaders/loading_indicator.dart';
import 'package:rideme_driver/features/localization/presentation/providers/locale_provider.dart';
import 'package:rideme_driver/features/trips/domain/entities/trip_request_info.dart';
import 'package:rideme_driver/features/trips/presentation/bloc/trips_bloc.dart';
import 'package:rideme_driver/injection_container.dart';

class TripStatusChecker extends StatefulWidget {
  final String? tripData;
  final String? tripId;
  const TripStatusChecker(
      {super.key, required this.tripData, required this.tripId});

  @override
  State<TripStatusChecker> createState() => _TripStatusCheckerState();
}

class _TripStatusCheckerState extends State<TripStatusChecker> {
  final tripsBloc = sl<TripsBloc>();

  late AppLocalizations appLocalizations;

  getTripStatus() {
    TripRequestInfo? tripRequestInfo;
    String? tripId;
    if (widget.tripData != null) {
      tripRequestInfo = tripsBloc.parseTripRequestInfo(widget.tripData!);
    }
    if (widget.tripId != null) {
      tripId = widget.tripId;
    }

    final params = {
      "locale": context.read<LocaleProvider>().locale,
      "urlParameters": {
        "tripId": tripId ?? tripRequestInfo?.id.toString(),
      },
    };

    tripsBloc.add(GetTripStatusEvent(params: params));
  }

  @override
  void initState() {
    getTripStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.rideMeBackgroundLight,
      body: BlocConsumer(
        bloc: tripsBloc,
        builder: (context, state) {
          if (state is GetTripStatusLoading) {
            return const LoadingIndicator();
          }

          return Space.height(context, 0);
        },
        listener: (context, state) {
          if (state is GetTripStatusLoaded) {
            switch (state.status) {
              case 'booked':
                context.goNamed(
                  'tripAcceptReject',
                  queryParameters: {
                    'tripinfo': widget.tripData,
                  },
                );
                //handle

                break;

              case 'assigned':
                context.goNamed(
                  'trackTrip',
                  queryParameters: {
                    "tripId": widget.tripId,
                  },
                );

              default:
                context.goNamed('home');
                break;
            }
          }

          if (state is GetTripStatusError) {
            context.goNamed('home');
          }
        },
      ),
    );
  }
}
