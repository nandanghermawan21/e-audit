class RatingTemuanModel {
  String? namaAuditee;
  String? judulTemuan;

  RatingTemuanModel({
    this.namaAuditee,
    this.judulTemuan,
  });

  static RatingTemuanModel fromJson(Map<String, dynamic> json) {
    return RatingTemuanModel(
      namaAuditee: json["nama_auditee"] as String?,
      judulTemuan: json["judul_temuan"] as String?,
    );
  }

  //tojson
  Map<String, dynamic> toJson() {
    return {
      "nama_auditee": namaAuditee,
      "judul_temuan": judulTemuan,
    };
  }

  //dummys
  static List<RatingTemuanModel> getDummy() {
    return [
      RatingTemuanModel(
        namaAuditee: "Kantor Cabang Sumbawa Besar",
        judulTemuan: "Kesalahan Proses Penerbitan Sertifikat Penjaminan...",
      ),
      RatingTemuanModel(
        namaAuditee: "Kantor Cabang Jakarta",
        judulTemuan: "Penerbitan Sertifikat Penjaminan atas Terjamin...",
      ),
      RatingTemuanModel(
        namaAuditee: "Kantor Cabang surabaya",
        judulTemuan: "Pembayaran IJP Surety Bond Diterima secara Tunai...",
      ),
      RatingTemuanModel(
        namaAuditee: "Kantor Cabang surabaya",
        judulTemuan: "Penjaminan Suretybond Tidak Memenuhi Kriteria UMKM...",
      ),
    ];
  }
}
