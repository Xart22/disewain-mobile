import 'package:disewainaja/app/data/models/service_request_model.dart';
import 'package:disewainaja/app/data/providers/service_request_provider.dart';
import 'package:disewainaja/app/services/API/user_service.dart';
import 'package:disewainaja/app/shared/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RekapDataController extends GetxController {
  final ServiceRequestProvider _serviceRequestProvider =
      ServiceRequestProvider();
  final _userServeice = Get.find<UserService>();

  var isLoading = true.obs;
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  var dataService = <ServiceRequest?>[].obs;

  chooseDate(bool start) async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        builder: (context, child) => Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: AppColors.primary,
                  onPrimary: Colors.black,
                  onSurface: Colors.black,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                ),
              ),
              child: child!,
            ),
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));

    if (pickedDate != null &&
        pickedDate != DateTime.now() &&
        pickedDate != DateTime(2000)) {
      if (start) {
        startDate.text = pickedDate.toString().substring(0, 10);
      } else {
        endDate.text = pickedDate.toString().substring(0, 10);
      }
    }
  }

  void getData() async {
    print(startDate.text);
    isLoading.value = true;
    try {
      final data = await _serviceRequestProvider.getDataServiceRequestByDate(
          _userServeice.token, startDate.text, endDate.text);
      print(data);
      if (data != null) {
        dataService.clear();
        dataService.value = data.data;
        isLoading.value = false;
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    startDate.text = DateTime.now().toString().substring(0, 10);
    endDate.text = DateTime.now().toString().substring(0, 10);
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
