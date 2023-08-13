class AuditFileModel {
  String? id;
  String? name;
  String? url;

  AuditFileModel({
    this.id,
    this.name,
    this.url,
  });

  factory AuditFileModel.fromJson(Map<String, dynamic> json) {
    return AuditFileModel(
      id: json['id'],
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
    };
  }

  //dummy
  static List<AuditFileModel> dummy() {
    return [
      AuditFileModel(
        id: "1",
        name: "lampiran 1",
        url:
            "https://pslb3.menlhk.go.id/internal/uploads/pengumuman/1545111808_contoh-pdf.pdf",
      ),
      AuditFileModel(
        id: "2",
        name: "Lampiran 2",
        url:
            "https://pslb3.menlhk.go.id/internal/uploads/pengumuman/1545111808_contoh-pdf.pdf",
      ),
      AuditFileModel(
        id: "3",
        name: "lampiran 3",
        url:
            "https://pslb3.menlhk.go.id/internal/uploads/pengumuman/1545111808_contoh-pdf.pdf",
      ),
    ];
  }
}
