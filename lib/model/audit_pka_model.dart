import 'dart:convert';

import 'package:eaudit/model/anggota_model.dart';
import 'package:eaudit/model/program_audit_model.dart';
import 'package:eaudit/util/basic_response.dart';
import 'package:eaudit/util/network.dart';
import 'package:eaudit/util/system.dart';

class AuditPKAModel {
  String? id;
  String? namaKegiatan;
  String? auditee;
  String? tipeAudit;
  DateTime? tanggalAudit;
  DateTime? tanggalAuditEnd;
  List<AnggotaModel>? anggota;
  List<ProgramAuditModel>? programAudit;

  AuditPKAModel({
    this.id,
    this.namaKegiatan,
    this.auditee,
    this.tipeAudit,
    this.tanggalAudit,
    this.tanggalAuditEnd,
    this.anggota,
    this.programAudit,
  });

  static AuditPKAModel fromJson(Map<String, dynamic> json) {
    return AuditPKAModel(
      id: json["assign_id"],
      namaKegiatan: json["assign_kegiatan"],
      auditee: json["auditee_name"],
      tipeAudit: json["audit_type_name"],
      tanggalAudit: DateTime.parse(json["assign_start_date"]),
      tanggalAuditEnd: DateTime.parse(json["assign_end_date"]),
      anggota: (json["anggota"] as List)
          .map((e) => AnggotaModel.fromJson(e))
          .toList(),
      programAudit: (json["program_audit"] as List)
          .map((e) => ProgramAuditModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nama_kegiatan": namaKegiatan,
      "auditee": auditee,
      "tipe_audit": tipeAudit,
      "tanggal_mulai": tanggalAudit,
      "anggota": anggota?.map((e) => e.toJson()).toList(),
    };
  }

  static Future<AuditPKAModel> get({
    required String? token,
    required String? assignId,
  }) {
    return Network.get(
      url: Uri.parse(System.data.apiEndPoint.url),
      rawResult: true,
      querys: {
        "method": "data_program_audit",
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
        return AuditPKAModel.fromJson(value);
      }
      throw BasicResponse(message: (value)["message"]);
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }

  //create list dummy
  static AuditPKAModel dummy() {
    return AuditPKAModel(
      id: "1",
      namaKegiatan:
          "Pelaksanaan Kegiatan Operasional, Administrasi, dan Kepatuhan Divisi Akuntansi",
      auditee: "Divisi Akuntansi",
      tipeAudit: "PKA",
      tanggalAudit: DateTime.parse("2021-09-01 08:00:00"),
      anggota: AnggotaModel.dummys(),
      programAudit: ProgramAuditModel.dummys(),
    );
  }
}
