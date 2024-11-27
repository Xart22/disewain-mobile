import 'package:get/get.dart';

import '../controllers/dashboard_teknisi_controller.dart';

class DashboardTeknisiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardTeknisiController>(
      () => DashboardTeknisiController(),
    );
  }
}
