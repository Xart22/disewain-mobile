import 'package:disewainaja/app/services/API/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  final _userServeice = Get.find<UserService>();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  void logout() async {
    await _userServeice.logout();
    Get.offAllNamed('/login');
  }
}
