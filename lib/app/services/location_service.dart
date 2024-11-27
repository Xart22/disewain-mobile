import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService extends GetxService {
  var availableMaps = <AvailableMap>[].obs;
  //request permission
  Future<void> requestPermission() async {
    await Permission.location.request();
  }

  Future<bool> checkPermission() async {
    final status = await Permission.location.status;
    availableMaps.value = await MapLauncher.installedMaps;
    if (status.isGranted) {
      return true;
    }
    return false;
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

  Future<dynamic> calculateDistance(double lat, double long) async {
    try {
      final position = await getCurrentLocation();
      double distanceInMeters = Geolocator.distanceBetween(
          lat, long, position!.latitude, position.longitude);
      if (distanceInMeters < 10) {
        return {
          'status': true,
          'message': 'You are in the location',
        };
      }
      return {
        'status': false,
        'message': 'Jarak Anda: ${distanceInMeters.toStringAsFixed(2)} meters',
      };
    } catch (e) {
      throw Exception('Error calculating distance: $e');
    }
  }
}
