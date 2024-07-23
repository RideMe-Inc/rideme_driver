part of 'permission_bloc.dart';

sealed class PermissionState extends Equatable {
  const PermissionState();

  @override
  List<Object> get props => [];
}

//!PERMISSIONS

final class PermissionInitial extends PermissionState {}

final class NotifPemApproved extends PermissionState {}

final class NotifPemProvisional extends PermissionState {}

final class NotifPemDeclinedOrNotAccepted extends PermissionState {}

//!LOCATIONS
final class LocationPemApproved extends PermissionState {}

final class LocationPemDeclined extends PermissionState {}

//!APP TRACKING TRANSPARENCY
final class AllNecessaryPermissionsApproved extends PermissionState {}

final class AllNecessaryPermissionsDeclined extends PermissionState {}

//!ERROR

final class PermissionError extends PermissionState {
  final String message;

  const PermissionError({required this.message});
}
