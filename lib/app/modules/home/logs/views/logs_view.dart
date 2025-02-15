import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/logs_controller.dart';

class LogsView extends GetView<LogsController> {
  const LogsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logs ${controller.log.noTicket}'),
        centerTitle: true,
        forceMaterialTransparency: true,
      ),
      body: SingleChildScrollView(
        child: DataTable(
          border: TableBorder.all(),
          dataTextStyle: const TextStyle(fontSize: 12),
          columnSpacing: Get.width * 0.1,
          headingTextStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          columns: const <DataColumn>[
            DataColumn(
              label: Text('User'),
            ),
            DataColumn(
              label: Text('Message'),
            ),
            DataColumn(
              label: Text('Date'),
            ),
          ],
          rows: controller.logs,
        ),
      ),
    );
  }
}
