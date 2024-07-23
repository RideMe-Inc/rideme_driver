import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rideme_driver/core/location/domain/entity/geo_hash.dart';

mixin LocationMixin {
  //GET STATIC MAP URL
  String staticMapUrl({
    required double lat,
    required double lng,
    String? size,
    String? zoom,
    String? polyline,
    double? dropOffLlat,
    double? dropOffLng,
  }) {
    return polyline == null
        ? 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&scale=2&zoom=${zoom ?? 14}&size=${size ?? '400x400'}&key=AIzaSyCcNLZGoUqLsA4jeKVudD6DNSLg0odLg1A'
        : 'https://maps.googleapis.com/maps/api/staticmap?scale=2&size=720x200&path=weight:5%7Ccolor:0x000112%7Cenc:$polyline&markers=icon:https://res.cloudinary.com/dbuarum93/image/upload/v1709218770/WhatsApp_Image_2024-02-29_at_13.01.04-2-removebg-preview_quguvw.png%7C$lat,$lng&markers=icon:https://res.cloudinary.com/dbuarum93/image/upload/v1709218826/WhatsApp_Image_2024-02-29_at_13.01.04-removebg-preview_yz90ft.png%7C$dropOffLlat,$dropOffLng&style=feature:poi%7Celement:all%7Cvisibility:off&key=AIzaSyCcNLZGoUqLsA4jeKVudD6DNSLg0odLg1A';
  }

  //decoded location
  decodeLocation({
    required GeoData? defaultLocation,
    required TextEditingController locationController,
    required Map location,
  }) {
    locationController.text = defaultLocation?.address ?? '';

    location['id'] = defaultLocation?.id;
    location['lat'] = defaultLocation?.lat;
    location['lng'] = defaultLocation?.lng;
  }

  String getDeliveryTime({
    required double userLatitude,
    required double userLongitude,
    required double shopLatitude,
    required double shopLongitude,
  }) {
    final distance = getDistanceFromLatLonInKm(
      userLatitude: userLatitude,
      userLongitude: userLongitude,
      shopLatitude: shopLatitude,
      shopLongitude: shopLongitude,
    );

    int time = (((distance * 1.35) / 30) * 60).round();
    time = time == 0 ? 1 : time;

    return '$time-${time + 10}';
  }

  double getDistanceFromLatLonInKm({
    required double userLatitude,
    required double userLongitude,
    required double shopLatitude,
    required double shopLongitude,
  }) {
    const radius = 6371; // Radius of the earth in km
    final dLat = degToRad(shopLatitude - userLatitude); // degToRad below
    final dLon = degToRad(shopLongitude - userLongitude);
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(degToRad(userLatitude)) *
            cos(degToRad(shopLatitude)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    final distance = radius * c; // Distance in km
    return distance;
  }

  double degToRad(deg) {
    return (deg * pi) / 180;
  }
}
