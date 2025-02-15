import 'package:dio/dio.dart';
import 'package:disewainaja/app/data/models/service_request_model.dart';
import 'package:disewainaja/app/helper/config.dart';
import 'package:latlong2/latlong.dart';

class ServiceRequestProvider {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Config.BASE_URL,
      connectTimeout: Duration(milliseconds: 5000),
      receiveTimeout: Duration(milliseconds: 3000),
    ),
  );

  Future<ServiceRequestModel?> getDataServiceRequestCso(String token) async {
    try {
      final response = await _dio.get('/customer-support/get-customer-support',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
      if (response.statusCode == 200) {
        return ServiceRequestModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<String?> sendChat(String token, int id) async {
    try {
      final response = await _dio.get('/customer-support/send-chat/$id',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
      if (response.statusCode == 200) {
        print(response.data['link']);
        return response.data['link'];
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<ServiceRequestModel?> getDataServiceRequestTeknisi(
      String token) async {
    try {
      final response = await _dio.get('/teknisi/get-customer-support',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
      if (response.statusCode == 200) {
        return ServiceRequestModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<ServiceRequestModel?> getDataServiceRequestByDate(
      String token, String start, String end) async {
    try {
      final response =
          await _dio.get('/teknisi/get-customer-support/$start/$end',
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                },
              ));
      if (response.statusCode == 200) {
        return ServiceRequestModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> updateStatusByTeknisi(
      String token, int id, String status, String? message) async {
    try {
      final response = await _dio.post('/teknisi/update-status-teknisi/$id',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
          data: {
            'status': status,
            'message': message,
          });
      ;
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> assignTeknisi(String token, int id, int teknisiId) async {
    try {
      final response = await _dio.post('/customer-support/assign-teknisi',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
          data: {
            'id': id,
            'teknisi_id': teknisiId,
          });
      ;
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchRoute(LatLng start, LatLng end) async {
    try {
      final response = await _dio.get(
        'https://routing.openstreetmap.de/routed-car/route/v1/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?overview=full&geometries=geojson',
      );
      if (response.statusCode == 200) {
        final data = response.data;
        // format durasi ke menit
        final duration = data['routes'][0]['duration'] ~/ 60;
        // format jarak ke kilometer
        final distance = data['routes'][0]['distance'] / 1000;
        return {
          'duration': duration, // Durasi dalam menit
          'distance': distance, // Jarak dalam meter
          'geometry': data['routes'][0]['geometry'], // Geometri rute (GeoJSON)
        };
      } else {
        throw Exception('Failed to fetch route');
      }
    } catch (e) {
      rethrow;
    }
  }
}
