import 'dart:convert';

UserResepon userReseponFromJson(String str) =>
    UserResepon.fromJson(json.decode(str));

String userReseponToJson(UserResepon data) => json.encode(data.toJson());

class UserResepon {
  final String? token;
  final User user;

  UserResepon({
    this.token,
    required this.user,
  });

  factory UserResepon.fromJson(Map<String, dynamic> json) => UserResepon(
        token: json["token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
      };
}

class User {
  final int id;
  final String nip;
  final String name;
  final String role;
  final String? avatar;
  final String? deviceId;
  final String? phoneNumber;
  final String? lokasiKerja;
  final String? latitude;
  final String? longitude;
  final String? fcmtoken;
  final DateTime createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.nip,
    required this.name,
    required this.role,
    required this.avatar,
    required this.deviceId,
    required this.phoneNumber,
    required this.lokasiKerja,
    required this.latitude,
    required this.longitude,
    required this.fcmtoken,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        nip: json["nip"],
        name: json["name"],
        role: json["role"],
        avatar: json["avatar"],
        deviceId: json["device_id"],
        phoneNumber: json["phone_number"],
        lokasiKerja: json["lokasi_kerja"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        fcmtoken: json["fcmtoken"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nip": nip,
        "name": name,
        "role": role,
        "avatar": avatar,
        "device_id": deviceId,
        "phone_number": phoneNumber,
        "lokasi_kerja": lokasiKerja,
        "latitude": latitude,
        "longitude": longitude,
        "fcmtoken": fcmtoken,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
