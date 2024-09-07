import 'package:go_router/go_router.dart';
import 'package:rideme_driver/connection_page.dart';
import 'package:rideme_driver/features/authentication/presentation/pages/driver_license_page.dart';

import 'package:rideme_driver/features/authentication/presentation/pages/enter_personal_details.dart';
import 'package:rideme_driver/features/authentication/presentation/pages/landing_page.dart';

import 'package:rideme_driver/features/authentication/presentation/pages/no_internet_page.dart';
import 'package:rideme_driver/features/authentication/presentation/pages/otp_verification_page.dart';
import 'package:rideme_driver/features/authentication/presentation/pages/phone_entry_page.dart';
import 'package:rideme_driver/features/authentication/presentation/pages/photo_check.dart';
import 'package:rideme_driver/features/authentication/presentation/pages/pledge_page.dart';
import 'package:rideme_driver/features/authentication/presentation/pages/vehicle_document_page.dart';
import 'package:rideme_driver/features/home/presentation/pages/home_page.dart';
import 'package:rideme_driver/features/trips/presentation/pages/track_trip.dart';
import 'package:rideme_driver/features/trips/presentation/pages/trip_accept_reject.dart';
import 'package:rideme_driver/features/trips/presentation/pages/trip_history.dart';
import 'package:rideme_driver/features/trips/presentation/pages/trip_history_details_page.dart';
import 'package:rideme_driver/features/trips/presentation/pages/trip_status_check_page.dart';
import 'package:rideme_driver/features/user/presentation/pages/delete_account_page.dart';
import 'package:rideme_driver/features/user/presentation/pages/edit_profile.dart';
import 'package:rideme_driver/features/user/presentation/pages/safety_page.dart';

final GoRouter goRouterConfiguration = GoRouter(
  initialLocation: '/',
  routes: [
    //ROOT
    GoRoute(
      name: 'root',
      path: '/',
      builder: (context, state) => const ConnectionPage(),
    ),

    //NO INTERNET
    GoRoute(
      name: 'noInternet',
      path: '/no-internet',
      builder: (context, state) => const NoInternetPage(),
    ),

    //LANDING PAGE
    GoRoute(
      name: 'landing',
      path: '/landing',
      builder: (context, state) => const LandingPage(),
    ),

    //AUTHENTICATION
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const PhoneEntryPage(),
      routes: [
        //otp verification

        GoRoute(
          name: 'otpVerification',
          path: 'otp-verification',
          builder: (context, state) => OtpVerificationPage(
            phoneNumber: state.uri.queryParameters['phone'] ?? '',
            token: state.uri.queryParameters['token'] ?? '',
            userExist:
                bool.parse(state.uri.queryParameters['user_exist'] ?? 'false'),
          ),
        ),

        //COMPLETE SIGN UP
        GoRoute(
          name: 'signup',
          path: 'signup',
          builder: (context, state) => EnterPersonalDetailsPage(
            token: state.uri.queryParameters['token'] ?? '',
          ),
        )
      ],
    ),

    //LICENSE

    GoRoute(
      name: 'licenseInformation',
      path: '/license-information',
      builder: (context, state) => LicenseInformationPage(
        from: state.uri.queryParameters['from'],
      ),
    ),

    //VEHICLE
    GoRoute(
      name: 'vehicleInformation',
      path: '/vehicle-information',
      builder: (context, state) => VehicleDocumentPage(
        from: state.uri.queryParameters['from'],
      ),
    ),

    //PHOTO CHECK
    GoRoute(
      name: 'photoCheck',
      path: '/photo-check',
      builder: (context, state) => PhotoCheckPage(
        from: state.uri.queryParameters['from'],
      ),
    ),

    //PLEDGE
    GoRoute(
      name: 'pledge',
      path: '/pledge',
      builder: (context, state) => const PledgePage(),
    ),

    //HOME
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) => const HomePage(),
      routes: [
        //deleteAccount
        GoRoute(
          name: 'deleteAccount',
          path: 'delete-account',
          builder: (context, state) => const DeleteAccountPage(),
        ),

        //safety
        GoRoute(
          name: 'safety',
          path: 'safety',
          builder: (context, state) => const SafetyPage(),
        ),

        //profile

        //edit profile
        GoRoute(
          name: 'editProfile',
          path: 'edit',
          builder: (context, state) => const EditProfilePage(),
        ),

        //history

        GoRoute(
          name: 'trips',
          path: 'trips',
          builder: (context, state) => const TripHistoryPage(),
          routes: [
            GoRoute(
              name: 'historyDetails',
              path: 'history-details',
              builder: (context, state) => TripHistoryDetailsPage(
                  tripId: state.uri.queryParameters['tripId'] ?? ''),
            )
          ],
        ),
      ],
    ),

    GoRoute(
      name: 'tripStatusCheck',
      path: 'trip-status-check',
      builder: (context, state) => TripStatusChecker(
        tripData: state.uri.queryParameters['tripData'],
        tripId: state.uri.queryParameters['tripId'],
      ),
    ),

    //TRIP ACCEPT REJECT
    GoRoute(
      name: 'tripAcceptReject',
      path: 'trip-accept-reject',
      builder: (context, state) => TripAcceptRejectPage(
        tripRequestInfo: state.uri.queryParameters['tripinfo']!,
      ),
    ),

    GoRoute(
      name: 'trackTrip',
      path: 'track-trip',
      builder: (context, state) =>
          TrackTripPage(tripId: state.uri.queryParameters['tripId']!),
    )
  ],
);
