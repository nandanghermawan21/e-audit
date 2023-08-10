class RatingUnitkerja {
  String? namaAuditee;
  int? tahun;
  Map<String, String>? riwayatRating;

  RatingUnitkerja({
    this.namaAuditee,
    this.tahun,
    this.riwayatRating,
  });

  static RatingUnitkerja fromJson(Map<String, dynamic> json) {
    return RatingUnitkerja(
      namaAuditee: json["nama_auditee"],
      tahun: json["tahun"],
      riwayatRating: json["riwayat_rating"],
    );
  }

  //tojson
  Map<String, dynamic> toJson() {
    return {
      "nama_auditee": namaAuditee,
      "tahun": tahun,
      "riwayat_rating": riwayatRating,
    };
  }

  //dummys
  static List<RatingUnitkerja> getDummy() {
    return [
      RatingUnitkerja(
        namaAuditee: "Kantor Cabang Sumbawa Besar",
        tahun: 2023,
        riwayatRating: {
          "2021": "Unsatisfactory",
          "2020": "Inadequate",
          "2019": "Unsatisfactory",
        },
      ),
      RatingUnitkerja(
        namaAuditee: "Kantor Cabang Jakarta",
        tahun: 2023,
        riwayatRating: {
          "2021": "Unsatisfactory",
          "2020": "Inadequate",
          "2019": "Unsatisfactory",
        },
      ),
      RatingUnitkerja(
        namaAuditee: "Kantor Cabang surabaya",
        tahun: 2023,
        riwayatRating: {
          "2021": "Unsatisfactory",
          "2020": "Inadequate",
          "2019": "Unsatisfactory",
        },
      ),
    ];
  }
}
