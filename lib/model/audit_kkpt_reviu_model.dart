import 'package:eaudit/model/audit_kkpt_model.dart';

class AuditKKPTReviuModel {
  String? id;
  String? namakegiatan;
  String? auditee;
  String? tipeAudit;
  DateTime? tanggalAudit;
  String? noKKa;
  String? bidangSubtansi;
  List<AuditKKPTModel?>? listKKPT;

  AuditKKPTReviuModel({
    this.id,
    this.namakegiatan,
    this.auditee,
    this.tipeAudit,
    this.tanggalAudit,
    this.noKKa,
    this.bidangSubtansi,
    this.listKKPT,
  });

  static AuditKKPTReviuModel fromJson(Map<String, dynamic> json) {
    return AuditKKPTReviuModel(
      id: json["id"],
      namakegiatan: json["nama_kegiatan"],
      auditee: json["auditee"],
      tipeAudit: json["tipe_audit"],
      tanggalAudit: DateTime.parse(json["tanggal_audit"]),
      noKKa: json["no_kka"],
      bidangSubtansi: json["bidang_subbidang"],
      listKKPT: (json["list_kkpt"] as List)
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
      "tanggal_audit": tanggalAudit,
      "no_kka": noKKa,
      "bidang_subbidang": bidangSubtansi,
      "list_kkpt": listKKPT?.map((e) => e?.toJson()).toList(),
    };
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
