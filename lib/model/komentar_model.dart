class KomentarModel {
  DateTime? tanggal;
  String? name;
  String? komentar;

  KomentarModel({
    this.tanggal,
    this.name,
    this.komentar,
  });

  static KomentarModel fromJson(Map<String, dynamic> json,
      {String? tanggalKey, String? nameKey, String? komentarKey}) {
    return KomentarModel(
      tanggal: json[tanggalKey ?? "comment_date"] == null
          ? null
          : DateTime.parse(json[tanggalKey ?? "comment_date"]),
      name: json[nameKey ?? "auditor_name"],
      komentar: json[komentarKey ?? "comment_desc"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "comment_date": tanggal?.toIso8601String(),
      "auditor_name": name,
      "comment_desc": komentar,
    };
  }

  static List<KomentarModel> dummy() {
    return [
      KomentarModel(
        tanggal: DateTime.now().add(const Duration(days: -1)),
        name: "Rocy",
        komentar: "Komentar 1",
      ),
      KomentarModel(
        tanggal: DateTime.now().add(const Duration(hours: -9)),
        name: "Dudung",
        komentar: "Komentar 2",
      ),
      KomentarModel(
        tanggal: DateTime.now().add(const Duration(minutes: -34)),
        name: "Yoman",
        komentar: "Komentar 3",
      ),
    ];
  }
}
