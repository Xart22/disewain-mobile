import 'package:disewainaja/app/shared/components/buttons/default_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          DefaultButton(text: "Change Password", onPressed: () {}),
          SizedBox(height: 16),
          DefaultButton(
              text: "Logout",
              onPressed: () {
                controller.logout();
              }),
        ],
      ),
    );
  }
}
