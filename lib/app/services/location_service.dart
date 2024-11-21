import 'package:geolocator/geolocator.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService extends GetxService {
  //request permission
  Future<bool> requestPermission() async {
    print('Requesting location permission');
    final status = await Permission.location.request();
    if (status.isGranted) {
      return true;
    }
    return false;
  }

  Future<bool> checkPermission() async {
    final status = await Permission.locationAlways.status;
    if (status.isPermanentlyDenied) {
      return false;
    }
    return status.isGranted;
  }

  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<Position?> getCurrentLocation() async {
    try {
      if (await checkPermission() == false) {
        throw Exception('Location permission denied');
      }

      if (await isLocationServiceEnabled() == false) {
        throw Exception('Location services are disabled');
      }

      return await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.bestForNavigation,
        ),
      );
    } catch (e) {
      throw Exception('Error getting location: $e');
    }
  }
}
