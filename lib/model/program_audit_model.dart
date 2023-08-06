class ProgramAuditModel {
  String? judul;
  String? status;
  int? totalKKA;
  int? totalTemuan;
  int? totalRekomendasi;

  //constructor
  ProgramAuditModel({
    this.judul,
    this.status,
    this.totalKKA,
    this.totalTemuan,
    this.totalRekomendasi,
  });

  //convert json to model
  static ProgramAuditModel fromJson(Map<String, dynamic> json) {
    return ProgramAuditModel(
      judul: json["judul"],
      status: json["status"],
      totalKKA: json["total_kka"],
      totalTemuan: json["total_temuan"],
      totalRekomendasi: json["total_rekomendasi"],
    );
  }

  //convert model to json
  Map<String, dynamic> toJson() {
    return {
      "judul": judul,
      "status": status,
      "total_kka": totalKKA,
      "total_temuan": totalTemuan,
      "total_rekomendasi": totalRekomendasi,
    };
  }

  //create list dummy
  static List<ProgramAuditModel> dummys() {
    return [
      ProgramAuditModel(
        judul: "ASET - Penilaian (Agus Mirazul Fajar)",
        status: "Menunggu Approve",
        totalKKA: 0,
        totalTemuan: 0,
        totalRekomendasi: 0,
      ),
      ProgramAuditModel(
        judul: "ASET - Penilaian (Agus Mirazul Fajar)",
        status: "Menunggu Approve",
        totalKKA: 0,
        totalTemuan: 0,
        totalRekomendasi: 0,
      ),
      ProgramAuditModel(
        judul: "ASET - Penilaian ((Agus Mirazul Fajar))",
        status: "Menunggu Approve",
        totalKKA: 0,
        totalTemuan: 0,
        totalRekomendasi: 0,
      ),
    ];
  }
}
