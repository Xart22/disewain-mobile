import 'package:disewainaja/app/data/providers/user_provider.dart';
import 'package:disewainaja/app/services/API/user_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final storage = GetStorage();
  final UserProvider _userProvider = UserProvider();
  final UserService _userService = Get.find<UserService>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var usernameError = ''.obs;
  var passwordError = ''.obs;
  var isShowPassword = false.obs;
  var buttonEnabled = false.obs;
  var isLoading = false.obs;

  Future<void> login() async {
    try {
      if (!validate()) return;
      final response = await _userProvider.login(
        usernameController.text,
        passwordController.text,
      );
      if (response.token != null) {
        _userService.saveToken(response.token!);
        _userService.saveUser(response.user);
      }
      Get.offAllNamed('/home', arguments: response.user);
    } catch (e) {
      usernameError.value = 'Nip atau password salah';
      passwordError.value = 'Nip atau password salah';
    }
  }

  bool validate() {
    if (usernameController.text.isEmpty) {
      usernameError.value = 'Nip tidak boleh kosong';
      return false;
    } else if (passwordController.text.isEmpty) {
      passwordError.value = 'Password tidak boleh kosong';
      return false;
    } else {
      usernameError.value = '';
      passwordError.value = '';
      return true;
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
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
