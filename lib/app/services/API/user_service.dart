import 'package:disewainaja/app/data/models/user_model.dart';
import 'package:disewainaja/app/data/providers/user_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserService extends GetxService {
  final storage = GetStorage();
  final UserProvider _userProvider = UserProvider();

  bool get isLoggedIn => storage.hasData('auth_token');

  String get token => storage.read('auth_token');

  void saveToken(String token) {
    storage.write('auth_token', token);
  }

  void removeToken() {
    storage.remove('auth_token');
  }

  Future<User?> me() async {
    if (!isLoggedIn) return null;
    try {
      final response = await _userProvider.me(token);
      return response.user;
    } catch (e) {
      return null;
    }
  }

  //update fcm token
  Future<void> updateFcmToken(String fcmToken) async {
    try {
      await _userProvider.updateFcmToken(token, fcmToken);
    } catch (e) {
      return;
    }
  }

  // update location
  Future<void> updateLocation(double latitude, double longitude) async {
    try {
      await _userProvider.updateLocation(token, latitude, longitude);
    } catch (e) {
      return;
    }
  }
}
