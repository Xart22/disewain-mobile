import 'package:disewainaja/app/services/API/user_service.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  final _userServeice = Get.find<UserService>();

  Future<void> checkUser() async {
    bool isLogin = _userServeice.isLoggedIn;
    await Future.delayed(Duration(seconds: 2));
    if (isLogin) {
      final user = await _userServeice.me();

      if (user != null) {
        if (user.role == 'CSO') {
          Get.offAllNamed('/CSO');
        }
        if (user.role == 'Teknisi') {
          Get.offAllNamed('/dashboard-teknisi');
        }
      } else {
        Get.offAllNamed('/login');
      }
    } else {
      Get.offAllNamed('/login');
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await checkUser();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
