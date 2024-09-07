import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:rideme_driver/background_services.dart';
import 'package:rideme_driver/core/notifications/notif_handling.dart';
import 'package:rideme_driver/core/routes/go_router_config.dart';
import 'package:rideme_driver/core/theme/app_theme.dart';
import 'package:rideme_driver/features/authentication/presentation/provider/authentication_provider.dart';
import 'package:rideme_driver/features/home/presentation/provider/home_provider.dart';
import 'package:rideme_driver/features/localization/presentation/providers/locale_provider.dart';
import 'package:rideme_driver/features/trips/presentation/provider/trip_provider.dart';
import 'package:rideme_driver/features/user/presentation/provider/user_provider.dart';
import 'package:rideme_driver/firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rideme_driver/injection_container.dart' as di;
import 'package:rideme_driver/injection_container.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  handleNotification(
    message: message,
    context: null,
    isInForeground: false,
  );
}

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await di.init();
  await initializeService();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => sl<LocaleProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthenticationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TripProvider(),
        ),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, value, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: MediaQuery.of(context).textScaler.clamp(
                    minScaleFactor: 1.0,
                    maxScaleFactor: 1.2,
                  ),
            ),
            child: MaterialApp.router(
              theme: appLightTheme,
              debugShowCheckedModeBanner: false,
              routerConfig: goRouterConfiguration,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: Locale.fromSubtags(languageCode: value.locale),
            ),
          );
        },
      ),
    ),
  );
}
