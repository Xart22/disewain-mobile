import 'package:disewainaja/app/shared/components/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

import 'package:get/get.dart';

import '../controllers/maps_controller.dart';
import 'package:latlong2/latlong.dart';

class MapsView extends GetView<MapsController> {
  const MapsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.isLoading.value
          ? const Loading()
          : FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(
                    controller.latitude.value, controller.longitude.value),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(controller.latitude.value,
                          controller.longitude.value),
                      child: Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: controller.routePoints,
                      strokeWidth: 4.0,
                      color: Colors.blue,
                    ),
                  ],
                ),
                CurrentLocationLayer(
                  alignPositionOnUpdate: AlignOnUpdate.never,
                  alignDirectionOnUpdate: AlignOnUpdate.never,
                  style: LocationMarkerStyle(
                    marker: const DefaultLocationMarker(),
                    markerSize: const Size(15, 15),
                    markerDirection: MarkerDirection.top,
                  ),
                ),
                // show estimated route distance and duration
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Estimasi Rute',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Jarak: ${controller.routeDistance} km',
                        ),
                        Text(
                          'Durasi: ${controller.routeDuration.toString()} menit',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
    );
  }
}
