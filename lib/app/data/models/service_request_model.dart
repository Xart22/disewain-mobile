import 'dart:convert';

import 'package:disewainaja/app/data/models/user_model.dart';

ServiceRequestModel serviceRequestModelFromJson(String str) =>
    ServiceRequestModel.fromJson(json.decode(str));

String serviceRequestModelToJson(ServiceRequestModel data) =>
    json.encode(data.toJson());

class ServiceRequestModel {
  final List<ServiceRequest?> data;

  ServiceRequestModel({
    required this.data,
  });

  factory ServiceRequestModel.fromJson(Map<String, dynamic> json) =>
      ServiceRequestModel(
        data: List<ServiceRequest>.from(
            json["data"].map((x) => ServiceRequest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x?.toJson())),
      };
}

class ServiceRequest {
  final int id;
  final String noTicket;
  final int customerId;
  final String namaPelapor;
  final String noWaPelapor;
  final String keperluan;
  final String message;
  final int? respondedBy;
  final int? teknisiId;
  final String? statusTeknisi;
  final String statusCso;
  final String statusProcess;
  final String? waktuRespon;
  final String? waktuPerjalanan;
  final String? waktuPengerjaan;
  final String? waktuSelesai;
  final String createdAt;
  final String? updatedAt;
  final User? cso;
  final Customer customer;
  final User? teknisi;
  final List<Log>? logs;

  ServiceRequest({
    required this.id,
    required this.noTicket,
    required this.customerId,
    required this.namaPelapor,
    required this.noWaPelapor,
    required this.keperluan,
    required this.message,
    required this.respondedBy,
    required this.teknisiId,
    required this.statusTeknisi,
    required this.statusCso,
    required this.statusProcess,
    required this.waktuRespon,
    required this.waktuPerjalanan,
    required this.waktuPengerjaan,
    required this.waktuSelesai,
    required this.createdAt,
    required this.updatedAt,
    required this.cso,
    required this.customer,
    required this.teknisi,
    required this.logs,
  });

