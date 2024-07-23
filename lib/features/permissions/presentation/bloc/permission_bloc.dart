import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rideme_driver/core/usecase/usecase.dart';
import 'package:rideme_driver/features/permissions/domain/usecases/request_all_necessary_permissions.dart';
import 'package:rideme_driver/features/permissions/domain/usecases/request_location_permission.dart';
import 'package:rideme_driver/features/permissions/domain/usecases/request_notif_permission.dart';

part 'permission_event.dart';
part 'permission_state.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  final RequestNotificationPermission requestNotificationPermission;
  final RequestLocationPermission requestLocationPermission;
  final RequestAllNecessaryPermissions requestAllNecessaryPermissions;
  PermissionBloc({
    required this.requestNotificationPermission,
    required this.requestLocationPermission,
    required this.requestAllNecessaryPermissions,
  }) : super(PermissionInitial()) {
    //!NOTIFICATIONS
    on<RequestNotificationPemEvent>((event, emit) async {
      final response = await requestNotificationPermission(NoParams());

      emit(
        response.fold(
          (error) => PermissionError(message: error),
          (response) => response.isGranted || response.isLimited
              ? NotifPemApproved()
              : response.isProvisional
                  ? NotifPemProvisional()
                  : NotifPemDeclinedOrNotAccepted(),
        ),
      );
    });

    //!LOCATION
    on<RequestLocationPemEvent>((event, emit) async {
      final response = await requestLocationPermission(NoParams());

      emit(
        response.fold(
          (error) => PermissionError(message: error),
          (response) => response == PermissionStatus.granted ||
                  response == PermissionStatus.provisional ||
                  response == PermissionStatus.limited
              ? LocationPemApproved()
              : LocationPemDeclined(),
        ),
      );
    });

    //!APP TRANSPARENCY
    on<RequestAllNecessaryPermissionsEvent>((event, emit) async {
      final response = await requestAllNecessaryPermissions(NoParams());

      emit(
        response.fold(
          (error) => PermissionError(message: error),
          (response) => response == TrackingStatus.authorized
              ? AllNecessaryPermissionsApproved()
              : AllNecessaryPermissionsDeclined(),
        ),
      );
    });
  }
}
