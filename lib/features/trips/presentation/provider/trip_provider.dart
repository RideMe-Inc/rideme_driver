import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TripProvider extends ChangeNotifier {
  int _index = 0;
  int _rating = 0;
  bool _notRun = true;
  bool _isPickup = false;
  bool _isGeoLoading = false;
  Marker? _realMarker;
  bool _initialCameraMove = false;
  int? _timeToArrival;

  final _polylinePoints = PolylinePoints();
  List<PointLatLng> _polyLines = [];
  List<LatLng> _polyCoordinates = [];
  //get
  int? get timeToArrival => _timeToArrival;
  bool get initialCameraMove => _initialCameraMove;
  bool get notRun => _notRun;
  Marker? get realMarker => _realMarker;
  List<PointLatLng> get polyLines => _polyLines;
  List<LatLng> get polyCoordinates => _polyCoordinates;
  bool get isPickup => _isPickup;
  bool get isGeoLoading => _isGeoLoading;
  int get index => _index;
  int get rating => _rating;

  //set

  set updateInitialCameraMove(bool value) {
    _initialCameraMove = value;
    notifyListeners();
  }

  set updateMarker(Marker marker) {
    _realMarker = marker;

    notifyListeners();
  }

  set updateFirstRunner(bool value) {
    _notRun = value;
    notifyListeners();
  }

  set updateIsPickup(bool value) {
    _isPickup = value;
    notifyListeners();
  }

  set updateIsGeoLoading(bool value) {
    _isGeoLoading = value;
    notifyListeners();
  }

  set updateIndex(int value) {
    _index = value;
    notifyListeners();
  }

  set updateRating(int value) {
    _rating = value;
    notifyListeners();
  }

  set updateTimeToArrival(int value) {
    _timeToArrival = value;
    notifyListeners();
  }

  //decodePolyline
  decodePolyline(String polyline) async {
    //deal with polylines

    _polyLines = _polylinePoints.decodePolyline(polyline);

    notifyListeners();
  }

  resetAllValues() {
    _initialCameraMove = false;
    _notRun = true;
    _timeToArrival = null;
    notifyListeners();
  }

//convert image into bytes

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  resetRating() {
    _rating = 0;
  }
}