  factory ServiceRequest.fromJson(Map<String, dynamic> json) => ServiceRequest(
        id: json["id"],
        noTicket: json["no_ticket"],
        customerId: json["customer_id"],
        namaPelapor: json["nama_pelapor"],
        noWaPelapor: json["no_wa_pelapor"],
        keperluan: json["keperluan"],
        message: json["message"],
        respondedBy: json["responded_by"],
        teknisiId: json["teknisi_id"],
        statusTeknisi: json["status_teknisi"],
        statusCso: json["status_cso"],
        statusProcess: json["status_process"],
        waktuRespon: json["waktu_respon"],
        waktuPerjalanan: json["waktu_perjalanan"],
        waktuPengerjaan: json["waktu_pengerjaan"],
        waktuSelesai: json["waktu_selesai"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"]?.toString(),
        cso: json["cso"] == null ? null : User.fromJson(json["cso"]),
        customer: Customer.fromJson(json["customer"]),
        teknisi:
            json["teknisi"] == null ? null : User.fromJson(json["teknisi"]),
        logs: List<Log>.from(json["logs"].map((x) => Log.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "no_ticket": noTicket,
        "customer_id": customerId,
        "nama_pelapor": namaPelapor,
        "no_wa_pelapor": noWaPelapor,
        "keperluan": keperluan,
        "message": message,
        "responded_by": respondedBy,
        "teknisi_id": teknisiId,
        "status_teknisi": statusTeknisi,
        "status_cso": statusCso,
        "status_process": statusProcess,
        "waktu_respon": waktuRespon,
        "waktu_perjalanan": waktuPerjalanan,
        "waktu_pengerjaan": waktuPengerjaan,
        "waktu_selesai": waktuSelesai,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "cso": cso?.toJson(),
        "customer": customer.toJson(),
        "teknisi": teknisi?.toJson(),
        "logs": List<dynamic>.from(logs!.map((x) => x.toJson())),
      };
}

class teknisi {
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
  final String fcmToken;
  final DateTime createdAt;
  final DateTime updatedAt;

  teknisi({
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
    required this.fcmToken,
    required this.createdAt,
    required this.updatedAt,
  });

  factory teknisi.fromJson(Map<String, dynamic> json) => teknisi(
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
        fcmToken: json["fcm_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
        "fcm_token": fcmToken,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Customer {
  final int id;
  final String name;
  final String groupName;
  final dynamic email;
  final String phoneNumber;
  final String address;
  final String latitude;
  final String longitude;
  final String picProcess;
  final String picProcessPhoneNumber;
  final String picInstallation;
  final String picInstallationPhoneNumber;
  final String picFinancial;
  final String picFinancialPhoneNumber;
  final DateTime contractStart;
  final DateTime expiredAt;
  final int isActive;
  final int hwId;
  final DateTime createdAt;
  final dynamic updatedAt;
  final Hardware hardware;

  Customer({
    required this.id,
    required this.name,
    required this.groupName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.picProcess,
    required this.picProcessPhoneNumber,
    required this.picInstallation,
    required this.picInstallationPhoneNumber,
    required this.picFinancial,
    required this.picFinancialPhoneNumber,
    required this.contractStart,
    required this.expiredAt,
    required this.isActive,
    required this.hwId,
    required this.createdAt,
    required this.updatedAt,
    required this.hardware,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        groupName: json["group_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        picProcess: json["pic_process"],
        picProcessPhoneNumber: json["pic_process_phone_number"],
        picInstallation: json["pic_installation"],
        picInstallationPhoneNumber: json["pic_installation_phone_number"],
        picFinancial: json["pic_financial"],
        picFinancialPhoneNumber: json["pic_financial_phone_number"],
        contractStart: DateTime.parse(json["contract_start"]),
        expiredAt: DateTime.parse(json["expired_at"]),
        isActive: json["is_active"],
        hwId: json["hw_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        hardware: Hardware.fromJson(json["hardware"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "group_name": groupName,
        "email": email,
        "phone_number": phoneNumber,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "pic_process": picProcess,
        "pic_process_phone_number": picProcessPhoneNumber,
        "pic_installation": picInstallation,
        "pic_installation_phone_number": picInstallationPhoneNumber,
        "pic_financial": picFinancial,
        "pic_financial_phone_number": picFinancialPhoneNumber,
        "contract_start": contractStart.toIso8601String(),
        "expired_at": expiredAt.toIso8601String(),
        "is_active": isActive,
        "hw_id": hwId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
        "hardware": hardware.toJson(),
      };
}

class Hardware {
  final int id;
  final String hwName;
  final String hwType;
  final String hwBrand;
  final String hwModel;
  final String hwSerialNumber;
  final String hwImage;
  final String? hwRelocation;
  final String? hwTechnology;
  final String? hwBwColor;
  final String hwDescription;
  final int usedStatus;
  final int customerId;
  final DateTime updatedAt;

  Hardware({
    required this.id,
    required this.hwName,
    required this.hwType,
    required this.hwBrand,
    required this.hwModel,
    required this.hwSerialNumber,
    required this.hwImage,
    required this.hwRelocation,
    required this.hwTechnology,
    required this.hwBwColor,
    required this.hwDescription,
    required this.usedStatus,
    required this.customerId,
    required this.updatedAt,
  });

  factory Hardware.fromJson(Map<String, dynamic> json) => Hardware(
        id: json["id"],
        hwName: json["hw_name"],
        hwType: json["hw_type"],
        hwBrand: json["hw_brand"],
        hwModel: json["hw_model"],
        hwSerialNumber: json["hw_serial_number"],
        hwImage: json["hw_image"],
        hwRelocation: json["hw_relocation"],
        hwTechnology: json["hw_technology"],
        hwBwColor: json["hw_bw_color"],
        hwDescription: json["hw_description"],
        usedStatus: json["used_status"],
        customerId: json["customer_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "hw_name": hwName,
        "hw_type": hwType,
        "hw_brand": hwBrand,
        "hw_model": hwModel,
        "hw_serial_number": hwSerialNumber,
        "hw_image": hwImage,
        "hw_relocation": hwRelocation,
        "hw_technology": hwTechnology,
        "hw_bw_color": hwBwColor,
        "hw_description": hwDescription,
        "used_status": usedStatus,
        "customer_id": customerId,
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Log {
  final int id;
  final int customerSupportId;
  final int userId;
  final String status;
  final String message;
  final String createdAt;
  final DateTime updatedAt;
  final User user;

  Log({
    required this.id,
    required this.customerSupportId,
    required this.userId,
    required this.status,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory Log.fromJson(Map<String, dynamic> json) => Log(
        id: json["id"],
        customerSupportId: json["customer_support_id"],
        userId: json["user_id"],
        status: json["status"],
        message: json["message"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_support_id": customerSupportId,
        "user_id": userId,
        "status": status,
        "message": message,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
      };
}
