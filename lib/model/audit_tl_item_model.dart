class AuditTLItemModel {
  String? tindakLanjut;
  DateTime? tanggal;
  String? status;

  AuditTLItemModel({
    this.tindakLanjut,
    this.tanggal,
    this.status,
  });

  factory AuditTLItemModel.fromJson(Map<String, dynamic> json) {
    return AuditTLItemModel(
      tindakLanjut: json['tindak_lanjut'],
      tanggal: json['tanggal'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['tanggal'])
          : null,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tindak_lanjut': tindakLanjut,
      'tanggal': tanggal?.millisecondsSinceEpoch,
      'status': status,
    };
  }

  //dummy
  static List<AuditTLItemModel> dummy() {
    return [
      AuditTLItemModel(
        tindakLanjut: "Tindak Lanjut 1",
        tanggal: DateTime.now(),
        status: "Disetujui Staff QA Review kabag QA",
      ),
      AuditTLItemModel(
        tindakLanjut: "Tindak Lanjut 2",
        tanggal: DateTime.now(),
        status: "Disetujui Staff QA Review kabag QA",
      ),
      AuditTLItemModel(
        tindakLanjut: "Tindak Lanjut 3",
        tanggal: DateTime.now(),
        status: "Disetujui Staff QA Review kabag QA",
      ),
    ];
  }
}
