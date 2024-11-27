import 'package:dio/dio.dart';
import 'package:disewainaja/app/helper/config.dart';
import '../models/user_model.dart';

class UserProvider {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Config.BASE_URL,
      connectTimeout: Duration(milliseconds: 5000),
      receiveTimeout: Duration(milliseconds: 3000),
    ),
  );

  Future<UserResepon> login(String nip, String password) async {
    try {
      final response = await _dio.post('/login', data: {
        'nip': nip,
        'password': password,
      });
      if (response.statusCode == 200) {
        return UserResepon.fromJson(response.data);
      } else {
        throw Exception('Nip atau password salah');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserResepon> me(String token) async {
    try {
      final response = await _dio.get('/me',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
      if (response.statusCode == 200) {
        return UserResepon.fromJson(response.data);
      } else {
        throw Exception('Gagal mengambil data');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateFcmToken(String token, String fcmToken) async {
    try {
      await _dio.post('/update-profile',
          data: {
            'fcm_token': fcmToken,
          },
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateLocation(
      String token, double latitude, double longitude) async {
    try {
      await _dio.post('/update-profile',
          data: {
            'latitude': latitude,
            'longitude': longitude,
          },
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
    } catch (e) {
      rethrow;
    }
  }
}
