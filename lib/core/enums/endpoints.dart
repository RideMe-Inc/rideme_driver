enum Endpoints {
  //! CONFIGS
  getGeoID(value: '/configs/geo-data'),

  //! AUTH
  initAuth(value: '/auth/init'),
  verifyOTP(value: '/auth/verify-otp'),
  resendOTP(value: '/auth/resend-otp'),
  signUp(value: '/auth/sign-up'),
  logOut(value: '/auth/logout'),
  getRefereshToken(value: '/auth/refresh'),
  profile(value: '/profile'),
  editLicense(value: '/licenses/:licenseId'),

  licenses(value: '/licenses'),
  vehicles(value: '/vehicles'),
  editVehicles(value: '/vehicles/:vehicleId'),
  availability(value: '/availabilities'),
  photoCheck(value: '/photo-check'),
  getSupportContacts(value: '/configs/support-contact'),

  //! LOCATION
  myLocation(value: '/geo-data'),

  vehicleMakes(value: '/configs/vehicle'),
  vehicleModels(value: '/configs/vehicle/:id/models'),
  ;

  final String value;

  const Endpoints({required this.value});
}
