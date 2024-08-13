part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

//! INIT AUTHENTICATION
class InitAuthenticationEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;

  const InitAuthenticationEvent({required this.params});
}

//! SOCIAL SIGN IN
class SocialSignInEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;

  const SocialSignInEvent({required this.params});
}

//! SIGN IN WITH PHONE
class VerifyOtpEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;

  const VerifyOtpEvent({required this.params});
}

//! RESEND CODE
class ResendCodeEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;

  const ResendCodeEvent({required this.params});
}

//!SIGN UP
class SignUpEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;

  const SignUpEvent({required this.params});
}

//! RECOVER TOKEN
final class RecoverTokenEvent extends AuthenticationEvent {}

//! GET REFRESH TOKEN
final class GetRefreshTokenEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;

  const GetRefreshTokenEvent({required this.params});
}

//!SET NEW PASSWORD
final class SetNewPasswordEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;

  const SetNewPasswordEvent({required this.params});
}

//!CHANGE PASSWORD
final class ChangePasswordEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;

  const ChangePasswordEvent({required this.params});
}

//!LOGIN WITH PASSWORD
final class SignInWithPasswordEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;

  const SignInWithPasswordEvent({required this.params});
}

//!RECOVER PASSWORD
final class RecoverPasswordEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;

  const RecoverPasswordEvent({required this.params});
}

//!LOGOUT
final class LogOutEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;

  const LogOutEvent({required this.params});
}

//!RESET PASSWORD

final class ResetPasswordEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;

  const ResetPasswordEvent({required this.params});
}
