import 'package:disewainaja/app/data/models/service_request_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogsController extends GetxController {
  ServiceRequest log = Get.arguments;

  var logs = <DataRow>[].obs;

  void getLogs() {
    if (log.logs != null) {
      for (var i = 0; i < log.logs!.length; i++) {
        logs.add(DataRow(cells: [
          DataCell(Text(log.logs![i].user.name)),
          DataCell(Text(log.logs![i].message)),
          DataCell(Text(log.logs![i].createdAt)),
        ]));
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    getLogs();
  }
}
