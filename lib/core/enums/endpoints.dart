enum Endpoints {
  //! CONFIGS
  getGeoID(value: '/configs/geo-data'),

  //! AUTH
  initAuth(value: '/auth/init'),
  logOut(value: '/auth/logout'),
  signIn(value: '/auth/sign-in'),
  signUp(value: '/auth/sign-up'),
  verifyOTP(value: '/auth/verify-otp'),
  resendOTP(value: '/auth/resend-otp'),
  getRefereshToken(value: '/auth/refresh'),
  recoverPassword(value: '/auth/recovery'),
  socialLogin(value: '/auth/social-login'),
  socialSignUp(value: '/auth/social-sign-up'),
  setNewPassword(value: '/auth/set-password'),
  resetPassword(value: '/auth/reset-password'),
  changePassword(value: '/auth/change-password'),

  //! LOCATION
  myLocation(value: '/geo-data');

  final String value;

  const Endpoints({required this.value});
}
