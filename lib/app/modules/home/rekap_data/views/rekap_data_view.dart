import 'package:disewainaja/app/data/models/service_request_model.dart';
import 'package:disewainaja/app/shared/components/buttons/default_button.dart';
import 'package:disewainaja/app/shared/components/inputs/text/Input_field.dart';
import 'package:disewainaja/app/shared/components/loading/loading.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/rekap_data_controller.dart';

class RekapDataView extends GetView<RekapDataController> {
  const RekapDataView({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: Get.width / 3,
                    child: InputField(
                        label: "Start Date",
                        textInputAction: TextInputAction.next,
                        controller: controller.startDate,
                        readOnly: true,
                        onTap: () => controller.chooseDate(true)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Text(
                      "-",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                      width: Get.width / 3,
                      child: InputField(
                          label: "End Date",
                          textInputAction: TextInputAction.next,
                          controller: controller.endDate,
                          readOnly: true,
                          onTap: () => controller.chooseDate(false))),
                ],
              ),
              SizedBox(height: 16),
              DefaultButton(
                onPressed: () {
                  controller.getData();
                },
                text: "Get Data",
              ),
              SizedBox(height: 16),
              Expanded(
                child: Obx(() => ListView.builder(
                      itemCount: controller.dataService.length,
                      itemBuilder: (context, index) {
                        final data = controller.dataService[index]!;
                        return _buildServiceRequestCard(data);
                      },
                    )),
              )
            ],
          ),
        ),
        Obx(() => controller.isLoading.value
            ? Positioned.fill(
                child: Container(
                    color: Colors.black.withOpacity(0.2),
                    child: const Loading()),
              )
            : const SizedBox()),
      ],
    );
  }

  Widget _buildServiceRequestCard(ServiceRequest data) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildServiceHeader(data),
            const SizedBox(height: 10),
            _buildInformationSection("Informasi Pelaporan", [
              _buildRow("Pelapor", data.namaPelapor),
              _buildRow("No. Telepon", data.noWaPelapor),
              _buildRow("Keluhan", data.message),
            ]),
            const SizedBox(height: 10),
            _buildInformationSection("Informasi Hardware", [
              Text(data.customer.hardware.hwName, style: _textStyle()),
            ]),
            const SizedBox(height: 10),
            _buildInformationSection("Informasi Customer", [
              Text(data.customer.name, style: _textStyle()),
              Text(data.customer.address, style: _textStyle()),
              const SizedBox(height: 8),
            ]),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // Header Section
  Widget _buildServiceHeader(ServiceRequest data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          data.createdAt.toString(),
          style: _textStyle(fontSize: 12),
        ),
        Text(
          data.noTicket,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // Information Section
  Widget _buildInformationSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        const SizedBox(
          height: 10,
          child: Divider(
            color: Colors.black,
          ),
        ),
        ...children,
      ],
    );
  }

  // Row Widget
  Widget _buildRow(String label, String value) {
    return Row(
      children: [
        Text(
          "$label : ",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        Text(value, style: _textStyle()),
      ],
    );
  }

  // Text Style Helper
  TextStyle _textStyle({double fontSize = 12}) {
    return TextStyle(fontSize: fontSize);
  }
}
