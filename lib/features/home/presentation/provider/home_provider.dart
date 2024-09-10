import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rideme_driver/assets/images/image_name_constants.dart';

class HomeProvider extends ChangeNotifier {
  BitmapDescriptor _customMarkerIcon = BitmapDescriptor.defaultMarker;

  BitmapDescriptor _startIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor _endIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor _trackingIcon = BitmapDescriptor.defaultMarker;
  final Set<Marker> _markers = {};
  String? _refreshedToken;
  // GeoDataInfo? _geoDataInfo;
  bool _isLocationAllowed = true;
  // ServiceInfo? _serviceInfo;
  int _numberOfActiveTrips = 0;

  // List<RiderLocation> _riderLocations = [];
  // List<GeoDataInfo> _topLocations = [];

  String _testing = 'nothing';

  //get

  BitmapDescriptor get customMarkerIcon => _customMarkerIcon;
  bool get isLocationAllowed => _isLocationAllowed;
  // GeoDataInfo? get geoDataInfo => _geoDataInfo;
  BitmapDescriptor get startIcon => _startIcon;
  BitmapDescriptor get endIcon => _endIcon;
  BitmapDescriptor get trackingIcon => _trackingIcon;
  String? get refreshedToken => _refreshedToken;
  // ServiceInfo? get serviceInfo => _serviceInfo;

  Set<Marker> get markers => _markers;

  // List<RiderLocation> get riderLocations => _riderLocations;
  // List<GeoDataInfo> get topLocations => _topLocations;
  int get numberOfActiveTrips => _numberOfActiveTrips;

  String get testing => _testing;

  set updateRefreshToken(String value) {
    _refreshedToken = value;
    notifyListeners();
  }

  // set updateServiceInfo(ServiceInfo value) {
  //   _serviceInfo = value;
  //   notifyListeners();
  // }

  set testingValue(String value) {
    _testing = value;
    notifyListeners();
  }

  set updateLocationAllowed(bool value) {
    _isLocationAllowed = value;
    notifyListeners();
  }

  // set updateGeoDataInfo(GeoDataInfo value) {
  //   _geoDataInfo = value;
  //   notifyListeners();
  // }

  set setNumberOfActiveTrips(int value) {
    _numberOfActiveTrips = value;
    notifyListeners();
  }

  //load initial marker
  loadInitialMarker() async {
    final markericon =
        await getBytesFromAsset(ImageNameConstants.carTracking, 35);
    final starterIcon =
        await getBytesFromAsset(ImageNameConstants.startTrip, 20);
    final endedIcon = await getBytesFromAsset(ImageNameConstants.endTrip, 20);
    final trackingIcon =
        await getBytesFromAsset(ImageNameConstants.driverTracking, 35);

    _customMarkerIcon = BitmapDescriptor.bytes(markericon);
    _startIcon = BitmapDescriptor.bytes(starterIcon);
    _endIcon = BitmapDescriptor.bytes(endedIcon);
    _trackingIcon = BitmapDescriptor.bytes(trackingIcon);

    notifyListeners();
  }

  //update active trips
  updateActiveTrips(bool isAdd) {
    isAdd ? _numberOfActiveTrips += 1 : _numberOfActiveTrips -= 1;
    notifyListeners();
  }

  //set riderlocations

  // set setRiderLocations(List<RiderLocation> riders) {
  //   _riderLocations = riders;
  //   notifyListeners();
  // }

  // //set toplocations

  // set setTopLocations(List<GeoDataInfo> places) {
  //   _topLocations = places;
  //   notifyListeners();
  // }

  //update markers with updated rider information

  // updateMarkersWithUpdateRiderMovement(RiderLocation updatedMark) {
  //   final markerHolder = Marker(
  //     markerId: MarkerId(
  //       updatedMark.riderID.toString(),
  //     ),
  //     rotation: updatedMark.heading?.toDouble() ?? 0,
  //     icon: _customMarkerIcon,
  //     position: LatLng(
  //       updatedMark.latitude?.toDouble() ?? 0,
  //       updatedMark.longitude?.toDouble() ?? 0,
  //     ),
  //   );

  //   _markers
  //       .removeWhere((element) => element.markerId == markerHolder.markerId);

  //   _markers.add(markerHolder);

  //   notifyListeners();
  // }

  //update markers
  // updateMarkers() {
  //   for (var marks in _riderLocations) {
  //     _markers.add(
  //       Marker(
  //         rotation: marks.heading?.toDouble() ?? 0,
  //         icon: _customMarkerIcon,
  //         markerId: MarkerId(
  //           marks.riderID.toString(),
  //         ),
  //         position: LatLng(
  //           marks.latitude?.toDouble() ?? 0,
  //           marks.longitude?.toDouble() ?? 0,
  //         ),
  //       ),
  //     );
  //   }

  //   notifyListeners();
  // }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
