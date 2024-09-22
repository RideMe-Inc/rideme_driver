import 'package:audioplayers/audioplayers.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rideme_driver/core/network/networkinfo.dart';
import 'package:rideme_driver/core/urls/urls.dart';
import 'package:rideme_driver/features/authentication/data/datasources/localds.dart';
import 'package:rideme_driver/features/authentication/data/datasources/remoteds.dart';
import 'package:rideme_driver/features/authentication/data/repository/authentication_repo_impl.dart';
import 'package:rideme_driver/features/authentication/domain/repository/authentication_repository.dart';
import 'package:rideme_driver/features/authentication/domain/usecases/get_refresh_token.dart';
import 'package:rideme_driver/features/authentication/domain/usecases/init_auth.dart';
import 'package:rideme_driver/features/authentication/domain/usecases/logout.dart';
import 'package:rideme_driver/features/authentication/domain/usecases/recover_token.dart';
import 'package:rideme_driver/features/authentication/domain/usecases/sign_up.dart';
import 'package:rideme_driver/features/authentication/domain/usecases/verify_otp.dart';
import 'package:rideme_driver/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:rideme_driver/features/informationResources/data/datasource/remoteds.dart';
import 'package:rideme_driver/features/informationResources/data/repository/information_resource_repo_impl.dart';
import 'package:rideme_driver/features/informationResources/domain/repository/information_resources_repository.dart';
import 'package:rideme_driver/features/informationResources/domain/usecases/get_all_vehicle_colors.dart';
import 'package:rideme_driver/features/informationResources/domain/usecases/get_all_vehicle_makes.dart';
import 'package:rideme_driver/features/informationResources/presentation/bloc/information_resources_bloc.dart';
import 'package:rideme_driver/features/localization/data/datasources/localds.dart';
import 'package:rideme_driver/features/localization/data/repository/repo_impl.dart';
import 'package:rideme_driver/features/localization/domain/repository/localization_repo.dart';
import 'package:rideme_driver/features/localization/domain/usecases/change_locale.dart';
import 'package:rideme_driver/features/localization/domain/usecases/get_current_locale.dart';
import 'package:rideme_driver/features/localization/presentation/providers/locale_provider.dart';
import 'package:rideme_driver/features/media/data/datasources/localds.dart';
import 'package:rideme_driver/features/media/data/repositories/media_repository_impl.dart';
import 'package:rideme_driver/features/media/domain/repositories/media_repository.dart';
import 'package:rideme_driver/features/media/domain/usecases/convert_image_to_base64.dart';
import 'package:rideme_driver/features/media/domain/usecases/select_image_from_gallery.dart';
import 'package:rideme_driver/features/media/domain/usecases/take_picture_with_camera.dart';
import 'package:rideme_driver/features/media/presentation/bloc/media_bloc.dart';
import 'package:rideme_driver/features/permissions/data/datasources/localds.dart';
import 'package:rideme_driver/features/permissions/data/repository/repository_impl.dart';
import 'package:rideme_driver/features/permissions/domain/repository/permissions_repo.dart';
import 'package:rideme_driver/features/permissions/domain/usecases/request_all_necessary_permissions.dart';
import 'package:rideme_driver/features/permissions/domain/usecases/request_location_permission.dart';
import 'package:rideme_driver/features/permissions/domain/usecases/request_notif_permission.dart';
import 'package:rideme_driver/features/permissions/presentation/bloc/permission_bloc.dart';
import 'package:rideme_driver/features/trips/data/datasource/localds.dart';
import 'package:rideme_driver/features/trips/data/datasource/remoteds.dart';
import 'package:rideme_driver/features/trips/data/repository/trip_repository_impl.dart';
import 'package:rideme_driver/features/trips/domain/repository/trips_repository.dart';
import 'package:rideme_driver/features/trips/domain/usecases/accept_reject_trip.dart';
import 'package:rideme_driver/features/trips/domain/usecases/cancel_trip.dart';
import 'package:rideme_driver/features/trips/domain/usecases/get_all_trips.dart';
import 'package:rideme_driver/features/trips/domain/usecases/get_directions.dart';
import 'package:rideme_driver/features/trips/domain/usecases/get_tracking_details.dart';
import 'package:rideme_driver/features/trips/domain/usecases/get_trip_info.dart';
import 'package:rideme_driver/features/trips/domain/usecases/get_trip_status.dart';
import 'package:rideme_driver/features/trips/domain/usecases/play_sound.dart';
import 'package:rideme_driver/features/trips/domain/usecases/rate_trip.dart';
import 'package:rideme_driver/features/trips/domain/usecases/report_trip.dart';
import 'package:rideme_driver/features/trips/domain/usecases/rider_trip_destination_actions.dart';
import 'package:rideme_driver/features/trips/domain/usecases/stop_sound.dart';
import 'package:rideme_driver/features/trips/presentation/bloc/trips_bloc.dart';
import 'package:rideme_driver/features/user/data/datasources/localds.dart';
import 'package:rideme_driver/features/user/data/datasources/remoteds.dart';
import 'package:rideme_driver/features/user/data/repositories/user_repository_impl.dart';
import 'package:rideme_driver/features/user/domain/repositories/user_repository.dart';
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
import 'package:rideme_driver/features/user/presentation/bloc/user_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:web_socket_client/web_socket_client.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

