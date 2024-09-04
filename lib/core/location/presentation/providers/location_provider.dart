import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rideme_driver/core/location/domain/usecases/cache_locations.dart';
import 'package:rideme_driver/core/location/domain/usecases/retrieve_locations.dart';

class LocationProvider extends ChangeNotifier {
  final CacheLocation cacheLocation;
  final RetrieveLocations retrieveLocations;

  LocationProvider({
    required this.cacheLocation,
    required this.retrieveLocations,
  });

  final BitmapDescriptor _customIcon = BitmapDescriptor.defaultMarker;

  BitmapDescriptor get customIcon => _customIcon;

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  loadCustomIcon() async {
    //TODO: GET THE RIGHT IMAGE HERE
    // final markericon =
    //     await getBytesFromAsset(ImageNameConstants.locatorPinImg, 150);

    // _customIcon = BitmapDescriptor.bytes(markericon);
  }
}
