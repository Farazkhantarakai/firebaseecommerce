import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationD extends GetxController {
  RxString cityName = ''.obs;
  RxString streetName = ''.obs;

  String get getCityName => cityName.value;

  String get getStreetName => streetName.value;

  determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position value) async {
      debugPrint(value.latitude.toString());
      debugPrint(value.longitude.toString());

      var placeMarks = await GeocodingPlatform.instance
          .placemarkFromCoordinates(value.latitude, value.longitude);

      Placemark place = placeMarks[0];
      Placemark place2 = placeMarks[2];

      if (place.subLocality! == '') {
        cityName.value = place.locality!;
      } else {
        cityName.value = place.subLocality!;
      }

      debugPrint(place.locality);
      debugPrint(place.street);

      if (place2.street! == '') {
        streetName.value = place.street!;
      } else {
        streetName.value = place2.street!;
      }
      debugPrint(cityName.value);
    });
  }
}
