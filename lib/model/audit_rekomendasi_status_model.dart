import 'package:flutter/material.dart';

class AuditRekomendasiStatusModel {
  int? id;
  String? name;
  Color? color;

  AuditRekomendasiStatusModel({
    this.id,
    this.name,
    this.color,
  });

  static AuditRekomendasiStatusModel fromJson(Map<String, dynamic> json) {
    return AuditRekomendasiStatusModel(
      id: json["id"],
      name: json["name"],
      color: json["color"] != null ? Color(json["color"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "color": color?.value,
    };
  }

  //dummy
  static List<AuditRekomendasiStatusModel> dummys() {
    return <AuditRekomendasiStatusModel>[
      AuditRekomendasiStatusModel(
        id: 1,
        name: "Belum Tindak Lanjut",
        color: Colors.red,
      ),
      AuditRekomendasiStatusModel(
        id: 2,
        name: "Dalam Proses Reviu Auditor",
        color: Colors.blue,
      ),
      AuditRekomendasiStatusModel(
        id: 3,
        name: "Dalam Proses Reviu Manager",
        color: Colors.orange,
      ),
      AuditRekomendasiStatusModel(
        name: "Disetujui Manager Reviu Staff QA",
        color: Colors.purple,
      ),
      AuditRekomendasiStatusModel(
        id: 4,
        name: "Disetujui Staff QA Reviu Kabag QA",
        color: Colors.green,
      ),
    ];
  }
}
