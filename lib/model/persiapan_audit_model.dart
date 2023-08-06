class PersiapanAuditModel {
  String? divisi;
  DateTime? tanggal;
  String? kegiatan;
  String? status;
  int? menungguReviu;

  PersiapanAuditModel({
    this.divisi,
    this.tanggal,
    this.kegiatan,
    this.status,
    this.menungguReviu,
  });

  static PersiapanAuditModel fromJson(Map<String, dynamic> json) {
    return PersiapanAuditModel(
      divisi: json["divisi"],
      tanggal: DateTime.parse(json["tanggal"]),
      kegiatan: json["kegiatan"],
      status: json["status"],
      menungguReviu: json["menunggu_reviu"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "divisi": divisi,
      "tanggal": tanggal,
      "kegiatan": kegiatan,
      "status": status,
      "menunggu_reviu": menungguReviu,
    };
  }

  //create list dummy
  static List<PersiapanAuditModel> dummysPKA() {
    return [
      PersiapanAuditModel(
        divisi: "Divisi Akuntansi",
        tanggal: DateTime.parse("2021-09-01 08:00:00"),
        kegiatan:
            "Pelaksanaan Kegiatan Operasional, Administrasi, dan Kepatuhan Divisi Akuntansi",
        status: "PKA",
        menungguReviu: 3,
      ),
      PersiapanAuditModel(
        divisi: "Divisi Umum",
        tanggal: DateTime.parse("2021-09-01 08:00:00"),
        kegiatan:
            "Pelaksanaan Kegiatan Operasional, Administrasi, dan Kepatuhan Divisi Umum P3DN Tahap 2",
        status: "PKA",
        menungguReviu: 2,
      ),
    ];
  }
}
