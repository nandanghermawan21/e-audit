class AuditPaModel {
  String? id;
  String? divisi;
  DateTime? tanggal;
  String? kegiatan;
  String? status;
  int? menungguReviu;

  AuditPaModel({
    this.id,
    this.divisi,
    this.tanggal,
    this.kegiatan,
    this.status,
    this.menungguReviu,
  });

  static AuditPaModel fromJson(Map<String, dynamic> json) {
    return AuditPaModel(
      id: json["id"],
      divisi: json["divisi"],
      tanggal: DateTime.parse(json["tanggal"]),
      kegiatan: json["kegiatan"],
      status: json["status"],
      menungguReviu: json["menunggu_reviu"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "divisi": divisi,
      "tanggal": tanggal,
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
        tanggal: DateTime.parse("2021-09-01 08:00:00"),
        kegiatan:
            "Pelaksanaan Kegiatan Operasional, Administrasi, dan Kepatuhan Divisi Akuntansi",
        status: status,
        menungguReviu: 3,
      ),
      AuditPaModel(
        id: "46",
        divisi: "Divisi Umum",
        tanggal: DateTime.parse("2021-09-01 08:00:00"),
        kegiatan:
            "Pelaksanaan Kegiatan Operasional, Administrasi, dan Kepatuhan Divisi Umum P3DN Tahap 2",
        status: status,
        menungguReviu: 2,
      ),
    ];
  }
}
