import 'package:eaudit/model/audit_kkpt_model.dart';

class ReviuKkptModel {
  String? id;
  String? namakegiatan;
  String? auditee;
  DateTime? tanggalAudit;
  String? noKKa;
  String? bidangSubbidang;
  List<AuditKPTModel>? listKKPT;

  ReviuKkptModel({
    this.id,
    this.namakegiatan,
    this.auditee,
    this.tanggalAudit,
    this.noKKa,
    this.bidangSubbidang,
    this.listKKPT,
  });

  static ReviuKkptModel fromJson(Map<String, dynamic> json) {
    return ReviuKkptModel(
      id: json["id"],
      namakegiatan: json["nama_kegiatan"],
      auditee: json["auditee"],
      tanggalAudit: DateTime.parse(json["tanggal_audit"]),
      noKKa: json["no_kka"],
      bidangSubbidang: json["bidang_subbidang"],
      listKKPT: (json["list_kkpt"] as List)
          .map((e) => AuditKPTModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nama_kegiatan": namakegiatan,
      "auditee": auditee,
      "tanggal_audit": tanggalAudit,
      "no_kka": noKKa,
      "bidang_subbidang": bidangSubbidang,
      "list_kkpt": listKKPT?.map((e) => e.toJson()).toList(),
    };
  }

  //create list dummy
  static ReviuKkptModel dummy() {
    return ReviuKkptModel(
      id: "1",
      namakegiatan:
          "Pelaksanaan Kegiatan Operasional, Administrasi, dan Kepatuhan Divisi Akuntansi",
      auditee: "Divisi Akuntansi",
      tanggalAudit: DateTime.parse("2021-09-01 08:00:00"),
      noKKa: "KKPT-2021-01",
      bidangSubbidang: "Bidang 1 - Subbidang 1",
      listKKPT: AuditKPTModel.dummys(),
    );
  }
}
