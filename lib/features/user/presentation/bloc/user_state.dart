part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

//!GET USER PROFILE
final class GetUserProfileLoading extends UserState {}

final class GetUserProfileLoaded extends UserState {
  final DriverObject driver;

  const GetUserProfileLoaded({required this.driver});
}

final class GetUserProfileError extends UserState {
  final String message;

  const GetUserProfileError({required this.message});
}

//!DELETE ACCOUNT

final class DeleteAccountLoading extends UserState {}

final class DeleteAccountLoaded extends UserState {
  final String message;

  const DeleteAccountLoaded({required this.message});
}

final class DeleteAccountError extends UserState {
  final String message;

  const DeleteAccountError({required this.message});
}

//!EDiT PROFLE

final class EditProfileLoading extends UserState {}

final class EditProfileLoaded extends UserState {
  final User user;

  const EditProfileLoaded({required this.user});
}

final class EditProfileError extends UserState {
  final String message;

  const EditProfileError({required this.message});
}

//!ALL RIDER LICENSE

//loading
class GetAllRidersLicenseLoading extends UserState {}

//loaded
class GetAllRidersLicenseLoaded extends UserState {
  final LicenseInfo licenseInfo;

  const GetAllRidersLicenseLoaded({required this.licenseInfo});
}

class GetAllRiderLicenseError extends UserState {
  final String errorMessage;
  const GetAllRiderLicenseError({required this.errorMessage});
}

//!ERROR
class GenericUserError extends UserState {
  final String errorMessage;

  const GenericUserError({required this.errorMessage});
}

//!CREATE DRIVER LICENSE

//loading
final class CreateDriverLicenseLoading extends UserState {}

//loaded
class CreateDriverLicenseLoaded extends UserState {
  final LicenseInfo licenseInfo;

  const CreateDriverLicenseLoaded({required this.licenseInfo});
}

//!EDIT DRIVER LICENSE

//loading
final class EditDriverLicenseLoading extends UserState {}

//loaded
class EditDriverLicenseLoaded extends UserState {
  final LicenseInfo licenseInfo;

  const EditDriverLicenseLoaded({required this.licenseInfo});
}

//!GET CACHED USER

//loaded
class GetCachedUserLoaded extends UserState {
  final User user;

  const GetCachedUserLoaded({required this.user});
}

//error
class GetCachedUserError extends UserState {
  final String errorMessage;

  const GetCachedUserError({required this.errorMessage});
}

//!UPDATE CACHED USER
//loaded
class UpdateCachedUserLoaded extends UserState {
  final User? user;

  const UpdateCachedUserLoaded({required this.user});
}

//error
class UpdateCachedUserError extends UserState {
  final String errorMessage;

  const UpdateCachedUserError({required this.errorMessage});
}

//! CHANGE AVAILABILITY
//loading
final class ChangeAvailabilityLoading extends UserState {}

//loaded
class ChangeAvailabilityLoaded extends UserState {
  final User user;

  const ChangeAvailabilityLoaded({required this.user});
}

//!PHOTO CHECK
final class RiderPhotoCheckLoading extends UserState {}

final class RiderPhotoCheckLoaded extends UserState {}

//error
class ChangeAvailabilityError extends UserState {
  final String errorMessage;

  const ChangeAvailabilityError({required this.errorMessage});
}

//!CREATE VEHICLE

//loading
final class CreateVehicleLoading extends UserState {}

//loaded
class CreateVehicleLoaded extends UserState {
  final RiderVehicleInfo riderVehicleInfo;

  const CreateVehicleLoaded({required this.riderVehicleInfo});
}

//!EDIT VEHICLE
//loading
final class EditVehicleLoading extends UserState {}

//loaded
class EditVehicleLoaded extends UserState {
  final RiderVehicleInfo riderVehicleInfo;

  const EditVehicleLoaded({required this.riderVehicleInfo});
}

//! ERROR
class GenericVehicleError extends UserState {
  final String errorMessage;

  const GenericVehicleError({required this.errorMessage});
}

//!GET ALL RIDER VEHICLES

//loading
final class GetAllRiderVehiclesLoading extends UserState {}

//loaded

class GetAllRiderVehiclesLoaded extends UserState {
  final RiderVehicleInfo riderVehicleInfo;

  const GetAllRiderVehiclesLoaded({required this.riderVehicleInfo});
}

//error

final class GetAllRiderVehiclesError extends UserState {
  final String errorMessage;
  const GetAllRiderVehiclesError({required this.errorMessage});
}

//!GET SUPPORT CONTACTS

final class GetSupportContactsLoading extends UserState {}

final class GetSupportContactsLoaded extends UserState {
  final SupportData supportData;

  const GetSupportContactsLoaded({required this.supportData});
}

final class GetSupportContactsError extends UserState {
  final String message;

  const GetSupportContactsError({required this.message});
}
