import 'dart:convert';

import 'package:eaudit/model/audit_kkpt_model.dart';
import 'package:eaudit/util/basic_response.dart';
import 'package:eaudit/util/network.dart';
import 'package:eaudit/util/system.dart';

class AuditKKPTReviuModel {
  String? id;
  String? namakegiatan;
  String? auditee;
  String? tipeAudit;
  DateTime? tanggalAudit;
  DateTime? tanggalAuditEnd;
  String? noKKa;
  String? bidangSubtansi;
  List<AuditKKPTModel?>? listKKPT;

  AuditKKPTReviuModel({
    this.id,
    this.namakegiatan,
    this.auditee,
    this.tipeAudit,
    this.tanggalAudit,
    this.tanggalAuditEnd,
    this.noKKa,
    this.bidangSubtansi,
    this.listKKPT,
  });

  static AuditKKPTReviuModel fromJson(Map<String, dynamic> json) {
    return AuditKKPTReviuModel(
      id: json["assign_id"],
      namakegiatan: json["assign_kegiatan"],
      auditee: json["auditee_name"],
      tipeAudit: json["audit_type_name"],
      tanggalAudit: DateTime.parse(json["assign_start_date"]),
      tanggalAuditEnd: DateTime.parse(json["assign_end_date"]),
      noKKa: json["no_kka"],
      bidangSubtansi: json["bidang_subbidang"],
      listKKPT: (json["kkpt"] as List)
          .map((e) => AuditKKPTModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nama_kegiatan": namakegiatan,
      "auditee": auditee,
      "tipe_audit": tipeAudit,
      "tanggal_mulai": tanggalAudit,
      "no_kka": noKKa,
      "bidang_subbidang": bidangSubtansi,
      "list_kkpt": listKKPT?.map((e) => e?.toJson()).toList(),
    };
  }

  static Future<AuditKKPTReviuModel> get({
    required String? token,
    required String? assignId,
  }) {
    return Network.get(
      url: Uri.parse(System.data.apiEndPoint.url),
      rawResult: true,
      querys: {
        "method": "data_kkpt",
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
        return AuditKKPTReviuModel.fromJson(value);
      }
      throw BasicResponse(message: (value)["message"]);
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }

  //create list dummy
  static AuditKKPTReviuModel dummy() {
    return AuditKKPTReviuModel(
      id: "1",
      namakegiatan:
          "Pelaksanaan Kegiatan Operasional, Administrasi, dan Kepatuhan Divisi Akuntansi",
      auditee: "Divisi Akuntansi",
      tipeAudit: "Audit Umum",
      tanggalAudit: DateTime.parse("2021-09-01 08:00:00"),
      noKKa: "KKPT-2021-01",
      bidangSubtansi: "Bidang 1 - Subbidang 1",
      listKKPT: AuditKKPTModel.dummys(),
    );
  }
}
