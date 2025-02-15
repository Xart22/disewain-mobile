import 'package:disewainaja/app/data/models/service_request_model.dart';
import 'package:disewainaja/app/helper/config.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TrackingController extends GetxController {
  // Argument yang diterima melalui Get.arguments
  late final ServiceRequest serviceRequest;
  late final String url;

  // WebViewController untuk mengelola WebView
  late final WebViewController ctrWebview;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Inisialisasi serviceRequest dari Get.arguments
    serviceRequest = Get.arguments;

    // Bangun URL tracking
    url =
        '${Config.BASE_URL.replaceAll("/api", "")}/tracking?id=${serviceRequest.noTicket}';

    // Inisialisasi WebViewController
    ctrWebview = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Tambahkan log untuk progress
          },
          onPageStarted: (String url) {
            // Tambahkan log untuk halaman yang mulai dimuat
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            // Tambahkan log untuk halaman yang selesai dimuat
            isLoading.value = false;
          },
          onHttpError: (HttpResponseError error) {
            // Log untuk HTTP error
            isLoading.value = false;
          },
          onWebResourceError: (WebResourceError error) {
            // Log untuk error pada sumber daya web
            isLoading.value = false;
          },
          onNavigationRequest: (NavigationRequest request) {
            // Blokir navigasi ke domain tertentu (contoh: YouTube)
            if (request.url.startsWith('https://www.youtube.com/')) {
              print('Navigation blocked: ${request.url}');
              return NavigationDecision.prevent;
            }
            print('Navigation allowed: ${request.url}');
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }
}
