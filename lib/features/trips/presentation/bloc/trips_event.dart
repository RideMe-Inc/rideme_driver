part of 'trips_bloc.dart';

sealed class TripsEvent extends Equatable {
  const TripsEvent();

  @override
  List<Object> get props => [];
}

//!CANCEL TRIP
class CancelTripEvent extends TripsEvent {
  final Map<String, dynamic> params;

  const CancelTripEvent({required this.params});
}

//!GET ALL TRIP
class GetAllTripsEvent extends TripsEvent {
  final Map<String, dynamic> params;
  final List<AllTripDetails> currentList;

  const GetAllTripsEvent({
    required this.params,
    required this.currentList,
  });
}

//!GET TRIP INFO
class GetTripInfoEvent extends TripsEvent {
  final Map<String, dynamic> params;

  const GetTripInfoEvent({required this.params});
}

//!RATE TRIP
class RateTripEvent extends TripsEvent {
  final Map<String, dynamic> params;

  const RateTripEvent({required this.params});
}

//!REPORT TRIP
class ReportTripEvent extends TripsEvent {
  final Map<String, dynamic> params;

  const ReportTripEvent({required this.params});
}

//!ACCEPT OR REJECT TRIP
final class AcceptRejectTripEvent extends TripsEvent {
  final Map<String, dynamic> params;

  const AcceptRejectTripEvent({required this.params});
}

//!GET TRIP STATUS
final class GetTripStatusEvent extends TripsEvent {
  final Map<String, dynamic> params;

  const GetTripStatusEvent({required this.params});
}
