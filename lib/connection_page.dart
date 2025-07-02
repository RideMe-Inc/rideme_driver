import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rideme_driver/assets/images/image_name_constants.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';
import 'package:rideme_driver/core/widgets/loaders/loading_indicator.dart';
import 'package:rideme_driver/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:rideme_driver/features/authentication/presentation/provider/authentication_provider.dart';
import 'package:rideme_driver/features/home/presentation/provider/home_provider.dart';
import 'package:rideme_driver/features/localization/presentation/providers/locale_provider.dart';
import 'package:rideme_driver/features/permissions/presentation/bloc/permission_bloc.dart';
import 'package:rideme_driver/features/user/presentation/bloc/user_bloc.dart';
import 'package:rideme_driver/features/user/presentation/provider/user_provider.dart';
import 'package:rideme_driver/injection_container.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  final authBloc = sl<AuthenticationBloc>();
  final userBloc = sl<UserBloc>();

  final permissionBloc = sl<PermissionBloc>();
  late AuthenticationProvider provider;
  //request location permissions
  requestAllNecessaryPermissions() {
    permissionBloc.add(RequestAllNecessaryPermissionsEvent());
  }

  getUserProfile(String token) {
    final params = {
      "locale": context.read<LocaleProvider>().locale,
      "bearer": token,
    };

    userBloc.add(GetUserProfileEvent(params: params));
  }

  int timerR = 0;
  Timer? timer;

  //delay timer
  startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (timerR < 5) {
          setState(() {
            timerR++;
          });
        } else {
          timer.cancel();
        }
      },
    );
  }

  @override
  void initState() {
    context.read<HomeProvider>().loadInitialMarker();
    authBloc.add(RecoverTokenEvent());

    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    provider = context.read<AuthenticationProvider>();
    return Scaffold(
      backgroundColor: AppColors.rideMeBackgroundLight,
      bottomSheet: timerR == 5
          ? const LoadingIndicator(
              width: double.infinity,
              indicatorColor: AppColors.rideMeBlueNormal,
              backgroundColor: AppColors.rideMeBackgroundLight,
            )
          : null,
      body: MultiBlocListener(
        listeners: [
          //PERMISSION BLOC
          BlocListener(
            bloc: permissionBloc,
            listener: (context, state) {},
          ),

          //AUTH BLOC
          BlocListener(
            bloc: authBloc,
            listener: (context, state) {
              //RECOVER TOKEN FAILURE
              if (state is RecoverTokenError) {
                requestAllNecessaryPermissions();
                //send user to landing page
                context.goNamed('login');
              }

              //RECOVER TOKEN SUCCESS
              if (state is RecoverTokenLoaded) {
                final params = {
                  "locale": context.appLocalizations.localeName,
                  "bearer": state.authorizationInfo.token
                };

                authBloc.add(GetRefreshTokenEvent(params: params));
              }

              //REFRESH TOKEN FAILURE

              if (state is GetRefreshTokenError) {
                if (state.isNoInternet) {
                  // navigate to no internet page

                  context.goNamed('noInternet');
                } else {
                  // navigate to login screen

                  requestAllNecessaryPermissions();

                  context.goNamed('login');
                }
              }

              //REFRESH TOKEN SUCCESS

              if (state is GetRefreshTokenLoaded) {
                provider.updateToken = state.authorizationInfo.token!;

                getUserProfile(state.authorizationInfo.token!);
              }
            },
          ),

          //USER BLOC
          BlocListener(
            bloc: userBloc,
            listener: (context, state) {
              if (state is GetUserProfileLoaded) {
                //udpate provider with user data and navigate to home
                context.read<UserProvider>().updateUserInfo =
                    state.driver.profile;

                userBloc.cacheRiderID(state.driver.profile.id!.toInt());

                userBloc.navigateRiderBasedOnProfileCompletion(
                    state.driver, context);
              }

              if (state is GetUserProfileError) {
                context.goNamed('noInternet');
              }
            },
          ),
        ],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                ImageNameConstants.ridemeLogoIMG,
                height: Sizes.height(
                  context,
                  0.25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
