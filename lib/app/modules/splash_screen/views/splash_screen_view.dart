import 'package:disewainaja/app/shared/components/loading/loading.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/logo/sewainaja-blue.png',
                width: Get.width * 0.5),
          ),
          const SizedBox(height: 10),
          Loading(
            size: 20,
          ),
        ],
      ),
    );
  }
}
