import 'package:disewainaja/app/data/models/service_request_model.dart';
import 'package:disewainaja/app/shared/components/buttons/default_button.dart';
import 'package:disewainaja/app/shared/components/loading/loading.dart';
import 'package:disewainaja/app/shared/styles/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:slider_button/slider_button.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              _buildTabBar(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      _buildWaitingTab(),
                      _buildApprovedTab(),
                    ],
                  ),
                ),
              ),
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

  // Tab Bar Widget
  Widget _buildTabBar() {
    return Card(
      color: const Color(0xFFEEEEEF),
      child: TabBar(
          controller: controller.tabController,
          tabs: controller.listTab,
          unselectedLabelColor: Colors.black,
          labelColor: Colors.white,
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primary)),
    );
  }

  // Waiting Tab
  Widget _buildWaitingTab() {
    return RefreshIndicator(
      onRefresh: controller.getData,
      child: Obx(() {
        if (controller.dataServiceRequestBaru.isEmpty) {
          return const Center(child: Text("Tidak ada data"));
        }

        return ListView.builder(
          itemCount: controller.dataServiceRequestBaru.length,
          itemBuilder: (context, index) {
            final data = controller.dataServiceRequestBaru[index]!;
            return _buildServiceRequestCard(data);
          },
        );
      }),
    );
  }

  // Approved Tab
  Widget _buildApprovedTab() {
    return RefreshIndicator(
      onRefresh: controller.getData,
      child: Obx(() {
        if (controller.dataServiceRequestDiproses.isEmpty) {
          return const Center(child: Text("Tidak ada data"));
        }

        return ListView.builder(
          itemCount: controller.dataServiceRequestDiproses.length,
          itemBuilder: (context, index) {
            final data = controller.dataServiceRequestDiproses[index]!;
            return _buildServiceRequestCard(data);
          },
        );
      }),
    );
  }

  // Service Request Card
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
            _buildInformationSection("Informasi Pelapor", [
              _buildRow("Pelapor", data.namaPelapor),
              _buildRow("No. Telepon", data.noWaPelapor),
              _buildRow("Keperluan", data.keperluan),
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
              data.statusTeknisi == "Waiting" && controller.role == "Teknisi"
                  ? _buildLocationButton(data)
                  : const SizedBox(),
            ]),
            const SizedBox(height: 10),
            controller.role == "Teknisi"
                ? _buildSliderButtons(data)
                : _buildBtnCSO(data),
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
          data.createdAt,
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
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic, // Pastikan teks sejajar
      children: [
        // Label
        SizedBox(
          width: 70, // Berikan lebar tetap untuk label agar konsisten
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        // Titik dua
        const Text(
          ":",
          style: TextStyle(fontSize: 12), // Sesuaikan ukuran teks
        ),
        // Spasi
        const SizedBox(width: 10),
        // Value
        SizedBox(
          width: Get.width * 0.6,
          child: Text(
            value,
            style: _textStyle(),
          ),
        ),
      ],
    );
  }

  // Location Button
  Widget _buildLocationButton(ServiceRequest data) {
    return ElevatedButton(
      onPressed: () {
        Get.toNamed('/maps', arguments: {
          "lat": data.customer.latitude,
          "long": data.customer.longitude,
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        minimumSize: const Size(double.infinity, 40),
      ),
      child: const Text("Lihat Lokasi", style: TextStyle(color: Colors.white)),
    );
  }

  // Slider Buttons
  Widget _buildSliderButtons(ServiceRequest data) {
    return Column(
      children: [
        data.statusTeknisi == "Waiting"
            ? SliderButton(
                action: () async {
                  controller.menujuLokasi(
                    data.customer.latitude,
                    data.customer.longitude,
                    data.id,
                  );
                  return false;
                },
                label: const Text("Menuju Lokasi"),
                icon: const Icon(Icons.arrow_forward, color: AppColors.primary),
                buttonSize: 40,
                height: 50,
                backgroundColor: AppColors.primary,
                buttonColor: Colors.white,
                width: Get.width,
              )
            : const SizedBox(),
        const SizedBox(height: 10),
        data.statusTeknisi == "Waiting"
            ? SliderButton(
                action: () async {
                  controller.formTolak(data.id, false);
                  return false;
                },
                label: const Text("Tolak"),
                icon: const Icon(Icons.arrow_forward, color: Colors.red),
                backgroundColor: Colors.red,
                buttonColor: Colors.white,
                width: Get.width,
                buttonSize: 40,
                height: 50,
              )
            : const SizedBox(),
        data.statusTeknisi == "On The Way"
            ? Column(
                children: [
                  DefaultButton(
                      text: "Menuju Lokasi",
                      color: Colors.green,
                      onPressed: () {
                        controller.openGoogleMaps(
                            double.parse(data.customer.latitude),
                            double.parse(data.customer.longitude));
                      }),
                  const SizedBox(height: 10),
                  SliderButton(
                    action: () async {
                      controller.sampaiLokasi(data);
                      return false;
                    },
                    label: const Text("Sampai di Lokasi"),
                    icon: const Icon(Icons.arrow_forward,
                        color: AppColors.primary),
                    buttonSize: 40,
                    height: 50,
                    backgroundColor: AppColors.primary,
                    buttonColor: Colors.white,
                    width: Get.width,
                  ),
                  const SizedBox(height: 10),
                  SliderButton(
                    action: () async {
                      controller.formTolak(data.id, true);
                      return false;
                    },
                    label: const Text("Cancel"),
                    icon: const Icon(Icons.arrow_forward, color: Colors.red),
                    backgroundColor: Colors.red,
                    buttonColor: Colors.white,
                    width: Get.width,
                    buttonSize: 40,
                    height: 50,
                  )
                ],
              )
            : const SizedBox(),
        data.statusTeknisi == "Arrived"
            ? Column(
                children: [
                  SliderButton(
                    action: () async {
                      controller.mulaiPekerjaan(data.id);
                      return false;
                    },
                    label: const Text("Mulai Pengerjaan"),
                    icon: const Icon(Icons.arrow_forward,
                        color: AppColors.primary),
                    buttonSize: 40,
                    height: 50,
                    backgroundColor: Colors.green,
                    buttonColor: Colors.white,
                    width: Get.width,
                  ),
                  const SizedBox(height: 10),
                  SliderButton(
                    action: () async {
                      controller.formTolak(data.id, true);
                      return false;
                    },
                    label: const Text("Cancel"),
                    icon: const Icon(Icons.arrow_forward, color: Colors.red),
                    backgroundColor: Colors.red,
                    buttonColor: Colors.white,
                    width: Get.width,
                    buttonSize: 40,
                    height: 50,
                  )
                ],
              )
            : const SizedBox(),
        data.statusTeknisi == "Working"
            ? Column(
                children: [
                  SliderButton(
                    action: () async {
                      controller.selesaiPekerjaan(data.id);
                      return false;
                    },
                    label: const Text("Selesai Pengerjaan"),
                    icon: const Icon(Icons.arrow_forward,
                        color: AppColors.primary),
                    buttonSize: 40,
                    height: 50,
                    backgroundColor: Colors.green,
                    buttonColor: Colors.white,
                    width: Get.width,
                  ),
                  const SizedBox(height: 10),
                  SliderButton(
                    action: () async {
                      controller.formTolak(data.id, true);
                      return false;
                    },
                    label: const Text("Cancel"),
                    icon: const Icon(Icons.arrow_forward, color: Colors.red),
                    backgroundColor: Colors.red,
                    buttonColor: Colors.white,
                    width: Get.width,
                    buttonSize: 40,
                    height: 50,
                  )
                ],
              )
            : const SizedBox(),
      ],
    );
  }

  Widget _buildBtnCSO(ServiceRequest data) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DefaultButton(
                text: 'Detail',
                onPressed: () => {
                      Get.toNamed('/detail', arguments: data),
                    },
                width: Get.width / 4),
            data.statusCso != "Waiting"
                ? DefaultButton(
                    text: 'Logs',
                    onPressed: () => {
                          Get.toNamed('/logs', arguments: data),
                        },
                    width: Get.width / 4,
                    color: Colors.yellow[800])
                : const SizedBox(),
            DefaultButton(
                text: 'Chat',
                onPressed: () => {
                      controller.sendChat(data.id),
                    },
                width: Get.width / 4,
                color: Colors.green),
          ],
        ),
        const SizedBox(height: 10),
        data.statusCso == "Responded"
            ? data.teknisi != null
                ? DefaultButton(
                    text: 'Tracking',
                    onPressed: () => {
                          Get.toNamed('/tracking', arguments: data),
                        },
                    color: Colors.blue,
                    width: Get.width)
                : DefaultButton(
                    text: 'Pilih Teknisi',
                    onPressed: () => {controller.getUserTeknisi(data.id)},
                    color: Colors.black,
                    width: Get.width)
            : const SizedBox(),
      ],
    );
  }

  // Text Style Helper
  TextStyle _textStyle({double fontSize = 12}) {
    return TextStyle(fontSize: fontSize);
  }
}
