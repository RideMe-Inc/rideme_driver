import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Tracking page. MEN AT WORK'),
      ),
    );
  }
}
