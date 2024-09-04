import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intl/intl.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';
import 'package:rideme_driver/features/trips/domain/entities/all_trips_details.dart';
import 'package:rideme_driver/features/trips/presentation/widgets/trip_history_card.dart';

class HistorySections extends StatefulWidget {
  final DateTime label;
  final List<AllTripDetails> items;

  const HistorySections({
    super.key,
    required this.label,
    required this.items,
  });

  @override
  State<HistorySections> createState() => _HistorySectionsState();
}

class _HistorySectionsState extends State<HistorySections> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //label
        Text(
          DateFormat('d MMM y').format(widget.label),
          style: context.textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.rideMeBlack80,
          ),
        ),
        Space.height(context, 0.033),
        //history sections
        ...widget.items.map(
          (e) => TripHistoryCard(
            tripDetails: e,
            onTap: () {
              context.pushNamed(
                'historyDetails',
                queryParameters: {
                  'tripId': e.id.toString(),
                },
              );
            },
          ),
        ),
        Space.height(context, 0.024),
      ],
    );
  }
}
