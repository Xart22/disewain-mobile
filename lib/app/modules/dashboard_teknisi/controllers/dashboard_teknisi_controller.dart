import 'package:disewainaja/app/services/API/user_service.dart';
import 'package:disewainaja/app/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardTeknisiController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final _userServeice = Get.find<UserService>();
  final _locationService = Get.find<LocationService>();

  late TabController tabController;
  List<Widget> listTab = [
    const Tab(
      text: 'Baru',
    ),
    const Tab(text: 'Diproses'),
    const Tab(text: 'Selesai'),
  ];

  void requestPermission() async {
    final status = await _locationService.checkPermission();
    if (status == false) {
      await _locationService.requestPermission();
    }
  }

  void updateLocation() async {
    try {
      final location = await _locationService.getCurrentLocation();
      print('Location: ${location?.latitude}, ${location?.longitude}');
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    tabController =
        TabController(length: listTab.length, vsync: this, initialIndex: 0);
    requestPermission();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }
}
