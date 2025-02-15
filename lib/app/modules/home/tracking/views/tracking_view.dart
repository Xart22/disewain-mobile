import 'package:disewainaja/app/shared/components/loading/loading.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/tracking_controller.dart';

class TrackingView extends GetView<TrackingController> {
  const TrackingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tracking ${controller.serviceRequest.noTicket}'),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: controller.ctrWebview),
            Obx(() => controller.isLoading.value
                ? Positioned.fill(
                    child: Container(
                        color: Colors.black.withOpacity(0.2),
                        child: const Loading()),
                  )
                : const SizedBox()),
          ],
        ));
  }
}