//! MAIN INIT FUNCTION

init() async {
  //!INTERNAL

  //permissions
  initPermissions();

  //localizations
  initLocalization();

  //media
  initMedia();

  //user
  initUser();

  //auth
  initAuth();

  //trips

  initTrips();

  //data

  initData();
  //urls
  sl.registerLazySingleton(() => URLS());

  //network info
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      dataConnectionChecker: sl(),
    ),
  );

  //! EXTERNAL

  //firebase messaging

  sl.registerLazySingleton(() => FirebaseMessaging.instance);

  //data connection
  sl.registerLazySingleton(() => DataConnectionChecker());

  //shared preferences
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);

  //flutter secured storage
  AndroidOptions getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  final secureStorage = FlutterSecureStorage(
    aOptions: getAndroidOptions(),
  );

  sl.registerLazySingleton(() => secureStorage);

  //http
  sl.registerLazySingleton(() => http.Client());

  //camera and image picker
  sl.registerLazySingleton(() => ImagePicker());

  //audio player
  sl.registerLazySingleton(() => AudioPlayer());

  //tts
  FlutterTts flutterTts = FlutterTts();

  sl.registerLazySingleton(
    () async {
      await flutterTts.setSharedInstance(true);
      await flutterTts.setSpeechRate(0.4);
      await flutterTts.awaitSpeakCompletion(true);

      return flutterTts;
    },
  );

  //socket
  sl.registerLazySingleton<WebSocket>(() {
    final socket = WebSocket(Uri.parse('wss://dss.rideme.app'));

    return socket;
  });
}

//!INIT AUTHENTICATION

