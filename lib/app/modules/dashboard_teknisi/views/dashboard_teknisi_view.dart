import 'package:disewainaja/app/shared/styles/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dashboard_teknisi_controller.dart';

class DashboardTeknisiView extends GetView<DashboardTeknisiController> {
  const DashboardTeknisiView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/logo/sewainaja-blue.png',
          width: 150,
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              child: Card(
                color: Color(0xFFEEEEEF),
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
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: TabBarView(
                  controller: controller.tabController,
                  children: [waiting(), approved(), rejected()],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget waiting() {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text("Data $index"),
            subtitle: Text("Data $index"),
          ),
        );
      },
    );
  }

  Widget approved() {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text("Data $index"),
            subtitle: Text("Data $index"),
          ),
        );
      },
    );
  }

  Widget rejected() {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text("Data $index"),
            subtitle: Text("Data $index"),
          ),
        );
      },
    );
  }
}
