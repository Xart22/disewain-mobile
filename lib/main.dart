import 'dart:io';

import 'package:disewainaja/app/services/fcm.dart';
import 'package:disewainaja/app/services/location_service.dart';
import 'package:disewainaja/app/services/API/user_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  await _initializeAppBindings();
  FCM().setNotifications();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // HttpOverrides.global = MyHttpOverrides();
  runApp(
    GetMaterialApp(
      title: "DisewaInAja",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  print("Handling a background message: ${message.notification!.title}");
}

Future<void> _initializeAppBindings() async {
  await Get.putAsync<LocationService>(() async => LocationService());
  await Get.putAsync<UserService>(() async => UserService());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
