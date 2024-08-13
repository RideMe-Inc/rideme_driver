import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideme_driver/core/usecase/usecase.dart';
import 'package:rideme_driver/features/authentication/domain/entity/authentication.dart';
import 'package:rideme_driver/features/authentication/domain/entity/authorization.dart';
import 'package:rideme_driver/features/authentication/domain/entity/init_auth_info.dart';

import 'package:rideme_driver/features/authentication/domain/usecases/get_refresh_token.dart';
import 'package:rideme_driver/features/authentication/domain/usecases/init_auth.dart';
import 'package:rideme_driver/features/authentication/domain/usecases/logout.dart';

import 'package:rideme_driver/features/authentication/domain/usecases/recover_token.dart';

import 'package:rideme_driver/features/authentication/domain/usecases/sign_up.dart';

import 'package:rideme_driver/features/authentication/domain/usecases/verify_otp.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final InitAuth initAuth;
  final VerifyOtp verifyOtp;

  final GetRefreshToken getRefreshToken;

  final SignUp signUp;
  final RecoverToken recoverToken;

  final LogOut logOut;

  AuthenticationBloc({
    required this.initAuth,
    required this.verifyOtp,
    required this.getRefreshToken,
    required this.recoverToken,
    required this.signUp,
    required this.logOut,
  }) : super(AuthenticationInitial()) {
    //! INIT AUTHENTICATION
    on<InitAuthenticationEvent>((event, emit) async {
      emit(InitAuthenticationLoading());

      final response = await initAuth(event.params);

      emit(
        response.fold(
          (errorMessage) =>
              GenericAuthenticationError(errorMessage: errorMessage),
          (response) => InitAuthenticationLoaded(initAuth: response),
        ),
      );
    });

    //! VERIFY OTP
    on<VerifyOtpEvent>((event, emit) async {
      emit(VerifyOtpLoading());

      final response = await verifyOtp(event.params);

      emit(
        response.fold(
          (errorMessage) =>
              GenericAuthenticationError(errorMessage: errorMessage),
          (response) => VerifyOtpLoaded(authenticationInfo: response),
        ),
      );
    });

    //! RESEND CODE
    on<ResendCodeEvent>((event, emit) async {
      emit(ResendCodeLoading());

      final response = await initAuth(event.params);

      emit(
        response.fold(
          (errorMessage) => ResendCodeError(errorMessage: errorMessage),
          (response) => ResendCodeLoaded(initAuth: response),
        ),
      );
    });

    //!SIGN UP

    on<SignUpEvent>((event, emit) async {
      emit(SignupLoading());
      final response = await signUp(event.params);

      emit(
        response.fold(
          (errorMessage) =>
              GenericAuthenticationError(errorMessage: errorMessage),
          (response) => SignupLoaded(authenticationInfo: response),
        ),
      );
    });

    //! GET REFRESH TOKEN
    on<GetRefreshTokenEvent>((event, emit) async {
      emit(GetRefreshTokenLoading());

      final response = await getRefreshToken(event.params);

      emit(
        response.fold(
          (errorMessage) => GetRefreshTokenError(
            isNoInternet: errorMessage == 'No internet connection',
          ),
          (response) => GetRefreshTokenLoaded(authorizationInfo: response),
        ),
      );
    });

    //!RECOVER TOKEN
    on<RecoverTokenEvent>((event, emit) async {
      final response = await recoverToken(NoParams());

      emit(
        response.fold(
          (error) => RecoverTokenError(),
          (response) => RecoverTokenLoaded(authorizationInfo: response),
        ),
      );
    });

    //!LOG OUT

    on<LogOutEvent>((event, emit) async {
      emit(LogOutLoading());

      final response = await logOut(event.params);

      emit(
        response.fold(
          (error) => GenericAuthenticationError(errorMessage: error),
          (response) => LogOutLoaded(message: response),
        ),
      );
    });
  }
}
