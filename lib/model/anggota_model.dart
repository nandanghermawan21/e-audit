class AnggotaModel {
  String? namaAuditor;
  String? namaAuditee;
  String? posisi;

  AnggotaModel({
    this.namaAuditor,
    this.namaAuditee,
    this.posisi,
  });

  static AnggotaModel fromJson(Map<String, dynamic> json) {
    return AnggotaModel(
      namaAuditor: json["auditor_name"],
      namaAuditee: json["auditee_name"],
      posisi: json["posisi_name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "auditor_name": namaAuditor,
      "auditee_name": namaAuditee,
      "posisi_name": posisi,
    };
  }

  //create list dummy
  static List<AnggotaModel> dummys() {
    return [
      AnggotaModel(
        namaAuditor: "Andry Septianto",
        namaAuditee: "Divisi Akuntansi",
        posisi: "Penanggung Jawab",
      ),
      AnggotaModel(
        namaAuditor: "Agus Mirazul Fajar",
        namaAuditee: "Manager Audit",
        posisi: "Auditor",
      ),
      AnggotaModel(
        namaAuditor: "Aulia Vantie Fajriani",
        namaAuditee: "Ketua Tim",
        posisi: "Auditor",
      ),
      AnggotaModel(
        namaAuditor: "Andreas Theodorus Mokodaser",
        namaAuditee: "Anggota Tim",
        posisi: "Auditor",
      ),
    ];
  }
}
