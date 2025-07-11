part of 'trips_bloc.dart';

sealed class TripsState extends Equatable {
  const TripsState();

  @override
  List<Object> get props => [];
}

final class TripsInitial extends TripsState {}

class GenericTripsError extends TripsState {
  final String errorMessage;

  const GenericTripsError({required this.errorMessage});
}

//! CANCEL TRIP

//loading
class CancelTripLoading extends TripsState {}

//loaded
class CancelTripLoaded extends TripsState {
  final String message;

  const CancelTripLoaded({required this.message});
}

class CancelTripError extends TripsState {
  final String message;

  const CancelTripError({required this.message});
}

//! GET ALL TRIP

//loading
class GetAllTripLoading extends TripsState {}

//loaded
class GetAllTripLoaded extends TripsState {
  final AllTripsInfo allTripsInfo;
  final List<AllTripDetails> tripDetails;

  const GetAllTripLoaded({
    required this.allTripsInfo,
    required this.tripDetails,
  });
}

//! GET  TRIP DETAILS

//loading
class GetTripLoading extends TripsState {}

//loaded
class GetTripLoaded extends TripsState {
  final TripDetailsInfo tripDetailsInfo;

  const GetTripLoaded({required this.tripDetailsInfo});
}

//! RATE  TRIP

//loading
class RateTripLoading extends TripsState {}

//loaded
class RateTripLoaded extends TripsState {
  final String rate;

  const RateTripLoaded({required this.rate});
}

//! REPORT   TRIP

//loading
class ReportTripLoading extends TripsState {}

//loaded
class ReportTripLoaded extends TripsState {
  final String report;

  const ReportTripLoaded({required this.report});
}

//!ACCEPT OR REJECT TRIPS
//loading
final class AcceptRejectTripLoading extends TripsState {}

//loaded
final class AcceptRejectTripLoaded extends TripsState {
  final String tripId;
  final bool isReject;

  const AcceptRejectTripLoaded({required this.tripId, required this.isReject});
}

//!GET TRIP STATUS
final class GetTripStatusLoading extends TripsState {}

final class GetTripStatusLoaded extends TripsState {
  final String status;

  const GetTripStatusLoaded({required this.status});
}

final class GetTripStatusError extends TripsState {
  final String error;

  const GetTripStatusError({required this.error});
}

//!TRACK TRIP
//loading
final class GetTrackingDetailsLoading extends TripsState {}

//loaded
final class GetTrackingDetailsLoaded extends TripsState {
  final TripTrackingDetails tripInfo;

  const GetTrackingDetailsLoaded({required this.tripInfo});
}

final class GetTrackingDetailsError extends TripsState {
  final String message;

  const GetTrackingDetailsError({required this.message});
}

//!RIDER TRIP ACTIONS
final class RiderTripActionsLoading extends TripsState {}

final class RiderTripActionsLoaded extends TripsState {
  final TripTrackingDetails tripInfo;
  final bool? isCompleted;

  const RiderTripActionsLoaded({
    required this.tripInfo,
    this.isCompleted,
  });
}

final class RiderTripActionsError extends TripsState {
  final String message;

  const RiderTripActionsError({required this.message});
}

//!GET DIRECTIONS
final class GetDirectionsLoading extends TripsState {}

final class GetDirectionsLoaded extends TripsState {
  final DirectionsObject directions;

  const GetDirectionsLoaded({required this.directions});
}

final class GetDirectionsError extends TripsState {
  final String error;

  const GetDirectionsError({required this.error});
}

//! ERROR
class GenericTripError extends TripsState {
  final String errorMessage;

  const GenericTripError({required this.errorMessage});
}
