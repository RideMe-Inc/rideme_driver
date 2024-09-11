import 'package:flutter/material.dart';
import 'package:rideme_driver/features/trips/domain/entities/trip_tracking_details.dart';

class CollapseInfoWidget extends StatelessWidget {
  final RiderInfo user;
  final String status;
  final String? arrivedAt;
  final int? completedStopsCount, totalStops;

  const CollapseInfoWidget({
    super.key,
    required this.status,
    required this.arrivedAt,
    required this.completedStopsCount,
    required this.totalStops,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [],
    );
  }
}
