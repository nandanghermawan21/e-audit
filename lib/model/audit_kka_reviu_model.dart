import 'package:eaudit/model/audit_kka_model.dart';

class AuditkaReviuModel {
  String? id;
  String? objectAudit;
  String? auditor;
  String? judulProgram;
  String? proseduAudit;
  List<AuditKKAModel?>? listKka;

  AuditkaReviuModel({
    this.id,
    this.objectAudit,
    this.auditor,
    this.judulProgram,
    this.proseduAudit,
    this.listKka,
  });

  static AuditkaReviuModel fromJson(Map<String, dynamic> json) {
    return AuditkaReviuModel(
      id: json["id"],
      objectAudit: json["object_audit"],
      auditor: json["auditor"],
      judulProgram: json["judul_program"],
      proseduAudit: json["prosedu_audit"],
      listKka: json["list_kka"] != null
          ? List<AuditKKAModel>.from(
              json["list_kka"].map((x) => AuditKKAModel.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "object_audit": objectAudit,
      "auditor": auditor,
      "judul_program": judulProgram,
      "prosedu_audit": proseduAudit,
      "list_kka": listKka?.map((e) => e?.toJson()).toList(),
    };
  }

  //create list dummy
  static AuditkaReviuModel dummy() {
    return AuditkaReviuModel(
        id: "1",
        objectAudit: "Divisi Akuntansi",
        auditor: "Andreas",
        judulProgram: "ASET - Penilaian",
        proseduAudit:
            "1. Periksa akun biaya perbaikan dan pemeliharaan.\n 2. Analisa kewajaran biaya penyusutan berdasarkan nilai perolehan aktiva\n dan tarif depresiasi yang berlaku. \n3. Lakukan test penghitungan kembali penyusutan.",
        listKka: AuditKKAModel.dummys());
  }
}
