import 'dart:developer';

import 'package:geolocator/geolocator.dart';

class Location {
  double? latidue;
  double? longidue;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      latidue = position.latitude;
      longidue = position.longitude;
    } catch (e) {
      log('Something goes wrong: $e');
    }
  }
}
