import 'dart:convert';

import 'package:eaudit/model/audit_kka_model.dart';
import 'package:eaudit/util/basic_response.dart';
import 'package:eaudit/util/network.dart';
import 'package:eaudit/util/system.dart';

class AuditkaReviuModel {
  String? id;
  String? kegiatan;
  String? auditee;
  String? tipeAudit;
  DateTime? startDate;
  DateTime? endDate;
  List<AuditKKAModel?>? listKka;

  AuditkaReviuModel({
    this.id,
    this.tipeAudit,
    this.auditee,
    this.kegiatan,
    this.startDate,
    this.endDate,
    this.listKka,
  });

  static AuditkaReviuModel fromJson(Map<String, dynamic> json) {
    return AuditkaReviuModel(
      id: json["assign_id"],
      kegiatan: json["assign_kegiatan"],
      auditee: json["auditee_name"],
      tipeAudit: json["audit_type_name"],
      startDate: DateTime.parse(json["assign_start_date"]),
      endDate: DateTime.parse(json["assign_end_date"]),
      listKka: json["kertas_kerja"] != null
          ? List<AuditKKAModel>.from(
              json["kertas_kerja"].map((x) => AuditKKAModel.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nama_kegiatan": kegiatan,
      "auditee": auditee,
      "tipe_audit": tipeAudit,
      "tanggal_mulai": startDate,
      "tanggal_selesai": endDate,
      "kertas_kerja": listKka?.map((e) => e?.toJson()).toList(),
    };
  }

  static Future<AuditkaReviuModel> get({
    required String? token,
    required String? assignId,
  }) {
    return Network.get(
      url: Uri.parse(System.data.apiEndPoint.url),
      rawResult: true,
      querys: {
        "method": "data_kertas_kerja",
        "assign_id": "$assignId",
        "token": "$token",
      },
      headers: {
        "UserId": System.data.global.user?.userId ?? "",
        "groupName": System.data.global.user?.groupName ?? "",
      },
    ).then((value) {
      value = json.decode(value);
      if ((value)["message"] == "" || (value)["message"] == null) {
        return AuditkaReviuModel.fromJson(value);
      }
      throw BasicResponse(message: (value)["message"]);
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }

  //create list dummy
  static AuditkaReviuModel dummy() {
    return AuditkaReviuModel(
        id: "1",
        tipeAudit: "Divisi Akuntansi",
        auditee: "Andreas",
        kegiatan: "ASET - Penilaian",
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        listKka: AuditKKAModel.dummys());
  }
}
