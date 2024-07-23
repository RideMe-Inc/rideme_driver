part of 'permission_bloc.dart';

sealed class PermissionEvent extends Equatable {
  const PermissionEvent();

  @override
  List<Object> get props => [];
}

//!NOTIFICATIONS

final class RequestNotificationPemEvent extends PermissionEvent {}

//!LOCATIONS
final class RequestLocationPemEvent extends PermissionEvent {}

//!APP TRACKING TRANSAPARENCY
final class RequestAllNecessaryPermissionsEvent extends PermissionEvent {}
