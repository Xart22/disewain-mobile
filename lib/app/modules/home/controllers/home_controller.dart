import 'package:disewainaja/app/modules/home/dashboard_teknisi/views/dashboard_teknisi_view.dart';
import 'package:disewainaja/app/services/API/user_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeController extends GetxController {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final _userServeice = Get.find<UserService>();
  final currentIndex = 0.obs;
  var pages = <Widget>[].obs;

  void changePage(int index) {
    currentIndex.value = index;
  }

  void getPages() async {
    final user = _userServeice.user;
    if (user.role == "Teknisi") {
      pages.addAll([
        DashboardTeknisiView(),
        Text("Service Request"),
        Text("Profile"),
      ]);
    } else {
      pages.addAll([
        Text("Dashboard"),
        Text("Service Request"),
        Text("Profile"),
      ]);
    }
  }

  @override
  void onInit() async {
    if (Get.arguments != null) {
      if (Get.arguments.role == "Teknisi") {
        pages.addAll([
          DashboardTeknisiView(),
          Text("Service Request"),
          Text("Profile"),
        ]);
      } else {
        pages.addAll([
          Text("Dashboard"),
          Text("Service Request"),
          Text("Profile"),
        ]);
      }
    } else {
      getPages();
    }
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
