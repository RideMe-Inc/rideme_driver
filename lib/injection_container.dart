import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rideme_driver/core/network/networkinfo.dart';
import 'package:rideme_driver/core/urls/urls.dart';
import 'package:rideme_driver/features/localization/data/datasources/localds.dart';
import 'package:rideme_driver/features/localization/data/repository/repo_impl.dart';
import 'package:rideme_driver/features/localization/domain/repository/localization_repo.dart';
import 'package:rideme_driver/features/localization/domain/usecases/change_locale.dart';
import 'package:rideme_driver/features/localization/domain/usecases/get_current_locale.dart';
import 'package:rideme_driver/features/localization/presentation/providers/locale_provider.dart';
import 'package:rideme_driver/features/permissions/data/datasources/localds.dart';
import 'package:rideme_driver/features/permissions/data/repository/repository_impl.dart';
import 'package:rideme_driver/features/permissions/domain/repository/permissions_repo.dart';
import 'package:rideme_driver/features/permissions/domain/usecases/request_all_necessary_permissions.dart';
import 'package:rideme_driver/features/permissions/domain/usecases/request_location_permission.dart';
import 'package:rideme_driver/features/permissions/domain/usecases/request_notif_permission.dart';
import 'package:rideme_driver/features/permissions/presentation/bloc/permission_bloc.dart';
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

  //socket
  sl.registerLazySingleton<WebSocket>(() {
    final socket = WebSocket(Uri.parse('wss://socket.shaqexpress.com/users/'));
    // final testingSocket =
    //     WebSocket(Uri.parse('wss://ws.shaqexpress.com/users/'));

    return socket;
  });
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
