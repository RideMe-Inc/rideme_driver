import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideme_driver/core/widgets/loaders/loading_indicator.dart';
import 'package:rideme_driver/core/widgets/popups/error_popup.dart';
import 'package:rideme_driver/core/widgets/popups/success_popup.dart';
import 'package:rideme_driver/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:rideme_driver/features/authentication/presentation/provider/authentication_provider.dart';
import 'package:rideme_driver/features/user/presentation/provider/user_provider.dart';
import 'package:rideme_driver/features/localization/presentation/providers/locale_provider.dart';
import 'package:rideme_driver/features/user/presentation/bloc/user_bloc.dart';
import 'package:rideme_driver/injection_container.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';

import 'package:rideme_driver/features/authentication/presentation/widgets/otp_textfield.dart';

class OtpVerificationPage extends StatefulWidget {
  final String phoneNumber, token;
  final bool userExist;
  const OtpVerificationPage({
    super.key,
    required this.phoneNumber,
    required this.token,
    required this.userExist,
  });

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final otpController = TextEditingController();

  final authBloc = sl<AuthenticationBloc>();
  final userBloc = sl<UserBloc>();
  Timer? timer;
  int _minute = 2;
  String otp = '';
  int _seconds = 0;
  int seconds = 120;
  bool invalidOtp = false;
  bool canResendOtp = false;
  bool isButtonActive = false;
  String timeRemaining = '2:00';

  resendOnTap() {
    final params = {
      "locale": context.read<LocaleProvider>().locale,
      "body": {
        "token": widget.token,
        "phone": widget.phoneNumber,
      }
    };
    authBloc.add(ResendCodeEvent(params: params));
  }

  countdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds == 0) {
        timer.cancel();
        setState(() {
          canResendOtp = true;
        });
      } else if (seconds > 0) {
        seconds--;
        _minute = seconds ~/ 60;
        _seconds = seconds - _minute * 60;
        timeRemaining = '$_minute:${_seconds < 10 ? '0$_seconds' : _seconds}';
        setState(() {});
      }
    });
  }

  verifyOtp() {
    final params = {
      "locale": context.read<LocaleProvider>().locale,
      "body": {
        "code": otp,
        "token": widget.token,
      }
    };

    authBloc.add(VerifyOtpEvent(params: params));
  }

  getUserProfile(String token) {
    final params = {
      "locale": context.read<LocaleProvider>().locale,
      "bearer": token,
    };

    userBloc.add(GetUserProfileEvent(params: params));
  }

  onCompleted(String value) {
    setState(() => otp = value);

    verifyOtp();
  }

  @override
  void initState() {
    countdown();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener(
        bloc: userBloc,
        listener: (context, state) {
          if (state is GetUserProfileLoaded) {
            //udpate provider with user data and navigate to home
            context.read<UserProvider>().updateUserInfo = state.driver.profile;
            userBloc.cacheRiderID(state.driver.profile.id!.toInt());

            userBloc.navigateRiderBasedOnProfileCompletion(
                state.driver, context);
          }

          if (state is GetUserProfileError) {
            showErrorPopUp(state.message, context);
          }
        },
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Sizes.height(context, 0.02)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.appLocalizations.enterYourOtpCode,
                style: context.textTheme.displayLarge?.copyWith(
                  color: AppColors.rideMeBlackNormalActive,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Space.height(context, 0.012),
              RichText(
                text: TextSpan(
                    text: context.appLocalizations.enterYourOtpCodeInfo,
                    style: context.textTheme.displaySmall,
                    children: [
                      TextSpan(
                        text: ' ${widget.phoneNumber}',
                        style: context.textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ]),
              ),
              Space.height(context, 0.034),
              OTPTextfield(
                hasError: invalidOtp,
                onChanged: (p0) {},
                onCompleted: onCompleted,
                controller: otpController,
                canResendOTP: canResendOtp,
                timeRemaining: timeRemaining,
                resendOnTap: canResendOtp ? resendOnTap : null,
              ),
              Space.height(context, 0.01),
              BlocConsumer(
                bloc: authBloc,
                listener: (context, state) {
                  if (state is GenericAuthenticationError) {
                    showErrorPopUp(state.errorMessage, context);
                  }

                  if (state is ResendCodeLoaded) {
                    showSuccessPopUp('Code resent', context);

                    setState(() {
                      _minute = 2;
                      _seconds = 0;
                      seconds = 120;
                      canResendOtp = false;
                      timeRemaining = '2:00';
                    });
                    countdown();
                  }

                  if (state is VerifyOtpLoaded) {
                    getUserProfile(
                        state.authenticationInfo.authorization!.token!);

                    context.read<AuthenticationProvider>().updateToken =
                        state.authenticationInfo.authorization?.token;
                    return;
                  }
                },
                builder: (context, state) {
                  if (state is VerifyOtpLoading || state is ResendCodeLoading) {
                    return const LoadingIndicator();
                  }
                  return Space.height(context, 0);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
