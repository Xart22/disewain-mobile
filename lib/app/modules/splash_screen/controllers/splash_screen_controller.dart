import 'package:disewainaja/app/services/API/user_service.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  final _userServeice = Get.find<UserService>();
  var isLoading = true.obs;

  Future<void> checkUser() async {
    bool isLogin = _userServeice.isLoggedIn;
    await Future.delayed(Duration(seconds: 2));
    if (isLogin) {
      final user = await _userServeice.me();

      if (user != null) {
        Get.offAllNamed('/home');
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
