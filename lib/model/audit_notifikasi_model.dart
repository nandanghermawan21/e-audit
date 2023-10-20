import 'dart:convert';

import 'package:eaudit/util/basic_response.dart';
import 'package:eaudit/util/network.dart';
import 'package:eaudit/util/system.dart';

class AuditNotificationModel {
  String? auditeeName;
  String? senderName;
  String? receiverName;
  String? notificationType;
  String? notificationDataId;
  String? notificationTitle;
  String? notificationMessage;
  DateTime? notificationTime;

  String get typeTitle {
    switch (notificationType) {
      case "matrikstindaklanjut_ml":
        return "TL ML";
      case "matrikstindaklanjut":
        return "TL";
      default:
        return notificationType ?? "";
    }
  }

   static String getTypeTitle(String? type) {
    switch (type) {
      case "matrikstindaklanjut_ml":
        return "TL ML";
      case "matrikstindaklanjut":
        return "TL";
      default:
        return type ?? "";
    }
  }

  AuditNotificationModel({
    this.auditeeName,
    this.senderName,
    this.receiverName,
    this.notificationType,
    this.notificationDataId,
    this.notificationTitle,
    this.notificationMessage,
    this.notificationTime,
  });

  factory AuditNotificationModel.fromJson(Map<String, dynamic> json) {
    return AuditNotificationModel(
      auditeeName: json['auditee_name'],
      senderName: json['sender_name'],
      receiverName: json['receiver_name'],
      notificationType: json['notification_type'],
      notificationDataId: json['notification_data_id'],
      notificationTitle: json['notification_title'],
      notificationMessage: json['notification_messages'],
      notificationTime: json['notification_time'] != null
          ? DateTime.parse(json['notification_time'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'auditee_name': auditeeName,
      'sender_name': senderName,
      'receiver_name': receiverName,
      'notification_type': notificationType,
      'notification_data_id': notificationDataId,
      'notification_title': notificationTitle,
      'notification_messages': notificationMessage,
      'notification_time': notificationTime,
    };
  }

  static Future<List<AuditNotificationModel>> get({
    required String? token,
  }) {
    return Network.get(
      url: Uri.parse(System.data.apiEndPoint.url),
      rawResult: true,
      querys: {
        "method": "data_notifikasi",
        "token": "$token",
      },
      headers: {
        "UserId": System.data.global.user?.userId ?? "",
        "groupName": System.data.global.user?.groupName ?? "",
      },
    ).then((value) {
      value = json.decode(value);
      if (value == false) {
        throw BasicResponse(message: "Data gagal ditemukan");
      }
      try {
        if ((value)["message"] != "" && (value)["message"] != null) {
          throw BasicResponse(message: (value)["message"]);
        }
      } catch (e) {
        //
      }
      return (value as List)
          .map((e) => AuditNotificationModel.fromJson(e))
          .toList();
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }

  static Future<String?> count({
    required String? token,
  }) {
    return Network.get(
      url: Uri.parse(System.data.apiEndPoint.url),
      rawResult: true,
      querys: {
        "method": "data_notifikasi_count",
        "token": "$token",
      },
      headers: {
        "UserId": System.data.global.user?.userId ?? "",
        "groupName": System.data.global.user?.groupName ?? "",
      },
    ).then((value) {
      value = json.decode(value);
      if (value == false) {
        throw BasicResponse(message: "Data gagal ditemukan");
      }
      try {
        if ((value)["message"] != "" && (value)["message"] != null) {
          throw BasicResponse(message: (value)["message"]);
        }
      } catch (e) {
        //
      }
      return (value.toString());
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }
}
