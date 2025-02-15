import 'package:disewainaja/app/modules/home/dashboard/views/dashboard_view.dart';
import 'package:disewainaja/app/modules/home/rekap_data/views/rekap_data_view.dart';
import 'package:disewainaja/app/modules/home/settings/views/settings_view.dart';
import 'package:disewainaja/app/services/API/user_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeController extends GetxController {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final _userServeice = Get.find<UserService>();
  final currentIndex = 0.obs;
  var pages = <Widget>[
    DashboardView(),
    RekapDataView(),
    SettingsView(),
  ].obs;

  void changePage(int index) {
    currentIndex.value = index;
  }

  @override
  void onInit() async {
    super.onInit();
    _firebaseMessaging.getToken().then((token) async {
      await _userServeice.updateFcmToken(token!);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
