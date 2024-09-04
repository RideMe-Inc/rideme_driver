part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

final class GetUserProfileEvent extends UserEvent {
  final Map<String, dynamic> params;

  const GetUserProfileEvent({required this.params});
}

//DELETE ACCOUNT
final class DeleteAccountEvent extends UserEvent {
  final Map<String, dynamic> params;

  const DeleteAccountEvent({required this.params});
}

//EDT PROFLE
final class EditProfileEvent extends UserEvent {
  final Map<String, dynamic> params;
  const EditProfileEvent({required this.params});
}

//! GET CACHED USER
class GetCachedUserEvent extends UserEvent {}

//! UPDATE CACHED USER
class UpdateCachedUserEvent extends UserEvent {
  final Map<String, dynamic> params;
  final User? driver;

  const UpdateCachedUserEvent({
    required this.params,
    this.driver,
  });
}

//! GET ALL RIDERS' LICENSE
class GetAllRidersLicenseEvent extends UserEvent {
  final Map<String, dynamic> params;

  const GetAllRidersLicenseEvent({required this.params});
}

//! CREATE  RIDER LICENSE

class CreateDriverLicenseEvent extends UserEvent {
  final Map<String, dynamic> params;

  const CreateDriverLicenseEvent({required this.params});
}
//! EDIT  RIDER LICENSE

class EditDriverLicenseEvent extends UserEvent {
  final Map<String, dynamic> params;

  const EditDriverLicenseEvent({required this.params});
}

///
///
///

//! UPDATE PROFILE OF RIDER

class UpdateProfileEvent extends UserEvent {
  final Map<String, dynamic> params;

  const UpdateProfileEvent({required this.params});
}

//! CHANGE AVAILABILITY
class ChangeAvailabilityEvent extends UserEvent {
  final Map<String, dynamic> params;

  const ChangeAvailabilityEvent({required this.params});
}

//!RIDER PHOTO CHECK
class RiderPhotoCheckEvent extends UserEvent {
  final Map<String, dynamic> params;

  const RiderPhotoCheckEvent({required this.params});
}

//! GET ALL RIDERS VEHICLES
class GetAllRiderVehiclesEvent extends UserEvent {
  final Map<String, dynamic> params;

  const GetAllRiderVehiclesEvent({required this.params});
}

//! CREATE VEHICLE
class CreateVehicleEvent extends UserEvent {
  final Map<String, dynamic> params;

  const CreateVehicleEvent({required this.params});
}

//! EDIT VEHICLE
class EditVehicleEvent extends UserEvent {
  final Map<String, dynamic> params;

  const EditVehicleEvent({required this.params});
}

//!GET SUPPORT CONTACTS
final class GetSupportContactsEvent extends UserEvent {
  final Map<String, dynamic> params;

  const GetSupportContactsEvent({required this.params});
}
