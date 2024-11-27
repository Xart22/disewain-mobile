import 'package:disewainaja/app/data/providers/service_request_provider.dart';
import 'package:disewainaja/app/services/location_service.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MapsController extends GetxController {
  final ServiceRequestProvider _serviceRequestProvider =
      ServiceRequestProvider();
  final _locationService = Get.find<LocationService>();
  final args = Get.arguments;
  final mapController = MapController();
  final latitude = Rx<double>(-6.2088);
  final longitude = Rx<double>(106.8456);

  var routePoints = <LatLng>[].obs;
  var routeDistance = "0".obs;
  var routeDuration = "0".obs;

  var isLoading = true.obs;

  Future<void> _getRoute() async {
    try {
      final position = await _locationService.getCurrentLocation();
      final routeData = await _serviceRequestProvider.fetchRoute(
          LatLng(
            position!.latitude,
            position.longitude,
          ),
          LatLng(
            latitude.value,
            longitude.value,
          ));

      // Decode GeoJSON LineString menjadi List<LatLng>
      final coordinates = routeData['geometry']['coordinates'] as List;
      final points = coordinates.map((coord) {
        return LatLng(coord[1], coord[0]);
      }).toList();

      routePoints.value = points;
      routeDistance.value =
          routeData['distance'].toStringAsFixed(2).replaceAll('.', ',');
      routeDuration.value = routeData['duration'].toString();
      isLoading.value = false;
    } catch (e, s) {
      print('Error fetching route: $e');
      print('Stack trace: $s');
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (args["lat"] != null) {
      // convert to double
      latitude.value = double.parse(args["lat"]);
    }
    if (args["long"] != null) {
      longitude.value = double.parse(args["long"]);
    }
    _getRoute();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    mapController.dispose();
  }
}
