part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

//! INIT AUTHENTICATION

//loading
class InitAuthenticationLoading extends AuthenticationState {}

//loaded
class InitAuthenticationLoaded extends AuthenticationState {
  final InitAuthInfo initAuth;

  const InitAuthenticationLoaded({required this.initAuth});
}

//! SIGN IN WITH PHONE
//loading
class VerifyOtpLoading extends AuthenticationState {}

//loaded
class VerifyOtpLoaded extends AuthenticationState {
  final Authentication authenticationInfo;

  const VerifyOtpLoaded({required this.authenticationInfo});
}

//! RESEND CODE
//loading
class ResendCodeLoading extends AuthenticationState {}

//loaded
class ResendCodeLoaded extends AuthenticationState {
  final InitAuthInfo initAuth;

  const ResendCodeLoaded({required this.initAuth});
}

// resend code error
class ResendCodeError extends AuthenticationState {
  final String errorMessage;

  const ResendCodeError({required this.errorMessage});
}

//!RECOVER TOKEN
//loaded
final class RecoverTokenLoaded extends AuthenticationState {
  final Authorization authorizationInfo;

  const RecoverTokenLoaded({required this.authorizationInfo});
}

final class RecoverTokenError extends AuthenticationState {}

//! GET REFRESH TOKEN
//loading
final class GetRefreshTokenLoading extends AuthenticationState {}

//loaded
final class GetRefreshTokenLoaded extends AuthenticationState {
  final Authorization authorizationInfo;

  const GetRefreshTokenLoaded({required this.authorizationInfo});
}

//error

final class GetRefreshTokenError extends AuthenticationState {
  final bool isNoInternet;

  const GetRefreshTokenError({required this.isNoInternet});
}

//! SIGN UP
final class SignupLoading extends AuthenticationState {}

final class SignupLoaded extends AuthenticationState {
  final Authentication authenticationInfo;

  const SignupLoaded({required this.authenticationInfo});
}

//!LOGOUT

//loading
final class LogOutLoading extends AuthenticationState {}

//loaded
final class LogOutLoaded extends AuthenticationState {
  final String message;

  const LogOutLoaded({required this.message});
}

//! ERRORS

// generic error
class GenericAuthenticationError extends AuthenticationState {
  final String errorMessage;

  const GenericAuthenticationError({required this.errorMessage});
}
