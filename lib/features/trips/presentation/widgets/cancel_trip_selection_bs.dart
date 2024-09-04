import 'package:flutter/material.dart';
import 'package:rideme_driver/features/trips/presentation/widgets/cancel_trip_selection.dart';

buildCancelTripReasonsBS(
        {required BuildContext context, required String tripId}) =>
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) => CancelTripReasonsPage(
        tripId: tripId,
      ),
    );