initAuth() {
  //bloc
  sl.registerFactory(
    () => AuthenticationBloc(
      getRefreshToken: sl(),
      recoverToken: sl(),
      signUp: sl(),
      logOut: sl(),
      initAuth: sl(),
      verifyOtp: sl(),
    ),
  );

  //usecases

  sl.registerLazySingleton(
    () => InitAuth(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => VerifyOtp(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => SignUp(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetRefreshToken(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => RecoverToken(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => LogOut(
      repository: sl(),
    ),
  );

  //repository

  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      remoteDatasource: sl(),
      localDatasource: sl(),
      userLocalDatasource: sl(),
      networkInfo: sl(),
    ),
  );

  //datasources

  sl.registerLazySingleton<AuthenticationRemoteDatasource>(
    () => AuthenticationRemoteDatasourceImpl(
      client: sl(),
      urls: sl(),
      messaging: sl(),
    ),
  );

  sl.registerLazySingleton<AuthenticationLocalDatasource>(
    () => AuthenticationLocalDatasourceImpl(
      secureStorage: sl(),
    ),
  );
}

//!INIT PERMISSIONS
initPermissions() {
  //bloc

  sl.registerFactory(
    () => PermissionBloc(
      requestNotificationPermission: sl(),
      requestLocationPermission: sl(),
      requestAllNecessaryPermissions: sl(),
    ),
  );

  //usecases

  sl.registerLazySingleton(
    () => RequestNotificationPermission(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => RequestLocationPermission(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => RequestAllNecessaryPermissions(
      repository: sl(),
    ),
  );

  //repository

  sl.registerLazySingleton<PermissionsRepository>(
    () => PermissionsRepositoryImpl(
      localDatasource: sl(),
    ),
  );

  //datasources

  sl.registerLazySingleton<PermissionsLocalDatasource>(
    () => PermissionsLocalDatasourceImpl(
      messaging: sl(),
    ),
  );
}

//!INIT LOCALIZATION
initLocalization() {
  //provider
  sl.registerFactory(
    () => LocaleProvider(
      getCurrentLocale: sl(),
      changeLocale: sl(),
    ),
  );

  //usecases

  sl.registerLazySingleton(
    () => ChangeLocale(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetCurrentLocale(
      repository: sl(),
    ),
  );

  //repository

  sl.registerLazySingleton<LocalizationRepository>(
    () => LocalizationRepositoryImpl(
      localDataSource: sl(),
    ),
  );

  //datasources
  sl.registerLazySingleton<LocalizationLocalDataSource>(
    () => LocalizationLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );
}

//!INIT DATA
initData() {
  //bloc
  sl.registerFactory(
    () => InformationResourcesBloc(
      getAllVehicleMakes: sl(),
      getAllVehicleColors: sl(),
    ),
  );

  //usecases

  sl.registerLazySingleton(
    () => GetAllVehicleMakes(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetAllVehicleColors(
      repository: sl(),
    ),
  );

  //repository
  sl.registerLazySingleton<InformationResourcesRepository>(
    () => InformationResourcesRepositoryImpl(
      networkInfo: sl(),
      remoteDatastore: sl(),
    ),
  );

  //datasources
  sl.registerLazySingleton<InformationResourcesRemoteDatastore>(
    () => InformationResourcesRemoteDatastoreImpl(
      urls: sl(),
      client: sl(),
    ),
  );
}

//!init media

initMedia() {
  //bloc
  sl.registerFactory(
    () => MediaBloc(
        takePictureWithCamera: sl(),
        selectImageFromGallery: sl(),
        convertImageToBase64: sl()),
  );

  //usecases
  sl.registerLazySingleton(
    () => TakePictureWithCamera(repository: sl()),
  );
  sl.registerLazySingleton(
    () => SelectImageFromGallery(repository: sl()),
  );
  sl.registerLazySingleton(
    () => ConvertImageToBase64(repository: sl()),
  );

  //repository

  sl.registerLazySingleton<MediaRepository>(
    () => MediaRepositoryImpl(localDatasource: sl()),
  );

  //datasources
  sl.registerLazySingleton<MediaLocalDatasource>(
    () => MediaLocalDatasourceImpl(imagePicker: sl()),
  );
}

//! init USER

initUser() {
  //bloc

  sl.registerFactory(
    () => UserBloc(
      createDriverLicense: sl(),
      editDriverLicense: sl(),
      getUserProfile: sl(),
      editProfile: sl(),
      createVehicle: sl(),
      editVehicle: sl(),
      getAllRiderVehicles: sl(),
      getAllRidersLicense: sl(),
      changeAvailability: sl(),
      getCachedUserInfo: sl(),
      updateCachedUser: sl(),
      getCachedUserWithoutSafety: sl(),
      riderPhotoCheck: sl(),
      getSupportContacts: sl(),
      deleteAccount: sl(),
      cacheRiderId: sl(),
    ),
  );

  //usecases

  sl.registerLazySingleton(
    () => CacheRiderId(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => ChangeAvailability(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => RiderPhotoCheck(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => CreateVehicle(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => EditVehicle(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetAllRiderVehicles(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => CreateDriverLicense(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => EditDriverLicense(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetCachedUserInfo(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetCachedUserWithoutSafety(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetAllRidersLicense(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetUserProfile(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => EditProfile(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => UpdateCachedUser(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetSupportContacts(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => DeleteAccount(
      repository: sl(),
    ),
  );

  //repository

  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDatasource: sl(),
      localDatasource: sl(),
      networkInfo: sl(),
    ),
  );

  //datasources

  sl.registerLazySingleton<UserRemoteDatasource>(
    () => UserRemoteDatasourceImpl(
      urls: sl(),
      client: sl(),
    ),
  );

  sl.registerLazySingleton<UserLocalDatasource>(
    () => UserLocalDatasourceImpl(
      sharedPreferences: sl(),
    ),
  );
}

//!INIT TRIPS
initTrips() {
  //bloc
  sl.registerFactory(
    () => TripsBloc(
      cancelTrip: sl(),
      getAllTrips: sl(),
      rateTrip: sl(),
      getTripInfo: sl(),
      reportTrip: sl(),
      acceptOrRejectTrip: sl(),
      getTripStatus: sl(),
      playSound: sl(),
      stopSound: sl(),
      getTrackingDetails: sl(),
      riderTripDestinationActions: sl(),
      getDirections: sl(),
      playDirectionSound: sl(),
      stopDirectionPlaySound: sl(),
    ),
  );

  //usecases

  sl.registerLazySingleton(
    () => GetDirections(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => RiderTripDestinationActions(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetTrackingDetails(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => PlaySound(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => StopSound(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => AcceptOrRejectTrip(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetTripStatus(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => CancelTrip(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetAllTrips(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => RateTrip(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetTripInfo(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => ReportTrip(
      repository: sl(),
    ),
  );

  //repository
  sl.registerLazySingleton<TripsRepository>(
    () => TripsRepositoryImpl(
      networkInfo: sl(),
      tripRemoteDataSource: sl(),
      localDatasource: sl(),
    ),
  );

  //datasources
  sl.registerLazySingleton<TripRemoteDataSource>(
    () => TripRemoteDataSourceImpl(
      urls: sl(),
      client: sl(),
      socket: sl(),
    ),
  );

  sl.registerLazySingleton<TripsLocalDatasource>(
    () => TripsLocalDatasourceImpl(player: sl(), flutterTts: sl()),
  );
}
