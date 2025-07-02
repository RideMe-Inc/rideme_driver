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
  availability(value: '/profile/availabilities'),
  photoCheck(value: '/photo-check'),
  getSupportContacts(value: '/configs/support-contact'),

  //!TRIPS
  trip(value: '/trips'),
  bookTrip(value: '/trips/:id/book'),
  tripDetails(value: '/trips/:id'),
  trackTrip(value: '/trips/:id/tracking'),
  reportTrip(value: '/trips/:id/reports'),
  rateTrip(value: '/trips/:id/ratings'),
  tripActions(value: '/trips/:id/:actions'),
  tripStatus(value: '/trips/:id/status'),

  //! LOCATION
  myLocation(value: '/geo-data'),

  vehicleMakes(value: '/data/vehicle-makes'),
  vehicleColors(value: '/data/vehicle-colors');

  final String value;

  const Endpoints({required this.value});
}
