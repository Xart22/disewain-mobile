import 'package:disewainaja/app/helper/config.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(controller.serviceRequest.noTicket),
          centerTitle: true,
          backgroundColor: Colors.white,
          forceMaterialTransparency: true,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        const Text('Informasi Pelapor',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Divider(
                          color: Colors.black,
                        ),
                        _buildRow(
                            'No Ticket', controller.serviceRequest.noTicket),
                        _buildRow(
                            'Pelapor', controller.serviceRequest.namaPelapor),
                        _buildRow('No Telepon',
                            controller.serviceRequest.noWaPelapor),
                        _buildRow(
                            'Keperluan', controller.serviceRequest.keperluan),
                        _buildRow(
                            'Deskripsi', controller.serviceRequest.message),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        const Text('Informasi Customer',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Divider(
                          color: Colors.black,
                        ),
                        _buildRow('Group',
                            controller.serviceRequest.customer.groupName),
                        _buildRow('Customer',
                            controller.serviceRequest.customer.name),
                        _buildRow('Email',
                            controller.serviceRequest.customer.email ?? '-'),
                        _buildRow('No Telepon',
                            controller.serviceRequest.customer.phoneNumber),
                        _buildRow('Alamat',
                            controller.serviceRequest.customer.address),
                        _buildRow('PIC Process',
                            controller.serviceRequest.customer.picProcess),
                        _buildRow(
                            'No Telepon',
                            controller
                                .serviceRequest.customer.picProcessPhoneNumber),
                        _buildRow('PIC Installasi',
                            controller.serviceRequest.customer.picInstallation),
                        _buildRow(
                            'No Telepon',
                            controller.serviceRequest.customer
                                .picInstallationPhoneNumber),
                        _buildRow('PIC Financial',
                            controller.serviceRequest.customer.picFinancial),
                        _buildRow(
                            'No Telepon',
                            controller.serviceRequest.customer
                                .picFinancialPhoneNumber),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        const Text('Informasi Hardware',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Divider(
                          color: Colors.black,
                        ),
                        _buildRow('Hardware',
                            controller.serviceRequest.customer.hardware.hwName),
                        _buildRow('Type',
                            controller.serviceRequest.customer.hardware.hwType),
                        _buildRow(
                            'Brand',
                            controller
                                .serviceRequest.customer.hardware.hwBrand),
                        _buildRow(
                            'Model',
                            controller
                                .serviceRequest.customer.hardware.hwModel),
                        _buildRow(
                            'S/N',
                            controller.serviceRequest.customer.hardware
                                .hwSerialNumber),
                        _buildRow(
                            'Technologi',
                            controller.serviceRequest.customer.hardware
                                    .hwTechnology ??
                                '-'),
                        _buildRow(
                            'B/W Color',
                            controller.serviceRequest.customer.hardware
                                    .hwBwColor ??
                                '-'),
                        Image.network(
                            Config.STORAGE_URL +
                                controller
                                    .serviceRequest.customer.hardware.hwImage,
                            width: Get.width * 0.8),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic, // Pastikan teks sejajar
      children: [
        // Label
        SizedBox(
          width: 80, // Berikan lebar tetap untuk label agar konsisten
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
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
