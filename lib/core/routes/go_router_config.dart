import 'package:go_router/go_router.dart';
import 'package:rideme_driver/features/authentication/presentation/pages/driver_license_page.dart';
import 'package:rideme_driver/features/authentication/presentation/pages/enter_email_page.dart';
import 'package:rideme_driver/features/authentication/presentation/pages/enter_personal_details.dart';
import 'package:rideme_driver/features/authentication/presentation/pages/landing_page.dart';
import 'package:rideme_driver/features/authentication/presentation/pages/more_info_addition_page.dart';
import 'package:rideme_driver/features/authentication/presentation/pages/otp_verification_page.dart';
import 'package:rideme_driver/features/authentication/presentation/pages/phone_entry_page.dart';
import 'package:rideme_driver/features/authentication/presentation/pages/photo_check.dart';
import 'package:rideme_driver/features/authentication/presentation/pages/pledge_page.dart';
import 'package:rideme_driver/features/authentication/presentation/pages/vehicle_document_page.dart';

final GoRouter goRouterConfiguration = GoRouter(
  initialLocation: '/',
  routes: [
    //ROOT
    GoRoute(
        name: 'root',
        path: '/',
        builder: (context, state) => const PledgePage()),

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
            name: 'additionalInfo',
            path: 'additional-info',
            builder: (context, state) => EnterEmailPage(
                  token: state.uri.queryParameters['token'] ?? '',
                ),
            routes: [
              GoRoute(
                name: 'moreAdditionalInfo',
                path: 'more-additional-info',
                builder: (context, state) => MoreInfoAdditionPage(
                  token: state.uri.queryParameters['token'] ?? '',
                  email: state.uri.queryParameters['email'] ?? '',
                ),
              )
            ])
      ],
    ),
  ],
);
