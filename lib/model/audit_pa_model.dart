class AuditPaModel {
  String? id;
  String? divisi;
  DateTime? tanggalMulai;
  DateTime? tanggalSelesai;
  String? kegiatan;
  String? status;
  int? menungguReviu;

  AuditPaModel({
    this.id,
    this.divisi,
    this.tanggalMulai,
    this.tanggalSelesai,
    this.kegiatan,
    this.status,
    this.menungguReviu,
  });

  static AuditPaModel fromJson(Map<String, dynamic> json) {
    return AuditPaModel(
      id: json["id"],
      divisi: json["divisi"],
      tanggalMulai: DateTime.parse(json["tanggal_mulai"]),
      tanggalSelesai: DateTime.parse(json["tanggal_selesai"]),
      kegiatan: json["kegiatan"],
      status: json["status"],
      menungguReviu: json["menunggu_reviu"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "divisi": divisi,
      "tanggal_mulai": tanggalMulai,
      "tanggal_selesai": tanggalSelesai,
      "kegiatan": kegiatan,
      "status": status,
      "menunggu_reviu": menungguReviu,
    };
  }

  //create list dummy
  static List<AuditPaModel> dummys({
    String? status = "PKA",
  }) {
    return [
      AuditPaModel(
        id: "45",
        divisi: "Divisi Akuntansi",
        tanggalMulai: DateTime.parse("2021-09-01 08:00:00"),
        tanggalSelesai: DateTime.parse("2021-09-10 08:00:00"),
        kegiatan:
            "Pelaksanaan Kegiatan Operasional, Administrasi, dan Kepatuhan Divisi Akuntansi",
        status: status,
        menungguReviu: 3,
      ),
      AuditPaModel(
        id: "46",
        divisi: "Divisi Umum",
        tanggalMulai: DateTime.parse("2021-09-10 08:00:00"),
        tanggalSelesai: DateTime.parse("2021-09-15 08:00:00"),
        kegiatan:
            "Pelaksanaan Kegiatan Operasional, Administrasi, dan Kepatuhan Divisi Umum P3DN Tahap 2",
        status: status,
        menungguReviu: 2,
      ),
    ];
  }
}
