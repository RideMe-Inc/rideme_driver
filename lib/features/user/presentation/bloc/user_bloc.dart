import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rideme_driver/core/usecase/usecase.dart';
import 'package:rideme_driver/features/user/domain/entities/driver_object.dart';
import 'package:rideme_driver/features/user/domain/entities/license_info.dart';
import 'package:rideme_driver/features/user/domain/entities/rider_vehicle.dart';
import 'package:rideme_driver/features/user/domain/entities/support_data.dart';
import 'package:rideme_driver/features/user/domain/entities/user.dart';
import 'package:rideme_driver/features/user/domain/usecases/cache_rider_id.dart';
import 'package:rideme_driver/features/user/domain/usecases/change_availability.dart';
import 'package:rideme_driver/features/user/domain/usecases/create_driver_license.dart';
import 'package:rideme_driver/features/user/domain/usecases/create_vehicle.dart';
import 'package:rideme_driver/features/user/domain/usecases/delete_account.dart';
import 'package:rideme_driver/features/user/domain/usecases/edit_driver_license.dart';
import 'package:rideme_driver/features/user/domain/usecases/edit_profile.dart';
import 'package:rideme_driver/features/user/domain/usecases/edit_vehicle.dart';
import 'package:rideme_driver/features/user/domain/usecases/get_all_rider_license.dart';
import 'package:rideme_driver/features/user/domain/usecases/get_all_vehicles.dart';
import 'package:rideme_driver/features/user/domain/usecases/get_cached_user_info.dart';
import 'package:rideme_driver/features/user/domain/usecases/get_cached_user_without_user.dart';
import 'package:rideme_driver/features/user/domain/usecases/get_support_contacts.dart';
import 'package:rideme_driver/features/user/domain/usecases/get_user_profile.dart';
import 'package:rideme_driver/features/user/domain/usecases/rider_photo_check.dart';
import 'package:rideme_driver/features/user/domain/usecases/update_cached_user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserProfile getUserProfile;
  final DeleteAccount deleteAccount;
  final EditProfile editProfile;
  final CreateDriverLicense createDriverLicense;
  final EditDriverLicense editDriverLicense;
  final GetAllRidersLicense getAllRidersLicense;
  final ChangeAvailability changeAvailability;
  final GetCachedUserInfo getCachedUserInfo;
  final UpdateCachedUser updateCachedUser;
  final GetCachedUserWithoutSafety getCachedUserWithoutSafety;
  final RiderPhotoCheck riderPhotoCheck;

  final CreateVehicle createVehicle;
  final EditVehicle editVehicle;
  final GetAllRiderVehicles getAllRiderVehicles;
  final GetSupportContacts getSupportContacts;
  final CacheRiderId cacheRiderId;

  UserBloc({
    required this.getUserProfile,
    required this.deleteAccount,
    required this.editProfile,
    required this.createDriverLicense,
    required this.editDriverLicense,
    required this.getAllRidersLicense,
    required this.changeAvailability,
    required this.getCachedUserInfo,
    required this.updateCachedUser,
    required this.getCachedUserWithoutSafety,
    required this.riderPhotoCheck,
    required this.createVehicle,
    required this.editVehicle,
    required this.getAllRiderVehicles,
    required this.cacheRiderId,
    required this.getSupportContacts,
  }) : super(UserInitial()) {
    //!GET USER PROFILE
    on<GetUserProfileEvent>((event, emit) async {
      emit(GetUserProfileLoading());
      final response = await getUserProfile(event.params);

      emit(
        response.fold(
          (l) => GetUserProfileError(message: l),
          (r) => GetUserProfileLoaded(driver: r),
        ),
      );
    });

    //DELETE ACCOUNT
    on<DeleteAccountEvent>((event, emit) async {
      emit(DeleteAccountLoading());
      final response = await deleteAccount(event.params);

      emit(
        response.fold(
          (errorMessage) => DeleteAccountError(message: errorMessage),
          (response) => DeleteAccountLoaded(message: response),
        ),
      );
    });

    //!EDIT PROFILE
    on<EditProfileEvent>((event, emit) async {
      emit(EditProfileLoading());
      final response = await editProfile(event.params);

      emit(
        response.fold(
          (errorMessage) => EditProfileError(message: errorMessage),
          (response) => EditProfileLoaded(user: response),
        ),
      );
    });

    //! CREATE LICENSE
    on<CreateDriverLicenseEvent>(
      (event, emit) async {
        emit(CreateDriverLicenseLoading());

        final response = await createDriverLicense(event.params);

        emit(
          response.fold(
            (errorMessage) => GenericUserError(errorMessage: errorMessage),
            (response) => CreateDriverLicenseLoaded(licenseInfo: response),
          ),
        );
      },
    );
    //! EDIT DRIVER LICENSE
    on<EditDriverLicenseEvent>(
      (event, emit) async {
        emit(CreateDriverLicenseLoading());

        final response = await editDriverLicense(event.params);

        emit(
          response.fold(
            (errorMessage) => GenericUserError(errorMessage: errorMessage),
            (response) => EditDriverLicenseLoaded(licenseInfo: response),
          ),
        );
      },
    );

    //!GET ALL Rider license
    on<GetAllRidersLicenseEvent>(
      (event, emit) async {
        emit(GetAllRidersLicenseLoading());

        final response = await getAllRidersLicense(event.params);

        emit(
          response.fold(
            (errorMessage) =>
                GetAllRiderLicenseError(errorMessage: errorMessage),
            (response) => GetAllRidersLicenseLoaded(licenseInfo: response),
          ),
        );
      },
    );

    //! CHANGE AVAILABILITY
    on<ChangeAvailabilityEvent>((event, emit) async {
      emit(ChangeAvailabilityLoading());

      final response = await changeAvailability(event.params);

      emit(
        response.fold(
          (error) => ChangeAvailabilityError(errorMessage: error),
          (response) => ChangeAvailabilityLoaded(user: response),
        ),
      );
    });

    //! GET CACHED USER
    on<GetCachedUserEvent>((event, emit) async {
      final response = await getCachedUserInfo(NoParams());

      emit(
        response.fold(
          (error) => GetCachedUserError(errorMessage: error),
          (response) => GetCachedUserLoaded(user: response),
        ),
      );
    });

    //! UPDATE CACHED USER
    on<UpdateCachedUserEvent>((event, emit) async {
      final response = await updateCachedUser(event.params);

      emit(
        response.fold(
          (error) => UpdateCachedUserError(errorMessage: error),
          (response) => UpdateCachedUserLoaded(user: event.driver),
        ),
      );
    });

    //!RIDER PHOTO CHECK

    on<RiderPhotoCheckEvent>((event, emit) async {
      emit(RiderPhotoCheckLoading());
      final response = await riderPhotoCheck(event.params);

      emit(
        response.fold(
          (error) => GenericUserError(errorMessage: error),
          (response) => RiderPhotoCheckLoaded(),
        ),
      );
    });

    //! CREATE RIDER VEHICLE

    on<CreateVehicleEvent>((event, emit) async {
      emit(CreateVehicleLoading());

      final response = await createVehicle(event.params);

      emit(
        response.fold(
          (message) => GenericVehicleError(errorMessage: message),
          (response) => CreateVehicleLoaded(riderVehicleInfo: response),
        ),
      );
    });

    //! Edit RIDER VEHICLE

    on<EditVehicleEvent>((event, emit) async {
      emit(CreateVehicleLoading());

      final response = await editVehicle(event.params);

      emit(
        response.fold(
          (message) => GenericUserError(errorMessage: message),
          (response) => EditVehicleLoaded(riderVehicleInfo: response),
        ),
      );
    });

    //! REQUEST ALL RIDER VEHICLES

    on<GetAllRiderVehiclesEvent>((event, emit) async {
      emit(GetAllRiderVehiclesLoading());

      final response = await getAllRiderVehicles(event.params);

      emit(
        response.fold(
          (message) => GetAllRiderVehiclesError(errorMessage: message),
          (response) => GetAllRiderVehiclesLoaded(riderVehicleInfo: response),
        ),
      );
    });

    //!GET SUPPORT CONTACTS
    on<GetSupportContactsEvent>((event, emit) async {
      emit(GetSupportContactsLoading());
      final response = await getSupportContacts(event.params);

      emit(
        response.fold(
          (errorMessage) => GetSupportContactsError(message: errorMessage),
          (response) => GetSupportContactsLoaded(supportData: response),
        ),
      );
    });
  }

  //login right navigation
  navigateRiderBasedOnProfileCompletion(
      DriverObject? driver, BuildContext context) {
    if (driver == null) {
      context.goNamed('signup');
      return;
    }
    if ((driver.profile.hasLicense ?? false) &&
        (driver.profile.hasVehicle ?? false) &&
        (driver.profile.photoCheckRequired ?? true) != true) {
      driver.extra != null
          ? context.goNamed('trackTrip', queryParameters: {
              'tripId': driver.extra!.ongoingTrips.first.id.toString()
            })
          : context.goNamed('home');
    } else if (!(driver.profile.hasVehicle ?? false)) {
      context.goNamed('vehicleInformation');
    } else if (!(driver.profile.hasLicense ?? false)) {
      context.goNamed('licenseInformation');
    } else if (driver.profile.photoCheckRequired ?? false) {
      context.goNamed('photoCheck');
    } else {
      context.goNamed('signup');
    }
  }

  cacheRiderID(int id) {
    return cacheRiderId.call(id);
  }
}
