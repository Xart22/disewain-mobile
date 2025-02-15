import 'package:disewainaja/app/data/models/service_request_model.dart';
import 'package:disewainaja/app/data/providers/service_request_provider.dart';
import 'package:disewainaja/app/data/providers/user_provider.dart';
import 'package:disewainaja/app/services/API/user_service.dart';
import 'package:disewainaja/app/services/location_service.dart';
import 'package:disewainaja/app/shared/components/buttons/default_button.dart';
import 'package:disewainaja/app/shared/components/inputs/select/select_search.dart';
import 'package:disewainaja/app/shared/components/inputs/text/Input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardController extends FullLifeCycleController
    with GetSingleTickerProviderStateMixin, FullLifeCycleMixin {
  final storage = GetStorage();
  final _userServeice = Get.find<UserService>();
  final UserProvider _userProvider = UserProvider();
  final _locationService = Get.find<LocationService>();
  final ServiceRequestProvider _serviceRequestProvider =
      ServiceRequestProvider();
  TextEditingController alasanController = TextEditingController();
  late String role;

  //data
  var dataServiceRequestBaru = <ServiceRequest?>[].obs;
  var dataServiceRequestDiproses = <ServiceRequest?>[].obs;

  var availableMaps = <AvailableMap>[];

  late TabController tabController;
  List<Widget> listTab = [
    const Tab(
      text: 'Baru',
    ),
    const Tab(text: 'Diproses'),
  ];

  var isLoading = true.obs;

  void sendChat(int id) async {
    isLoading.value = true;
    try {
      final link =
          await _serviceRequestProvider.sendChat(_userServeice.token, id);
      if (link != null) {
        await launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication);
      }
      await getData();
      isLoading.value = false;
    } catch (e) {
      Get.snackbar('Gagal', 'Gagal mengirim chat',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  void startTracking() async {
    final service = FlutterBackgroundService();
    bool isRunning = await service.isRunning();
    if (!isRunning) {
      await service.startService();
    }
    await storage.write('isTracking', true);
    FlutterBackgroundService().on('updateLocation').listen((data) async {
      if (data != null) {
        await _userServeice.updateLocation(
          data['latitude'],
          data['longitude'],
        );
      } else {
        _updateLocation();
      }
    });
  }

  void stopTracking() {
    storage.write('isTracking', false);
    FlutterBackgroundService().invoke('stopService');
  }

  void requestPermission() async {
    final status = await _locationService.checkPermission();
    if (status == false) {
      await _locationService.requestPermission();
    } else {
      _updateLocation();
    }
  }

  void _updateLocation() async {
    try {
      final location = await _locationService.getCurrentLocation();
      await _userServeice.updateLocation(
        location!.latitude,
        location.longitude,
      );
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  Future<void> getData() async {
    isLoading.value = true;

    if (role == "CSO" || role == "Admin") {
      try {
        final data = await _serviceRequestProvider
            .getDataServiceRequestCso(_userServeice.token);
        if (data != null) {
          dataServiceRequestBaru.clear();
          dataServiceRequestDiproses.clear();
          dataServiceRequestBaru.value = data.data
              .where((element) => element?.statusCso == 'Waiting')
              .toList();
          dataServiceRequestDiproses.value = data.data
              .where((element) => element?.statusCso == 'Responded')
              .toList();
        }
        tabController.index = dataServiceRequestBaru.isEmpty ? 1 : 0;
        isLoading.value = false;
      } catch (e, s) {
        print(e);
        print(s);
      }
    } else {
      try {
        final data = await _serviceRequestProvider
            .getDataServiceRequestTeknisi(_userServeice.token);
        if (data != null) {
          dataServiceRequestBaru.clear();
          dataServiceRequestDiproses.clear();
          dataServiceRequestBaru.value = data.data
              .where((element) => element?.statusTeknisi == 'Waiting')
              .toList();
          dataServiceRequestDiproses.value = data.data
              .where((element) =>
                  element?.statusTeknisi == 'On The Way' ||
                  element?.statusTeknisi == 'Arrived' ||
                  element?.statusTeknisi == 'Working')
              .toList();
        }
        tabController.index = dataServiceRequestBaru.isEmpty ? 1 : 0;
        isLoading.value = false;
      } catch (e, s) {
        print(e);
        print(s);
      }
    }
  }

  void formTolak(int id, bool cancel) {
    alasanController.clear();
    Get.defaultDialog(
      title: 'Alasan Penolakan',
      contentPadding: const EdgeInsets.all(15),
      content: InputField(
        controller: alasanController,
        maxLines: 3,
        label: 'Alasan Penolakan',
        textInputAction: TextInputAction.done,
      ),
      actions: [
        DefaultButton(
          width: 100,
          height: 40,
          onPressed: () {
            cancelService(id, cancel);
          },
          text: 'Kirim',
        ),
        DefaultButton(
          width: 100,
          height: 40,
          color: Colors.red,
          onPressed: () {
            Get.back();
          },
          text: 'Batal',
        ),
      ],
    );
  }

  void selesaiPekerjaan(int id) async {
    isLoading.value = true;
    final response = await _serviceRequestProvider.updateStatusByTeknisi(
      _userServeice.token,
      id,
      'Done',
      null,
    );
    await getData();
    if (response) {
      Get.snackbar('Berhasil', 'Berhasil mengubah status',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } else {
      Get.snackbar('Gagal', 'Gagal mengubah status',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
    isLoading.value = false;
  }

  void mulaiPekerjaan(int id) async {
    isLoading.value = true;
    final response = await _serviceRequestProvider.updateStatusByTeknisi(
      _userServeice.token,
      id,
      'Working',
      null,
    );
    await getData();
    if (response) {
      Get.snackbar('Berhasil', 'Berhasil mengubah status',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } else {
      Get.snackbar('Gagal', 'Gagal mengubah status',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
    isLoading.value = false;
  }

  void menujuLokasi(String lat, String long, int id) async {
    final response = await _serviceRequestProvider.updateStatusByTeknisi(
      _userServeice.token,
      id,
      'OTW',
      null,
    );
    stopTracking();
    if (response) {
      openGoogleMaps(double.parse(lat), double.parse(long));
    } else {
      Get.snackbar('Gagal', 'Gagal mengubah status');
    }
  }

  void sampaiLokasi(ServiceRequest data) async {
    isLoading.value = true;
    final validateDistance = await _locationService.calculateDistance(
      double.parse(data.customer.latitude),
      double.parse(data.customer.longitude),
    );
    stopTracking();
    if (validateDistance['status']) {
      final response = await _serviceRequestProvider.updateStatusByTeknisi(
        _userServeice.token,
        data.id,
        'Arrived',
        null,
      );
      if (response) {
        Get.snackbar('Berhasil', 'Berhasil mengubah status',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      } else {
        Get.snackbar('Gagal', 'Gagal mengubah status',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } else {
      Get.snackbar('Gagal', validateDistance['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
    await getData();
    isLoading.value = false;
  }

  void cancelService(int id, bool cancel) async {
    if (alasanController.text.isEmpty) {
      Get.snackbar('Gagal', 'Alasan penolakan tidak boleh kosong',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }
    Get.back();
    isLoading.value = true;
    final response = await _serviceRequestProvider.updateStatusByTeknisi(
      _userServeice.token,
      id,
      cancel ? 'Cancel' : 'Di Tolak',
      alasanController.text,
    );
    await getData();
    if (response) {
      Get.snackbar('Berhasil', 'Berhasil membatalkan layanan',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } else {
      Get.snackbar('Gagal', 'Gagal membatalkan layanan',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
    isLoading.value = false;
  }

  void openGoogleMaps(double lat, double long) async {
    try {
      startTracking();
      await _locationService.availableMaps.first
          .showDirections(destination: Coords(lat, long));
    } catch (e) {
      print('Error opening Google Maps: $e');
    }
  }

  void getUserTeknisi(int id) async {
    try {
      int teknisiId = 0;
      isLoading.value = true;
      final data = await _userProvider.getUserTeknisi(_userServeice.token);
      isLoading.value = false;
      Get.defaultDialog(
        title: 'Pilih Teknisi',
        content: SelectSearch(
          label: 'Teknisi',
          data: data,
          onChanged: (value) {
            if (value != null) {
              teknisiId = value.id;
            }
          },
        ),
        actions: [
          DefaultButton(
              width: Get.width / 4,
              height: Get.height / 20,
              onPressed: () async {
                isLoading.value = true;
                if (teknisiId != 0) {
                  final res = await _serviceRequestProvider.assignTeknisi(
                      _userServeice.token, id, teknisiId);
                  if (res) {
                    Get.back();
                    Get.snackbar('Berhasil', 'Berhasil mengassign teknisi',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green,
                        colorText: Colors.white);
                    await getData();
                  } else {
                    Get.snackbar('Gagal', 'Gagal mengassign teknisi',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white);
                  }
                } else {
                  Get.snackbar('Gagal', 'Pilih teknisi terlebih dahulu',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white);
                }
                isLoading.value = false;
              },
              text: 'Kirim'),
          DefaultButton(
            width: Get.width / 4,
            height: Get.height / 20,
            color: Colors.red,
            onPressed: () {
              Get.back();
            },
            text: 'Tutup',
          ),
        ],
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() async {
    tabController = TabController(
        length: listTab.length,
        vsync: this,
        initialIndex: dataServiceRequestBaru.isEmpty ? 1 : 0);

    if (Get.arguments != null) {
      role = Get.arguments.role;
    } else {
      role = _userServeice.user.role;
    }
    super.onInit();
    await getData();
    availableMaps = await MapLauncher.installedMaps;
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

  @override
  void onDetached() {
    print('onDetached');
  }

  @override
  void onHidden() {
    print('onHidden');
  }

  @override
  void onInactive() async {
    await getData();
  }

  @override
  void onPaused() async {
    await getData();
  }

  @override
  void onResumed() async {
    await getData();
  }
}
