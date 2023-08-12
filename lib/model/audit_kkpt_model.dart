class AuditKPTModel {
  String? id;
  String? judulTemuan;
  int? rekomendasi;
  String? status;

  AuditKPTModel({
    this.id,
    this.judulTemuan,
    this.rekomendasi,
    this.status,
  });

  static AuditKPTModel fromJson(Map<String, dynamic> json) {
    return AuditKPTModel(
      id: json["id"],
      judulTemuan: json["judul_temuan"],
      rekomendasi: json["rekomendasi"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "judul_temuan": judulTemuan,
      "rekomendasi": rekomendasi,
      "status": status,
    };
  }

  //create list dummy
  static List<AuditKPTModel> dummys({
    String? status = "PKA",
  }) {
    return [
      AuditKPTModel(
        judulTemuan: "Tidak ada SOP",
        rekomendasi: 3,
        status: status,
      ),
      AuditKPTModel(
        judulTemuan: "Tidak ada Pengawasan",
        rekomendasi: 3,
        status: status,
      ),
    ];
  }
}
