import 'package:eaudit/model/kertas_kerja_audit.dart';

class ReviuKkaModel {
  String? objectAudit;
  String? auditor;
  String? judulProgram;
  String? proseduAudit;
  List<KertasKerjaAudit?>? listKka;

  ReviuKkaModel({
    this.objectAudit,
    this.auditor,
    this.judulProgram,
    this.proseduAudit,
    this.listKka,
  });

  static ReviuKkaModel fromJson(Map<String, dynamic> json) {
    return ReviuKkaModel(
      objectAudit: json["object_audit"],
      auditor: json["auditor"],
      judulProgram: json["judul_program"],
      proseduAudit: json["prosedu_audit"],
      listKka: json["list_kka"] != null
          ? List<KertasKerjaAudit>.from(
              json["list_kka"].map((x) => KertasKerjaAudit.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "object_audit": objectAudit,
      "auditor": auditor,
      "judul_program": judulProgram,
      "prosedu_audit": proseduAudit,
      "list_kka": listKka != null
          ? List<dynamic>.from(listKka!.map((x) => x?.toJson()))
          : null,
    };
  }

  //create list dummy
  static ReviuKkaModel dummy() {
    return ReviuKkaModel(
        objectAudit: "Divisi Akuntansi",
        auditor: "Andreas",
        judulProgram: "ASET - Penilaian",
        proseduAudit:
            "1. Periksa akun biaya perbaikan dan pemeliharaan.\n 2. Analisa kewajaran biaya penyusutan berdasarkan nilai perolehan aktiva\n dan tarif depresiasi yang berlaku. \n3. Lakukan test penghitungan kembali penyusutan.",
        listKka: KertasKerjaAudit.dummys());
  }
}
