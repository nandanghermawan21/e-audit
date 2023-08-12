class AuditRekomendasiModel {
  String? deskripsi;
  String? status;
  int? sisaHariTindakLanjut;

  AuditRekomendasiModel({
    this.deskripsi,
    this.status,
    this.sisaHariTindakLanjut,
  });

  static AuditRekomendasiModel fromJson(Map<String, dynamic> json) {
    return AuditRekomendasiModel(
      deskripsi: json["deskripsi"],
      status: json["status"],
      sisaHariTindakLanjut: json["sisa_hari_tindak_lanjut"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "deskripsi": deskripsi,
      "status": status,
      "sisa_hari_tindak_lanjut": sisaHariTindakLanjut,
    };
  }

  //dummy
  static List<AuditRekomendasiModel> dummys() {
    return <AuditRekomendasiModel>[
      AuditRekomendasiModel(
        deskripsi:
            "Pemimpin Cabang Serang agar memberikan instruksi tertulis kepada Manajer Bisnis KC Serang untuk mempedomani SLA Penerbitan SP KBG pada setiap pengajuan proses penjaminan.",
        status: "Selesai",
        sisaHariTindakLanjut: 10,
      ),
      AuditRekomendasiModel(
        deskripsi:
            "Untuk selanjutnya, Pemimpin Cabang KC Serang agar lebih memperhatikan SLA dalam menerbitkan SP Kontra Bank Garansi.",
        status: "Belum Tindak Lanjut",
        sisaHariTindakLanjut: 10,
      ),
    ];
  }
}
