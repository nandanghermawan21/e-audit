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
      namaAuditor: json["nama_auditor"],
      namaAuditee: json["nama_auditee"],
      posisi: json["posisi"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "nama_auditor": namaAuditor,
      "nama_auditee": namaAuditee,
      "posisi": posisi,
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
