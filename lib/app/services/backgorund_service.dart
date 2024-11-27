import 'dart:async';

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
    androidConfiguration: AndroidConfiguration(
        autoStart: true,
        onStart: onStart,
        isForegroundMode: true,
        autoStartOnBoot: true,
        foregroundServiceNotificationId: 888,
        initialNotificationTitle: 'Tracking Location',
        initialNotificationContent:
            'Fitur ini membantu CSO untuk melacak lokasi Anda',
        foregroundServiceTypes: [
          AndroidForegroundType.location,
        ]),
  );
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) {
  final storage = GetStorage();
  if (service is AndroidServiceInstance) {
    service.on('stopService').listen((event) {
      print('stopService');
      service.stopSelf();
    });
  }

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      print('setAsForeground');
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      print('setAsBackground');
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    print('stopService');
    service.stopSelf();
  });

  Timer.periodic(const Duration(seconds: 5), (timer) async {
    print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');
    final isTracking = storage.read('isTracking') ?? false;
    print('isTracking: $isTracking');

    if (!isTracking) {
      timer.cancel();
      service.stopSelf();
      return;
    }
    Position position = await Geolocator.getCurrentPosition(
      locationSettings:
          LocationSettings(accuracy: LocationAccuracy.bestForNavigation),
    );
    service.invoke('updateLocation', {
      'latitude': position.latitude,
      'longitude': position.longitude,
    });
  });
}
