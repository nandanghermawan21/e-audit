import 'dart:convert';

import 'package:eaudit/util/basic_response.dart';
import 'package:eaudit/util/network.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';

class AuditRekomendasiStatusModel {
  String? id;
  String? name;
  Color? color;

  AuditRekomendasiStatusModel({
    this.id,
    this.name,
    this.color,
  });

  static AuditRekomendasiStatusModel fromJson(Map<String, dynamic> json) {
    return AuditRekomendasiStatusModel(
      id: json["value"],
      name: json["text"],
      color: json["warna"] != null
          ? Color(int.parse((json["warna"] as String).replaceAll("#", "0xff")))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "color": color?.value,
    };
  }

  static Future<List<AuditRekomendasiStatusModel>> get({
    required String? token,
  }) {
    return Network.get(
      url: Uri.parse(System.data.apiEndPoint.url),
      rawResult: true,
      querys: {
        "method": "data_tl_status",
        "token": "$token",
      },
      headers: {
        "UserId": System.data.global.user?.userId ?? "",
        "groupName": System.data.global.user?.groupName ?? "",
      },
    ).then((value) {
      value = json.decode(value);
      try {
        if ((value)["message"] != "" && (value)["message"] != null) {
          throw BasicResponse(message: (value)["message"]);
        }
      } catch (e) {
        //
      }
      return (value as List)
          .map((e) => AuditRekomendasiStatusModel.fromJson(e))
          .toList();
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }

  //dummy
  static List<AuditRekomendasiStatusModel> dummys() {
    return <AuditRekomendasiStatusModel>[
      AuditRekomendasiStatusModel(
        id: "1",
        name: "Belum Tindak Lanjut",
        color: Colors.red,
      ),
      AuditRekomendasiStatusModel(
        id: "2",
        name: "Dalam Proses Reviu Auditor",
        color: Colors.blue,
      ),
      AuditRekomendasiStatusModel(
        id: "3",
        name: "Dalam Proses Reviu Manager",
        color: Colors.orange,
      ),
      AuditRekomendasiStatusModel(
        name: "Disetujui Manager Reviu Staff QA",
        color: Colors.purple,
      ),
      AuditRekomendasiStatusModel(
        id: "4",
        name: "Disetujui Staff QA Reviu Kabag QA",
        color: Colors.green,
      ),
    ];
  }
}
